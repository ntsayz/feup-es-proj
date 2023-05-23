import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'acceptance/login_test.dart';

void main() {
  final steps = [
    LoginSteps(),
    LoginButtonStep(),
    SuccessfulLoginStep(),
    UserIDStep(),
  ];

  final config = FlutterTestConfiguration()
    ..features = [RegExp('tests/acceptance/features/*.*.feature')]
    ..reporters = [ProgressReporter(), TestRunSummaryReporter(), JsonReporter(path: './report.json')]
    ..stepDefinitions = steps  // use the steps we defined earlier
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "lib/main.dart";  // specify the path to your main app file

  final runner = GherkinRunner();
  runner.execute(config).then((_) => print("Test completed"));
}