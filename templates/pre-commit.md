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
*NOTE:* By default the latest version of the image `python:3.12-slim` is used. For a more predictable outcome you should pin the version to a specific tag via the `image` input.


The template should work without modifications but you can customize the template settings.
### Inputs

| Input                       | Default value      | Description                                                                                                              |
| --------------------------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| `as_job`                    | `pre-commit`       | The name of the job that gets imported. Use ".my_job" to include as template                                             |
| `stage`                     | `.pre`             | The stage where you want the job to be added                                                                             |
| `image`                     | `python:3.12-slim` | The Docker image for pre-commit                                                                                          |
| `autofix`                   | `false`            | When set to `true` it automatically try to fix the violating code and push it to gitlab. Needs `PRE_COMMIT_ACCESS_TOKEN` |
| `access_token`              | `$CI_JOB_TOKEN`    | Token used to push it to gitlab. Must be set if `autofix` is enabled                                                     |
| `deduplicate_mr_and_branch` | `true`             | Don't add the job twice for branch and PR                                                                                |

### Variables

| Variable                  | Description                                                          |
| ------------------------- | -------------------------------------------------------------------- |
| `GIT_STRATEGY`            | Default to `fetch`.                                                  |
| `PRE_COMMIT_ACCESS_TOKEN` | Token used to push it to gitlab. Must be set if `autofix` is enabled |
