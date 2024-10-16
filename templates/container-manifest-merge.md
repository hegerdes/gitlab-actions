# Container Build: Merge-Manifests

### Usage

Use this component to merge container image manifest in your project without the need of a privileged Docker runner. It uses the [manifest-tool](https://github.com/estesp/manifest-tool) project to allow safe image operations. It is helpful if you have images which include the arch as a tag but you want to combine them to one general image manifest.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/container-manifest-merge@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `container_build` job to the pipeline.  
*NOTE:* By default the latest version of manifest-tool is used. For a more predictable outcome you should pin the version to a specific tag via the `image` input.


You can customize the template settings.
### Inputs

| Input                 | Default value                                   | Description                                                                                                                                                                                      |
| --------------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `as_job`              | `merge-image-manifests`                         | The name of the job that gets imported. Use ".my_job" to include as template                                                                                                                     |
| `stage`               | `package`                                       | The stage where you want the job to be added                                                                                                                                                     |
| `image`               | `mplatform/manifest-tool:alpine`                | The Docker image of kaniko                                                                                                                                                                       |
| `image_tags`          | [`$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG`]      | Array of the image tags manifests to push.                                                                                                                                                       |
| `image_platforms`     | `linux/amd64,linux/arm64`                       | It supports linux/amd64,linux/arm64,linux/arm/v5,linux/arm/v7,linux/s390x.                                                                                                                       |
| `image_name_template` | `"$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG-ARCH"` | The template that matches the existing image tags. The `ARCH` is a placeholder and will be replaced. For more see [here](https://github.com/estesp/manifest-tool?tab=readme-ov-file#createpush). |
| `rules`               | *Default MR rules + Tags*                       | The rules when the job runs                                                                                                                                                                      |

### Variables

| Variable              | Description                                                        |
| --------------------- | ------------------------------------------------------------------ |
| `IMAGE_TOOL_USERNAME` | The container registry username. Default is `CI_REGISTRY_USER`     |
| `IMAGE_TOOL_PASSWORD` | The container registry username. Default is `CI_REGISTRY_PASSWORD` |
| `DOCKER_AUTH_CONFIG`  | Docker Auth Config. Tool wil try to extract token from there.      |
