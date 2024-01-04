import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sus_lifo/models/error_viewmodel.dart';
import 'package:sus_lifo/models/patient_viewmodel.dart';

enum TipoData {
  entrada,
  saida;
}

class Utils {
  static String formatDate(DateTime? date, TipoData tipoData) {
    if (date != null) {
      return 'Data de ${capitalizeFirstLetter(tipoData.name)}: ${DateFormat('dd-MM-yyy').add_Hms().format(date)}';
    }
    return "";
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static void showSuccessDialog(PatientViewModel patient, BuildContext context,
      String customMessage, Function okOnPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(customMessage),
          content: Text(
              'ID do Paciente: ${patient.id}\nNome: ${patient.name}\n${formatDate(patient.createdAt, TipoData.entrada)}\n${formatDate(patient.updatedAt, TipoData.saida)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {okOnPressed()},
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showErrorDialog(
      ErrorViewModel error, BuildContext context, String customMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(error.message),
          content: Text(customMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static ElevatedButton baseElevatedButton(Function onPressed, String innerText,
      {bool isLoading = false}) {
    return ElevatedButton(
      onPressed: () => {onPressed()},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 100),
      ),
      child: isLoading
          ? const CircularProgressIndicator() // Mostra o indicador de carregamento se estiver carregando
          : Text(innerText),
    );
  }
}
