import fs from 'fs';
import unzipper from 'unzipper';
import { Octokit } from '@octokit/core';

const token = process.env.GITHUB_TOKEN;
const [owner, repo] = process.env.GITHUB_REPOSITORY.split('/');
const eventName = process.env.GITHUB_EVENT_NAME;

const octokit = new Octokit({ auth: token });

async function main() {
  let runId;

  if (eventName === 'workflow_run') {
    const eventData = JSON.parse(fs.readFileSync(process.env.GITHUB_EVENT_PATH, 'utf8'));
    runId = eventData.workflow_run.id;
  }

  async function findArtifact() {
    if (runId) {
      // If triggered by workflow_run, get artifacts from the triggering run
      const artifacts = await octokit.request('GET /repos/{owner}/{repo}/actions/runs/{run_id}/artifacts', {
        owner,
        repo,
        run_id: runId,
      });
      return artifacts.data.artifacts.find(a => a.name === 'terraform-plan');
    } else {
      // If triggered manually, get the latest successful run of the plan workflow
      const workflows = await octokit.request('GET /repos/{owner}/{repo}/actions/workflows/{workflow_id}/runs', {
        owner,
        repo,
        workflow_id: 'tf-plan.yml', // Replace with your actual workflow file name
        event: 'workflow_dispatch',
        status: 'success',
      });
      if (!workflows.data.workflow_runs.length) {
        throw new Error('No successful workflow runs found for the plan workflow.');
      }
      for (const run of workflows.data.workflow_runs) {
        const artifacts = await octokit.request('GET /repos/{owner}/{repo}/actions/runs/{run_id}/artifacts', {
          owner,
          repo,
          run_id: run.id,
        });
        const artifact = artifacts.data.artifacts.find(a => a.name === 'terraform-plan');
        if (artifact) {
          return artifact;
        }
      }
    }
    return null;
  }

  const artifact = await findArtifact();
  if (!artifact) {
    throw new Error('Artifact not found');
  }

  const download = await octokit.request('GET /repos/{owner}/{repo}/actions/artifacts/{artifact_id}/{archive_format}', {
    owner,
    repo,
    artifact_id: artifact.id,
    archive_format: 'zip',
    headers: {
      Accept: 'application/vnd.github+json',
    },
  });

  const response = await fetch(download.url, {
    headers: {
      Authorization: `Bearer ${token}`,
      Accept: 'application/vnd.github+json',
    },
  });

  if (!response.ok) {
    throw new Error(`Failed to download artifact: ${response.statusText}`);
  }

  await new Promise((resolve, reject) => {
    response.body
      .pipe(unzipper.Extract({ path: './infra' }))
      .on('close', resolve)
      .on('error', reject);
  });

  console.log('Artifact downloaded and extracted to ./infra');
}

main().catch(error => {
  console.error(error);
  process.exit(1);
});
