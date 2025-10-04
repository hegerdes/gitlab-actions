# Container Build: Buildkit

### Usage

Use this component to build container images in your project without the need of a privileged Docker runner. It uses the [buildkit](https://crazymax.dev/buildkit/) project to allow safe image builds in Docker or Kubernetes. It automatically adds metadata labels to the image for easy tracking when the image is deployed.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.uni-assist.de/abn-dev/gitlab-ci-templates/buildkit-build@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `container_build` job to the pipeline.  
*NOTE:* By default the latest version of buildkit is used. For a more predictable outcome you should pin the version to a specific tag via the `buildctl_image` input.


The template should work without modifications but you can customize the template settings.
### Inputs

| Input               | Default value                     | Description                                                                                                                  |
| ------------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `as_job`            | `BUILDKIT:build`                  | The name of the job that gets imported. Use ".my_job" to include as template.                                                |
| `stage`             | `build`                           | The stage where you want the job to be added.                                                                                |
| `buildctl_image`    | `moby/buildkit:latest`            | The Docker image of kaniko                                                                                                   |
| `build_platform`    | `linux/amd64`                     | The The target platform to build for.                                                                                        |
| `push`              | `true`                            | When set to `true` the image will be pushed to the default registry. Set to `false` to only build without pushing the image. |
| `cache`             | `false`                           | When set to `true` cache layers will be saved to disk. Currently NOOP.                                                       |
| `image_tags`        | ["$CI_COMMIT_REF_SLUG", "latest"] | Array of the image tags to build.                                                                                            |
| `context`           | `$CI_PROJECT_DIR`                 | The build context.                                                                                                           |
| `dockerfile`        | `$CI_PROJECT_DIR/Dockerfile`      | The path to the Dockerfile.                                                                                                  |
| `authors`           | `$CI_COMMIT_AUTHOR`               | For OCI image label: Name of the image author(s).                                                                            |
| `source_url`        | `$CI_PROJECT_URL`                 | For OCI image label: Url of the source code.                                                                                 |
| `project_url`       | `$CI_PROJECT_URL`                 | For OCI image label: Url of the project.                                                                                     |
| `documentation_url` | `$CI_PROJECT_URL`                 | For OCI image label: Url of the documentation.                                                                               |
| `version`           | `$CI_COMMIT_REF_NAME`             | For OCI image label: Version of the image.                                                                                   |
| `description`       | `$CI_PROJECT_DESCRIPTION`         | For OCI image label: Description.                                                                                            |
| `vendor`            | `UNKNOWN`                         | For OCI image label: Vendor name.                                                                                            |
| `license`           | `UNKNOWN`                         | For OCI image label: License.                                                                                                |
| `services`          | buildkitd                         | The buildkitd service that actaually builds the image                                                                        |
| `rules`             | *Default MR rules + Tags*         | The rules when the job runs                                                                                                  |

### Variables

| Variable                     | Description                                 |
| ---------------------------- | ------------------------------------------- |
| `GIT_STRATEGY`               | Default to `fetch`.                         |
| `DOCKER_CONFIG_JSON`         | The registry auth json in the docker format |
| `CONTAINER_BUILD_EXTRA_ARGS` | Extra args for the build engine.            |
