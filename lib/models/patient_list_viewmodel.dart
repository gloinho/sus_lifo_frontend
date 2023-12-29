import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sus_lifo_frontend/services/patients_service.dart';
import 'package:sus_lifo_frontend/models/patient_viewmodel.dart';

class PatientListViewModel extends ChangeNotifier {
  List<PatientViewModel> _patients = [];

  Future<void> fetchPatients() async {
    final patients = await PatientService.fetchPatient();
    _patients = patients;
    notifyListeners();
  }

  UnmodifiableListView<PatientViewModel> get patients =>
      UnmodifiableListView(_patients);

  List<PatientViewModel> get() => _patients;

  Future<PatientViewModel?> add(String name) async {
    final patient = await PatientService.insertPatient(name);
    if (patient != null) {
      await fetchPatients();
      return patient;
    }
    return null;
  }

  Future<PatientViewModel?> remove() async {
    final patient = await PatientService.assistPatient();

    if (patient != null) {
      _patients.removeWhere((item) => item.id == patient.id);
      notifyListeners();
      return patient;
    }
    return null;
  }
}
