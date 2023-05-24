import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:trabalho/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {
  final String uid = 'testUid';
}

class MockUserCredential extends Mock implements UserCredential {
  final MockUser user = MockUser();

}
class MockBuildContext extends Mock implements BuildContext {}

void main() {

  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockBuildContext mockBuildContext;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = mockUserCredential.user;
    mockBuildContext = MockBuildContext();

    when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'testEmail', password: 'testPassword'))
        .thenAnswer((_) async => mockUserCredential);

  });


  test('loginUsingEmailPassword successfully returns a User', () async {
    when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'testEmail', password: 'testPassword'))
        .thenAnswer((_) async => mockUserCredential);

    User? result = await AuthService.loginUsingEmailPassword(
        email: 'testEmail',
        password: 'testPassword',
        birthDate: '1990-01-01',
        context: mockBuildContext
    );

    expect(result, isNotNull);
    expect(result?.uid, 'testUid');

  });
}

