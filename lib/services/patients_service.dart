import 'package:dio/dio.dart';
import 'package:sus_lifo_frontend/models/patient_viewmodel.dart'; // Adicione a dependência dio no seu pubspec.yaml

class PatientService {
  static Future<List<PatientViewModel>> fetchPatient() async {
    try {
      final response =
          await Dio().get('http://127.0.0.1:5000/api/v1/patients/');

      if (response.statusCode == 200) {
        List<PatientViewModel> patientsList = (response.data as List)
            .map((patient) =>
                PatientViewModel.fromJson(patient as Map<String, dynamic>))
            .toList();

        return patientsList;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioError catch (e) {
      // Tratamento de erros específicos do Dio
      if (e.response != null) {
        print(
            'Dio Error - ${e.response?.statusCode}: ${e.response?.statusMessage}');
      } else {
        print('Dio Error - ${e.message}');
      }
      return Future.error('Failed to load Patient');
    } catch (e) {
      // Tratamento de erros genéricos
      print('Error - $e');
      return Future.error('Failed to load Patient');
    }
  }

  static Future<PatientViewModel?> assistPatient() async {
    try {
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
    } on DioError catch (e) {
      // Dio specific error handling
      if (e.response != null) {
        print(
            'Dio Error - ${e.response?.statusCode}: ${e.response?.statusMessage}');
      } else {
        print('Dio Error - ${e.message}');
      }
      return null;
    } catch (e) {
      // Generic error handling
      print('Error - $e');
      return null;
    }
  }

  static Future<PatientViewModel?> insertPatient(String name) async {
    Map<String, dynamic> data = {
      'name': name,
    };
    try {
      final response = await Dio()
          .post('http://127.0.0.1:5000/api/v1/patients/', data: data);
      if (response.statusCode == 200) {
        var assisted = response.data;
        return PatientViewModel.fromJson(assisted);
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioError catch (e) {
      // Dio specific error handling
      if (e.response != null) {
        print(
            'Dio Error - ${e.response?.statusCode}: ${e.response?.statusMessage}');
      } else {
        print('Dio Error - ${e.message}');
      }
      return null;
    } catch (e) {
      // Generic error handling
      print('Error - $e');
      return null;
    }
  }
}
