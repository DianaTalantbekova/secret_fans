import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_fans/main.dart';

enum CreatePassState { create, repeat, change, enter, check }

class PasswordManager extends ChangeNotifier {
  late GoRouter router;

  final List<String> _createdPassword = [];
  final List<String> _password = [];

  bool isWrongPassword = false;

  bool get hasPassword => _createdPassword.isNotEmpty;

  late CreatePassState _createPassState;

  CreatePassState get createPassState => _createPassState;

  set createPassState(CreatePassState value) {
    _createPassState = value;
    isWrongPassword = false;
  }

  PasswordManager();

  int get filledLength => _password.length;

  int get passLength => 4;

  String get labelText => switch (createPassState) {
        CreatePassState.create => 'Create a password',
        CreatePassState.repeat => 'Repeat the password',
        CreatePassState.change => 'Enter password',
        CreatePassState.enter => 'Enter password',
        CreatePassState.check => 'Enter password',
      };

  bool isEmpty(int index) => filledLength <= index;

  enterPass(String char) {
    _password.add(char);
    notifyListeners();

    if (filledLength == passLength) {
      _checkState();
    }
  }

  void removePass() {
    if (_password.isEmpty) {
      return;
    }
    _password.removeLast();
    notifyListeners();
  }

  void _checkState() => switch (createPassState) {
        CreatePassState.create => _changeCreateState(),
        CreatePassState.repeat => _changeRepeatState(),
        CreatePassState.change => _changePassword(),
        CreatePassState.enter => _changeRepeatState(),
        CreatePassState.check => _changeRepeatState(),
      };

  void _changeCreateState() {
    _createdPassword.clear();
    _createdPassword.addAll(List.of(_password));
    _savePassword();
    _password.clear();
    createPassState = CreatePassState.repeat;
  }

  void _changeRepeatState() {
    final isCorrect = listEquals(_createdPassword, _password);
    if (isCorrect) {
      _password.clear();
      _redirectTo();
    } else {
      isWrongPassword = true;
      notifyListeners();
    }
  }

  void _redirectTo() => switch (createPassState) {
        CreatePassState.create => null,
        CreatePassState.repeat => router.routeInformationProvider.value.uri.path
                .contains('/settings_screen')
            ? router.go('/settings_screen/password_change')
            : router.go('/home_screen'),
        CreatePassState.change => router.pop(),
        CreatePassState.enter => router.go('/home_screen'),
        CreatePassState.check => router.go('/settings_screen/password_change'),
      };

  void _changePassword() {
    _createdPassword.clear();
    _createdPassword.addAll(List.of(_password));
    _savePassword();
    _password.clear();
    _redirectTo();
  }

  Future<void> init() async {
    final password = preferences.getString('password');
    if (password == null || password.isEmpty) {
      createPassState = CreatePassState.create;
      return;
    }

    createPassState = CreatePassState.enter;

    for (int i = 0; i < password.length; i++) {
      _createdPassword.add(password[i]);
    }
  }

  void _savePassword() {
    final password = _createdPassword.join();
    if (password.isEmpty) {
      return;
    }
    preferences.setString('password', password);
  }

  void deletePassword() {
    _createdPassword.clear();
    preferences.remove('password');
  }
}
