/* 31/12/2023 (Last day of 2023), 11:22 PM
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/model/registration_model.dart';

class RegistrationProvider extends ChangeNotifier {
  List<Registration> _registrations = [];

  List<Registration> get registrations => List.unmodifiable(_registrations);

  bool isAlreadyRegistered(Registration registration) {
    return _registrations.any(
      (reg) =>
          reg.state == registration.state && reg.place == registration.place,
    );
  }

  void addRegistration(Registration registration) {
    if (!isAlreadyRegistered(registration)) {
      _registrations.add(registration);
      notifyListeners();
    }
  }

  void removeRegistration(int index) {
    if (index >= 0 && index < _registrations.length) {
      _registrations.removeAt(index);
      notifyListeners();
    }
  }

  void setRegistrations(List<Registration> registrations) {
    _registrations = List.from(registrations);
    notifyListeners();
  }

  void clearRegistrations() {
    _registrations.clear();
    notifyListeners();
  }
}