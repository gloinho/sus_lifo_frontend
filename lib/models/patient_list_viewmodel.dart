import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sus_lifo_frontend/models/error_viewmodel.dart';
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

  Future<dynamic> add(String name) async {
    try {
      final patient = await PatientService.insertPatient(name);
      await fetchPatients();
      return patient;
    } catch (e) {
      if (e is DioError) {
        final dioError = e;
        return ErrorViewModel(message: dioError.response?.data["message"]);
      }
    }
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
