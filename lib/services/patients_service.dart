import 'package:dio/dio.dart';
import 'package:sus_lifo/models/patient_viewmodel.dart'; // Adicione a dependência dio no seu pubspec.yaml

class PatientService {
  static Future<List<PatientViewModel>> fetchPatient() async {
    try {
      final response = await Dio()
          .get('http://127.0.0.1:5000/api/v1/patients/?assisted=false');

      List<PatientViewModel> patientsList = (response.data as List)
          .map((patient) =>
              PatientViewModel.fromJson(patient as Map<String, dynamic>))
          .toList();

      return patientsList;
    } on DioError {
      rethrow;
    }
  }

  static Future<PatientViewModel?> assistPatient() async {
    final response =
        await Dio().patch('http://127.0.0.1:5000/api/v1/patients/');

    if (response.statusCode == 200) {
      var assisted = response.data;
      return PatientViewModel.fromJson(assisted);
    } else {
      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  static Future<PatientViewModel?> insertPatient(String name) async {
    Map<String, dynamic> data = {
      'name': name,
    };

    final response =
        await Dio().post('http://127.0.0.1:5000/api/v1/patients/', data: data);
    if (response.statusCode == 200) {
      var assisted = response.data;
      return PatientViewModel.fromJson(assisted);
    } else {
      print(response);
      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }
}
