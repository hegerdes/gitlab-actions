# Container Build Kaniko

## Usage

Use this component to enable container scanning in your project.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/container-build@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`.

This will add a `container_scanning` job to the pipeline.

The template should work without modifications but you can customize the template settings.
### Inputs

| Input | Default value | Description |
| ----- | ------------- | ----------- |
| `stage` | `test`      | The stage where you want the job to be added |
| `analyzer_image` | `$CI_TEMPLATE_REGISTRY_HOST/security-products/container-scanning:5` | The Docker image of the analyzer |
| `force_run` | `false` | When set to `true` it always adds the job even if `$CONTAINER_SCANNING_DISABLED` is set |

### Variables

| Variable | Description |
| -------- | ----------- |
| `GIT_STRATEGY` | Default to `fetch`. |
| `DOCKER_AUTH_CONFIG ` | GitLab variable containing registry secrets. |

For details, see the following links:
- https://docs.gitlab.com/ee/user/application_security/container_scanning/index.html#overriding-the-container-scanning-template
- https://docs.gitlab.com/ee/user/application_security/container_scanning/#vulnerability-allowlisting
- List of available variables: https://docs.gitlab.com/ee/user/application_security/container_scanning/#available-variables


## Contribute

Please read about CI/CD components and best practices at: https://docs.gitlab.com/ee/ci/components
