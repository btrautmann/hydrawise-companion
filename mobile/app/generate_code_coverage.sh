#!/usr/bin/env bash

flutter test --coverage --no-test-assets lib
lcov --remove coverage/lcov.info "lib/**/*.g.dart" "lib/**/*.freezed.dart" -o coverage/lcov_cleaned.info
genhtml coverage/lcov_cleaned.info -o coverage
