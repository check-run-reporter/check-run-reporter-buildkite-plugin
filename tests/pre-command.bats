#!/usr/bin/env bats

EXAMPLE_REPO_COMMIT=6cbf0c4fed8f2f48ff1bbd0b537a14b6832eee0f
EXAMPLE_REPO_TOKEN=a329b944-6856-4bd0-8a16-2b4a96baf76b

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

@test "Split tests" {
    export BATS_FAKE_SPLIT_RESPONSE=true
    # Mock the environment for when we're running tests outside of buildkite
    export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
    export BUILDKITE_COMMIT=$EXAMPLE_REPO_COMMIT
    export BUILDKITE_PLUGINS=''

    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Split Tests'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN=$EXAMPLE_REPO_TOKEN
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TESTS='src/**/*.spec.ts'

    run "$DIR/pre-command-wrapper"

    assert_success

    assert_output 'CHECK_RUN_REPORTER_TESTS_FOR_THIS_AGENT=logger.spec.ts
user.spec.ts'
}

@test "Without tests input" {
    export BATS_FAKE_SPLIT_RESPONSE=true
    # Mock the environment for when we're running tests outside of buildkite
    export BUILDKITE_LABEL=${BUILDKITE_LABEL:-bats}
    export BUILDKITE_COMMIT=$EXAMPLE_REPO_COMMIT
    export BUILDKITE_PLUGINS=''

    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_LABEL='BATS: Split Tests'
    export BUILDKITE_PLUGIN_CHECK_RUN_REPORTER_TOKEN=$EXAMPLE_REPO_TOKEN

    run pre-command

    assert_success
}
