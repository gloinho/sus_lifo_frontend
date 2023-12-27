import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sus_lifo_frontend/get_patients.dart';

class QueueModel extends ChangeNotifier {
  final List<Patient> _patients = [];

  UnmodifiableListView<Patient> get patients => UnmodifiableListView(_patients);

  List<Patient> get() => _patients;

  void add(String name) async {
    final patient = await insertPatient(name);
    if (patient != null) {
      _patients.add(patient);
      notifyListeners();
    }
  }

  void remove() async {
    final patient = await assistPatient();

    if (patient != null) {
      _patients.removeWhere((item) => item.id == patient.id);
      notifyListeners();
    }
  }
}
