#!/bin/bash
set -eu
cd "$(dirname "$0")"
swift package describe --type json > project.json


#Declare a string array
TestPackageArray=("CodecTests" "ConfigurationTests" "ConsoleTests" "ContextTests" "CoreTests" "DataAccessTests" "DependencyInjectionTests" "EventingTests" "FlowTests" "LabTests" "LocalizationTests" "LoggingTests" "MessagingTests" "MetricsTests" "ServerTests")

# Print array values in  lines
for val1 in ${TestPackageArray[*]}; do
  .build/checkouts/mockingbird/mockingbird generate --project project.json \
    --output-dir Tests/$val1/MockingbirdMocks \
    --testbundle $val1 \
    --targets JazzCodec JazzConfiguration JazzConsole JazzContext JazzCore JazzDataAccess JazzDependencyInjection JazzEventing JazzFlow JazzLab JazzLocalization JazzLogging JazzMessaging JazzMetrics JazzServer
done
