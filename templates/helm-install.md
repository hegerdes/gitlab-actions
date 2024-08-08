
## Deployment: Helm install

### Usage

Use this component deploy helm charts to a kubernetes cluster. It supports installs and upgrades. The chart can either be in the repo, a link to a chart or a chart name of a helm repo is specified.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/helm@<VERSION>
    inputs:
      release_name: my-release
      chart: tests/charts/demo
```

where `<VERSION>` is the latest released tag or `main`. This will add a `HELM:install` job to the pipeline.  
*NOTE:* By default the latest version of helm is used. For a more predictable outcome you should use a image with a pined helm version or set the `HELM_VERSION` environment variable.


The template should work without modifications but you can customize the template settings.
### Inputs

| Input             | Default value                 | Description                                                                                      |
| ----------------- | ----------------------------- | ------------------------------------------------------------------------------------------------ |
| `job_name_prefix` | `HELM`                        | The name of the job that gets imported. Use ".my_job" to include as template                     |
| `stage`           | `deploy`                      | The stage where you want the job to be added                                                     |
| `image`           | `debian:bookworm-slim`        | The Docker image for helm. Helm will be automatically installed                                  |
| `release_name`    | <REQUIRED>                    | Helm release name                                                                                |
| `chart`           | <REQUIRED>                    | The local path to a helm chart or the full URL. Can also be the chart name if helm `repo` is set |
| `repo`            | `none`                        | The url to a helm chart repo                                                                     |
| `helm_extra_args` | `--atomic --wait`             | Extra helm args. Example are namespace, set or dry-run for testing                               |
| `values_file`     | `none`                        | Optional path for values file                                                                    |
| `rules`           | `Array - Default merge rules` | Default merge rules                                                                              |
