# Check Run Reporter Buildkite Plugin

## Example

```yml
steps:
  - command: npm test
    plugins:
      - check-run-reporter/check-run-reporter#v1.0.0:
        file: 'reports/junit/**/*.xml'
        token: '<your repo token>'
```

## Configuration

### `report` (Required, string)

Path or bash-compatible glob to the job's report files.

### `label` (Optional, string)

Label that should appear in the GitHub check. Defaults to the job's `BUILDKITE_LABEL`.

### `root` (Optional, string)

Defaults to the project's working directory

### `token` (Required, string)

Repo token to authenticate the upload. You can get your tokens from [https://www.check-run-reporter.com/repos](https://www.check-run-reporter.com/repos).

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

To run the linter:

```shell
docker-compose run --rm linter
```

## Contributing

1. Fork the repo.
2. Make the changes.
3. Run the tests.
4. Commit and push your changes.
5. Send a pull request.
