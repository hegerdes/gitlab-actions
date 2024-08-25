# GitLab CI/CD Components: trivy-scan

## Usage

Use this component to scan container images via [trivy](https://aquasecurity.github.io/trivy/) in CI.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/trivy-container-scan@<VERSION>
    inputs:
      scan_target: <MY_IMAGE>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `trivy-scan` job to the pipeline.


The template should work without modifications, when the `DIMAGE_TOKEN` variable (containing the base64 basic auth token for the container registry) is set but you can customize the template settings.
## Inputs

| Input         | Default value                            | Description                                   |
| ------------- | ---------------------------------------- | --------------------------------------------- |
| `as_job`      | `TRIVY:container-scan`                   | The name of the job to include                |
| `stage`       | `scan`                                   | The stage where you want the job to be added  |
| `image`       | `aquasec/trivy:latest`                   | The container image for doing scanning        |
| `severity`    | `HIGH,CRITICAL`                          | The severity to scan for                      |
| `extra-args`  | `--ignore-unfixed --exit-code 0`         | Extra args passed to trivy.                   |
| `allow_fail`  | `false`                                  | When set to `true` the job is allowed to fail |
| `scan_target` | `$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG` | The container image to scan                   |
| `rules`       | *Default MR rules*                       | The rules when the job runs                   |

## Variables

| Variable         | Description                                       |
| ---------------- | ------------------------------------------------- |
| `GIT_STRATEGY`   | Default to `none`.                                |
| `TRIVY_USERNAME` | The username trivy used to log in. See trivy docs |
| `TRIVY_PASSWORD` | The password trivy used to log in. See trivy docs |
| `TRIVY_AUTH_URL` | The url trivy used to log in. See trivy docs      |


For details, see the following links:
- https://docs.gitlab.com/ee/user/application_security/container_scanning/index.html#overriding-the-container-scanning-template
- https://docs.gitlab.com/ee/user/application_security/container_scanning/#vulnerability-allowlisting
- List of available variables: https://docs.gitlab.com/ee/user/application_security/container_scanning/#available-variables
