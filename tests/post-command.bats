#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

@test "Uploads a single report" {
    # Mock the environment for when we're running tests outside of buildkite
    export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
    export BUILDKITE_COMMIT=${BUILDKITE_COMMIT:-$(git rev-parse --verify HEAD)}

    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Single Report Upload'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN=42bbb14a-ef66-4e88-8bdb-1507d6e7adc0
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_FILE=tests/success.xml

    run "$PWD/hooks/post-command"

    assert_success
    assert_output --partial 'Uploaded reports to Check Run Reporter'
}

@test "Uploads a glob of reports" {
    # Mock the environment for when we're running tests outside of buildkite
    export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
    export BUILDKITE_COMMIT=${BUILDKITE_COMMIT:-$(git rev-parse --verify HEAD)}

    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Multi Report Upload'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN=42bbb14a-ef66-4e88-8bdb-1507d6e7adc0
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_FILE=tests/**/*.xml

    run "$PWD/hooks/post-command"

    assert_success
    assert_output --partial 'Uploaded reports to Check Run Reporter'
}

@test "Reports API errors" {
    # Mock the environment for when we're running tests outside of buildkite
    export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
    export BUILDKITE_COMMIT='${BUILDKITE_COMMIT:-$(git rev-parse --verify HEAD)}'

    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Single Report Upload'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN='not-a-token'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_FILE=tests/success.xml

    run "$PWD/hooks/post-command"

    assert_failure
}
