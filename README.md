# GitLab CI/CD Components
![CI/CD](https://gitlab.com/hegerdes/gitlab-actions/badges/main/pipeline.svg)
![Release](https://gitlab.com/hegerdes/gitlab-actions/-/badges/release.svg)

This repo contains a collection of different [GotLab CI/CD Components](https://about.gitlab.com/blog/2023/12/21/introducing-the-gitlab-ci-cd-catalog-beta/).

Currently sported are:
 * [Container Build: Kaniko](https://gitlab.com/hegerdes/gitlab-actions#container-build-kaniko) - requires GitLab >v16.11
 * [Container Build: Buildah](https://gitlab.com/hegerdes/gitlab-actions#container-build-buildah) - requires GitLab >v16.11
 * [Code Quality: pre-commit](https://gitlab.com/hegerdes/gitlab-actions#Code-Quality:-pre-commit)

## Container Build: Kaniko

### Usage

Use this component to build container images in your project without the need of a privileged Docker runner. It uses Googles [kaniko](https://github.com/GoogleContainerTools/kaniko) project to allow safe image builds in Docker or Kubernetes. It automataticly adds metadata labels to the image for easy tracking when the image is deployed.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/kaniko-build@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `container_build` job to the pipeline.
*NOTE:* By default the latest version of kaniko is used. For a more predictable outcome you should pin the version to a specific tag via the `build_image` input.


The template should work without modifications but you can customize the template settings.
### Inputs

| Input                       | Default value                              | Description                                                                                                                  |
| --------------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| `stage`                     | `build`                                    | The stage where you want the job to be added                                                                                 |
| `build_image`               | `gcr.io/kaniko-project/executor:debug`     | The Docker image of kaniko                                                                                                   |
| `push`                      | `true`                                     | When set to `true` the image will be pushed to the default registry. Set to `false` to only build without pushing the image. |
| `CONTAINER_BUILD_USE_CACHE` | `false`                                    | When set to `true` kaniko will push build cache layers to the registry. Currently only the gitlab registry is supported.     |
| `image_tags`                | [`$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG`] | Array of the image tags to build.                                                                                            |
| `context`                   | `$CI_PROJECT_DIR`                          | The kaniko/docker build context.                                                                                             |
| `dockerfile`                | `$CI_PROJECT_DIR/Dockerfile`               | The path to the Dockerfile.                                                                                                  |
| `authors`                   | `$CI_COMMIT_AUTHOR`                        | For OCI image label: Name of the image author(s).                                                                            |
| `source_url`                | `$CI_PROJECT_URL`                          | For OCI image label: Url of the source code.                                                                                 |
| `project_url`               | `$CI_PROJECT_URL`                          | For OCI image label: Url of the project.                                                                                     |
| `documentation_url`         | `$CI_PROJECT_URL`                          | For OCI image label: Url of the documentation.                                                                               |
| `version`                   | `$CI_COMMIT_REF_NAME`                      | For OCI image label: Version of the image.                                                                                   |
| `description`               | `$CI_PROJECT_DESCRIPTION`                  | For OCI image label: Description.                                                                                            |
| `base_img_name`             | `UNKNOWN`                                  | For OCI image label: Base image name.                                                                                        |
| `vendor`                    | `UNKNOWN`                                  | For OCI image label: Vendor name.                                                                                            |
| `license`                   | `UNKNOWN`                                  | For OCI image label: License.                                                                                                |

### Variables

| Variable                      | Description                                  |
| ----------------------------- | -------------------------------------------- |
| `GIT_STRATEGY`                | Default to `fetch`.                          |
| `DOCKER_AUTH_CONFIG `         | GitLab variable containing registry secrets. |
| `CONTAINER_BUILD_EXTRA_ARGS ` | Extra args for the build engine.             |


## Container Build: buildah

### Usage

Use this component to build container images in your project without the need of a privileged Docker runner. It uses Googles [buildah](https://buildah.io/) project to allow safe image builds in Docker or Kubernetes. It automataticly adds metadata labels to the image for easy tracking when the image is deployed. Unlike kaniko buildah supports multiarch builds, while not officially supported by this component yes, you can activate it via the `CONTAINER_BUILD_EXTRA_ARGS` variable.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/buildah-build@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `container_build` job to the pipeline.
*NOTE:* By default the latest stable version of buildah is used. For a more predictable outcome you should pin the version to a specific tag via the `build_image` input.


The template should work without modifications but you can customize the template settings.
### Inputs

| Input                       | Default value                              | Description                                                                                                                  |
| --------------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| `stage`                     | `build`                                    | The stage where you want the job to be added                                                                                 |
| `build_image`               | `gcr.io/kaniko-project/executor:debug`     | The Docker image of kaniko                                                                                                   |
| `push`                      | `true`                                     | When set to `true` the image will be pushed to the default registry. Set to `false` to only build without pushing the image. |
| `CONTAINER_BUILD_USE_CACHE` | `false`                                    | When set to `true` kaniko will push build cache layers to the registry. Currently only the gitlab registry is supported.     |
| `image_tags`                | [`$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG`] | Array of the image tags to build.                                                                                            |

| `context`                   | `$CI_PROJECT_DIR`                        | The kaniko/docker build context.                                                                                             |
| `dockerfile`                | `$CI_PROJECT_DIR/Dockerfile`             | The path to the Dockerfile.                                                                                                  |
| `authors`                   | `$CI_COMMIT_AUTHOR`                      | For OCI image label: Name of the image author(s).                                                                            |
| `source_url`                | `$CI_PROJECT_URL`                        | For OCI image label: Url of the source code.                                                                                 |
| `project_url`               | `$CI_PROJECT_URL`                        | For OCI image label: Url of the project.                                                                                     |
| `documentation_url`         | `$CI_PROJECT_URL`                        | For OCI image label: Url of the documentation.                                                                               |
| `version`                   | `$CI_COMMIT_REF_NAME`                    | For OCI image label: Version of the image.                                                                                   |
| `description`               | `$CI_PROJECT_DESCRIPTION`                | For OCI image label: Description.                                                                                            |
| `base_img_name`             | `UNKNOWN`                                | For OCI image label: Base image name.                                                                                        |
| `vendor`                    | `UNKNOWN`                                | For OCI image label: Vendor name.                                                                                            |
| `license`                   | `UNKNOWN`                                | For OCI image label: License.                                                                                                |

### Variables

| Variable                      | Description                                  |
| ----------------------------- | -------------------------------------------- |
| `GIT_STRATEGY`                | Default to `fetch`.                          |
| `DOCKER_AUTH_CONFIG `         | GitLab variable containing registry secrets. |
| `CONTAINER_BUILD_EXTRA_ARGS ` | Extra args for the build engine.             |

## Code Quality: pre-commit

### Usage

Use this component to enforce the code quality via [pre-commit](https://pre-commit.com/) config in CI. The original work was done by [yesolutions](https://gitlab.com/yesolutions/gitlab-ci-templates).
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/pre-commit@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `pre-commit` job to the pipeline.
*NOTE:* By default the latest version of the image `registry.gitlab.com/yesolutions/docker-pre-commit` is used. For a more predictable outcome you should pin the version to a specific tag via the `image` input.


The template should work without modifications but you can customize the template settings.
### Inputs

| Input                       | Default value                                       | Description                                                                                                              |
| --------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `stage`                     | `build`                                             | The stage where you want the job to be added                                                                             |
| `image`                     | `registry.gitlab.com/yesolutions/docker-pre-commit` | The Docker image for pre-commit                                                                                          |
| `force_run`                 | `false`                                             | When set to `true` it always adds the job                                                                                |
| `autofix`                   | `false`                                             | When set to `true` it automatically try to fix the violating code and push it to gitlab. Needs `PRE_COMMIT_ACCESS_TOKEN` |
| `access_token`              | `$CI_JOB_TOKEN`                                     | Token used to push it to gitlab. Must be set if `autofix` is enabled                                                     |
| `deduplicate_mr_and_branch` | `true`                                              | Don't add the job twice for branch and PR                                                                                |

### Variables

| Variable                  | Description                                                          |
| ------------------------- | -------------------------------------------------------------------- |
| `GIT_STRATEGY`            | Default to `fetch`.                                                  |
| `PRE_COMMIT_ACCESS_TOKEN` | Token used to push it to gitlab. Must be set if `autofix` is enabled |

For details, see the following links:
- https://docs.gitlab.com/ee/user/application_security/container_scanning/index.html#overriding-the-container-scanning-template
- https://docs.gitlab.com/ee/user/application_security/container_scanning/#vulnerability-allowlisting
- List of available variables: https://docs.gitlab.com/ee/user/application_security/container_scanning/#available-variables


## Contribute

Please read about CI/CD components and best practices at: https://docs.gitlab.com/ee/ci/components
