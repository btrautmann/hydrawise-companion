#!/usr/bin/env bash

usage()
{
  echo "Generates code coverage report for flutter app"
  echo "Options:"
  echo "  -o | --open-upon-exit  Open index.html file upon completion"
}

cd "$(dirname "$0")/.." || exit

OPEN_UPON_EXIT=0

while [ "$1" != "" ]; do
    case $1 in
        -o | --open-upon-exit )           shift
                                OPEN_UPON_EXIT=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# This is a fix due to the flutter problem noted here: https://github.com/flutter/flutter/issues/2976
ulimit -S -n 2048

flutter test --coverage --no-test-assets lib
lcov --remove coverage/lcov.info "lib/**/*.g.dart" "lib/**/*.freezed.dart" -o coverage/lcov_cleaned.info
genhtml coverage/lcov_cleaned.info -o coverage

if [ $OPEN_UPON_EXIT -eq 1 ]; then
  open coverage/index.html
fi
