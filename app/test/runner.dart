import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

void main() {
  /*final unitTestSteps = [
    // Define your unit test steps here
    LoginUnitStep(),
    // Other unit test steps
  ];*/

  /*final acceptanceTestSteps = [
    // Define your acceptance test steps here
    LoginSteps(),
    LoginButtonStep(),
    SuccessfulLoginStep(),
    UserIDStep(),
    // Other acceptance test steps
  ];*/

  final config = FlutterTestConfiguration()
    ..features = [RegExp('tests/acceptance/features/*.*.feature')]
    ..reporters = [ProgressReporter(), TestRunSummaryReporter(), JsonReporter(path: './report.json')]
    //..stepDefinitions = [...acceptanceTestSteps ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "lib/main.dart";  // specify the path to your main app file

  final runner = GherkinRunner();
  runner.execute(config).then((_) => print("Test completed"));
}