# Security: Cosign Container Sign

### Usage

Use this component to sign container images with [cosign](https://www.sigstore.dev/) project to allow safe image operations. It uses the sigstore project and by default uses keyless-signing using the identity if the gitlab CI job. In the future you may also pass keys to the component to sign with traditional public/private keys.
You should add this component to an existing `.gitlab-ci.yml` file by using the `include:`
keyword.

```yaml
include:
  - component: gitlab.com/hegerdes/gitlab-actions/cosign-container@<VERSION>
```

where `<VERSION>` is the latest released tag or `main`. This will add a `COSIGN:container-sign` job to the pipeline.  
*NOTE:* By default the latest version of cosign is used. For a more predictable outcome you should pin the version to a specific tag via the `image` input.

You can customize the template settings.
### Inputs

| Input        | Default value                              | Description                                                                  |
| ------------ | ------------------------------------------ | ---------------------------------------------------------------------------- |
| `as_job`     | COSIGN:container-sign`                     | The name of the job that gets imported. Use ".my_job" to include as template |
| `stage`      | `package`                                  | The stage where you want the job to be added                                 |
| `image`      | `chainguard/cosign:latest`                 | The Docker image of kaniko                                                   |
| `image_tags` | [`$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG`] | Array of the image tags manifests to push.                                   |
| `extra_args` | ``                                         | Extra args passed to cosign.                                                 |
| `rules`      | *Default MR rules + Tags*                  | The rules when the job runs                                                  |

### Variables

| Variable                   | Description                                                        |
| -------------------------- | ------------------------------------------------------------------ |
| `COSIGN_REGISTRY_USERNAME` | The container registry username. Default is `CI_REGISTRY_USER`     |
| `COSIGN_REGISTRY_PASSWORD` | The container registry username. Default is `CI_REGISTRY_PASSWORD` |
| `DOCKER_AUTH_CONFIG`       | Docker Auth Config. Tool wil try to extract token from there.      |
