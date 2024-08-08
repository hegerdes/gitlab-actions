# GitLab CI/CD Components: helm-deploy

## Usage

Use this component to package helm charts via [helm](https://helm.sh/docs/) in CI.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/helm-package@<VERSION>
    inputs:
      chart: <MY_CHART_PATH>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `HELM:package` job to the pipeline.


The template should work without modifications, when the `DIMAGE_TOKEN` variable (containing the base64 basic auth token for the container registry) is set but you can customize the template settings.
## Inputs

| Input             | Default value             | Description                                                       |
| ----------------- | ------------------------- | ----------------------------------------------------------------- |
| `stage`           | `build`                   | The stage where you want the job to be added                      |
| `job_name_prefix` | `HELM`                    | The CI job name prefix.                                           |
| `image`           | `alpine/helm:latest`      | The container image for doing scanning                            |
| `chart`           | *REQUIRED*                | The helm chart path in the repo.                                  |
| `chart_version`   | ""                        | The helm chart version. Default is the version in Chart.yaml.     |
| `app_version`     | ""                        | The helm chart app version. Default is the version in Chart.yaml. |
| `chart_publish`   | `true`                    | If the chart should be published.                                 |
| `chart_repo`      | `$CI_API_V4_URL`          | The chart repo url to upload to.                                  |
| `chart_repo_user` | ""                        | The helm repo user name. Only needed if repo is NOT GitLab.       |
| `chart_repo_user` | ""                        | The helm repo user name. Only needed if repo is NOT GitLab.       |
| `rules`           | *Default MR rules + Tags* | The rules when the job runs                                       |

## Variables

| Variable             | Description                                  |
| -------------------- | -------------------------------------------- |
| `HELM_CHART_CHANNEL` | GitLab Repo Chart channel. Default `stable`. |
