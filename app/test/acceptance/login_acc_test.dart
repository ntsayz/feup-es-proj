import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart' hide find;

void main(){

}



class LoginSteps extends Given1WithWorld<String, FlutterWorld> {
  LoginSteps()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r'I enter my email "(.*)"');

  @override
  Future<void> executeStep(String email) async {
    final emailField = find.byValueKey('email');
    await FlutterDriverUtils.enterText(world.driver, emailField, email);
  }
}

class LoginButtonStep extends WhenWithWorld<FlutterWorld> {
  LoginButtonStep()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r'I tap on the login button');

  @override
  Future<void> executeStep() async {
    final loginButton = find.byValueKey('loginButton');
    await FlutterDriverUtils.tap(world.driver, loginButton);
  }
}

class SuccessfulLoginStep extends ThenWithWorld<FlutterWorld> {
  SuccessfulLoginStep()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r'I should be redirected to the main screen');

  @override
  Future<void> executeStep() async {
    final mainScreenTitle = find.byValueKey('mainScreen');
    await world.driver!.waitFor(mainScreenTitle);
  }
}

class UserIDStep extends Then1WithWorld<String, FlutterWorld> {
  UserIDStep()
      : super(StepDefinitionConfiguration()..timeout = const Duration(seconds: 10));

  @override
  RegExp get pattern => RegExp(r'I should see my user ID "(.*)"');

  @override
  Future<void> executeStep(String userId) async {
    final userIdWidget = find.byValueKey('userId');
    final actualUserId = await FlutterDriverUtils.getText(world.driver!, userIdWidget);
    expect(actualUserId, userId);
  }
}
