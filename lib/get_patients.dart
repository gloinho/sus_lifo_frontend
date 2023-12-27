import 'package:dio/dio.dart'; // Adicione a dependência dio no seu pubspec.yaml

Future<List<Patient>> fetchPatient() async {
  try {
    final response = await Dio().get('http://127.0.0.1:5000/api/v1/patients/');

    if (response.statusCode == 200) {
      List<Patient> patientsList = (response.data as List)
          .map((patient) => Patient.fromJson(patient as Map<String, dynamic>))
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

Future<Patient?> assistPatient() async {
  try {
    final response =
        await Dio().patch('http://127.0.0.1:5000/api/v1/patients/');

    if (response.statusCode == 200) {
      var assisted = response.data;
      return Patient.fromJson(assisted);
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

Future<Patient?> insertPatient(String name) async {
  Map<String, dynamic> data = {
    'name': name,
  };
  try {
    final response =
        await Dio().post('http://127.0.0.1:5000/api/v1/patients/', data: data);
    if (response.statusCode == 200) {
      var assisted = response.data;
      return Patient.fromJson(assisted);
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

class Patient {
  final int id;
  final String name;
  final DateTime createdAt;
  final bool assisted;

  const Patient({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.assisted,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      assisted: json['assisted'],
    );
  }
}
