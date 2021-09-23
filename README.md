# Check Run Reporter Buildkite Plugin

## Example

```yml
steps:
    - command: npm test
      plugins:
          - check-run-reporter/check-run-reporter#v2.3.0:
                report: 'reports/junit/**/*.xml'
                token: '<your repo token>'
```

## Configuration

### `report` (Required, string)

Path or glob to the job's report files.

### `label` (Optional, string)

Label that should appear in the GitHub check. Defaults to the job's
`BUILDKITE_LABEL`.

### `root` (Optional, string)

Defaults to the project's working directory

### `token` (Required, string)

Repo token to authenticate the upload. You can get your tokens from
[https://www.check-run-reporter.com/repos](https://www.check-run-reporter.com/repos).

## Contributing

This repository is only for publication. Please see
[the integrations repository](https://github.com/check-run-reporter/integrations)
to contribute.
