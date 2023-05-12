# Check Run Reporter Buildkite Plugin

This is a Buildkite plugin for
[Check Run Reporter](https://www.check-run-reporter.com)

Check Run Reporter makes it easier to see what your CI system is trying to tell
you. It let's you view your test and code style results without leaving GitHub
and it helps distribute your tests across multiple agents.

## Examples

### Submitting Test and Style Results

Check Run Reporter's most basic function is to receive your results and send
them back to GitHub as Check Runs.

```yml
steps:
    - command: npm test
      plugins:
          - check-run-reporter/check-run-reporter#v2.12.0:
                report: 'reports/junit/**/*.xml'
                token: '<your repo token>'
```

### Splitting tests across agents

Once you've configured your Buildkite agents to send results to Check Run
Reporter, CRR can use your timing data to help you distribute your tests across
your CI agents.

When you tell the plugin where to find your tests, it will set an environment
variable, `CHECK_RUN_REPORTER_TESTS_FOR_THIS_AGENT` with the list of tests that
should run on this host.

```yml
steps:
    - command: npm test -- $$CHECK_RUN_REPORTER_TESTS_FOR_THIS_AGENT
      plugins:
          - check-run-reporter/check-run-reporter#v2.12.0:
                tests: 'src/**/*.spec.ts,!src/storyshots.spec.ts'
                report: 'reports/junit/**/*.xml'
                token: '<your repo token>'
```

## Configuration

### `report` (Required, string)

Path or glob to the job's report files. Separate multiple globs with a
semicolon.

### `tests` (Optional, string)

Path or glob to the job's test files. Separate multiple globs with a semicolon.

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
