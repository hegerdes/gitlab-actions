# GitLab CI/CD Components
![CI/CD](https://gitlab.com/hegerdes/gitlab-actions/badges/main/pipeline.svg)
![Release](https://gitlab.com/hegerdes/gitlab-actions/-/badges/release.svg)

This repo contains a collection of different [GotLab CI/CD Components](https://about.gitlab.com/blog/2023/12/21/introducing-the-gitlab-ci-cd-catalog-beta/).

Currently suporrted are:
 * [Container Build: Kaniko](https://gitlab.com/hegerdes/gitlab-actions#container-build-kaniko)

## Container Build: Kaniko

### Usage

Use this component to build container images in your project without the need of a privileged Docker runner. It uses Googles [kaniko](https://github.com/GoogleContainerTools/kaniko) project to allow safe image builds in Docker or Kubernetes. It automataticly adds metadata labels to the image for easy tracking when the image is deployed.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/container-build@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `container_build` job to the pipeline.  
*NOTE:* By default the latest version of kaniko is used. For a more predictable outcome you should pin the version to a specific tag via the `build_image` input.


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
