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

This will add a `container_build` job to the pipeline.

The template should work without modifications but you can customize the template settings.
### Inputs

| Input | Default value | Description |
| ----- | ------------- | ----------- |
| `stage` | `build`      | The stage where you want the job to be added |
| `build_image` | `gcr.io/kaniko-project/executor:debug` | The Docker image of kaniko |
| `force_run` | `false` | When set to `true` it always adds the job even if `$CONTAINER_SCANNING_DISABLED` is set |
| `push` | `true` | When set to `true` the image will be pushed to the default registry. Set to `false` to only build without pushing the image. |
| `kaniko_use_cache` | `false` | When set to `true` kaniko will push build cache layers to the registry. Currently only the gitlab registry is supported. |
| `image_tag` | `$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG` | The name/path of the image to build. |
| `context` | `$CI_PROJECT_DIR` | The kaniko/docker build context. |
| `dockerfile` | `$CI_PROJECT_DIR/Dockerfile` | The path to the Dockerfile. |
| `authors` | `$CI_COMMIT_AUTHOR` | For OCI image label: Name of the image author(s).|
| `source_url` | `$CI_PROJECT_URL` | For OCI image label: Url of the source code. |
| `project_url` | `$CI_PROJECT_URL` | For OCI image label: Url of the project. |
| `documentation_url` | `$CI_PROJECT_URL` | For OCI image label: Url of the documentation. |
| `version` | `$CI_COMMIT_REF_NAME` | For OCI image label: Version of the image. |
| `description` | `$CI_PROJECT_DESCRIPTION` | For OCI image label: Description. |
| `base_img_name` | `UNKNOWN` | For OCI image label: Base image name. |
| `vendor` | `UNKNOWN` | For OCI image label: Vendor name. |
| `license` | `UNKNOWN` | For OCI image label: License. |

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
