#!/usr/bin/env bash

source $(dirname $0)/inc/logger.inc
source $(dirname $0)/inc/setup-secrets.inc
source $(dirname $0)/inc/regression-tester.inc
source $(dirname $0)/inc/maven-dependencies.inc
source ${HOME}/java.env

set -e
#set -x

maven_dependencies_resolve

./mvnw -e -V clean verify

# Danger is executed only on the linux runner
case "$(uname)" in
    Linux*)
        log_info "Executing danger..."
        pmd_ci_setup_env
        regression_tester_setup_ci
        regression_tester_executeDanger
        ;;
esac
