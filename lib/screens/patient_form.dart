import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sus_lifo_frontend/models/patient_list_viewmodel.dart';
import 'package:sus_lifo_frontend/models/patient_viewmodel.dart';

class PatientForm extends StatelessWidget {
  const PatientForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Adicionar Pacientes')),
      ),
      body: const AddPatient(),
    );
  }
}

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final TextEditingController _textFieldController = TextEditingController();

  String errorMessage = '';

  Future<void> _insertPatient(BuildContext context) async {
    String patientName = _textFieldController.text.trim();

    if (patientName.isEmpty) {
      setState(() {
        errorMessage = 'O nome do paciente não pode estar vazio.';
      });
      return;
    }

    setState(() {
      errorMessage = '';
    });

    PatientViewModel? patient =
        await context.read<PatientListViewModel>().add(patientName);

    if (patient != null) {
      _showSuccessDialog(patient);
      setState(() {
        _textFieldController.text = '';
      });
    }
  }

  void _showSuccessDialog(PatientViewModel patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Paciente Adicionado com Sucesso'),
          content: Text('ID do Paciente: ${patient.id}\nNome: ${patient.name}'),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(
                        labelText: 'Insira o nome do paciente.',
                        errorText:
                            errorMessage.isNotEmpty ? errorMessage : null,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              await _insertPatient(context);
            },
            child: const Text('Entrar na fila'),
          ),
        ],
      ),
    );
  }
}
