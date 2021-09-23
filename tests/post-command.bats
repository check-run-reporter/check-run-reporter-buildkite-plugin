#!/usr/bin/env bats

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../hooks:$PATH"
}

# @test "Uploads a single report" {
#     # Mock the environment for when we're running tests outside of buildkite
#     export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
#     export BUILDKITE_COMMIT=${BUILDKITE_COMMIT:-$(git rev-parse --verify HEAD)}
#     export BUILDKITE_PLUGINS=''

#     export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Single Report Upload'
#     export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN=42bbb14a-ef66-4e88-8bdb-1507d6e7adc0
#     export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_REPORT="$DIR/success.xml"

#     run "post-command"

#     assert_success
#     assert_output --partial 'Uploaded reports to Check Run Reporter'
# }

# @test "Uploads a glob of reports" {
#     # Mock the environment for when we're running tests outside of buildkite
#     export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
#     export BUILDKITE_COMMIT=${BUILDKITE_COMMIT:-$(git rev-parse --verify HEAD)}
#     export BUILDKITE_PLUGINS=''

#     export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Multi Report Upload'
#     export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN=42bbb14a-ef66-4e88-8bdb-1507d6e7adc0
#     export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_REPORT="$DIR/**/*.xml"

#     run "post-command"

#     assert_success
#     assert_output --partial 'Uploaded reports to Check Run Reporter'
# }

@test "Reports API errors" {
    # Mock the environment for when we're running tests outside of buildkite
    export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
    export BUILDKITE_COMMIT='${BUILDKITE_COMMIT:-$(git rev-parse --verify HEAD)}'
    export BUILDKITE_PLUGINS=''

    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Single Report Upload'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN='not-a-token'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_REPORT="$DIR/success.xml"

    run "post-command"

    assert_failure
}
