import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sus_lifo/models/error_viewmodel.dart';
import 'package:sus_lifo/services/patients_service.dart';
import 'package:sus_lifo/models/patient_viewmodel.dart';

class PatientListViewModel extends ChangeNotifier {
  List<PatientViewModel> _patients = [];

  Future<void> fetchPatients() async {
    try {
      final patients = await PatientService.fetchPatient();
      _patients = patients;
    } catch (e) {
      _patients = [];
    }
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
    } on DioError catch (dioError) {
      var message = dioError.response?.data["message"];
      return ErrorViewModel(
          message: message ?? "Não foi possível adicionar um paciente.");
    }
  }

  Future<dynamic> remove() async {
    try {
      final patient = await PatientService.assistPatient();
      if (patient != null) {
        _patients.removeWhere((item) => item.id == patient.id);
        notifyListeners();
        return patient;
      }
    } on DioError catch (dioError) {
      var message = dioError.response?.data["message"];
      return ErrorViewModel(
          message: message ?? "Não foi possível adicionar um paciente.");
    }
  }
}
