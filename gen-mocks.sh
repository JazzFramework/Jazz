#!/bin/bash
set -eu
cd "$(dirname "$0")"
swift package describe --type json > project.json

TestPackageArray=(
  "CodecTests"
  "ConfigurationTests"
  "ConsoleTests"
  "ContextTests"
  "CoreTests"
  "DataAccessTests"
  "DependencyInjectionTests"
  "EventingTests"
  "FlowTests"
  "LabTests"
  "LocalizationTests"
  "LoggingTests"
  "MessagingTests"
  "MetricsTests"
  "ServerTests"
)

for testPackage in ${TestPackageArray[*]}; do
  .build/checkouts/mockingbird/mockingbird generate --project project.json \
    --output-dir Tests/$testPackage/MockingbirdMocks \
    --testbundle $testPackage \
    --targets JazzCodec JazzConfiguration JazzConsole JazzContext JazzCore JazzDataAccess JazzDependencyInjection JazzEventing JazzFlow JazzLab JazzLocalization JazzLogging JazzMessaging JazzMetrics JazzServer
done
