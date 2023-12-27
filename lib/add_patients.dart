import 'package:flutter/material.dart';
import 'package:sus_lifo_frontend/get_patients.dart';

class AddPatientForm extends StatelessWidget {
  const AddPatientForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Adicionar Pacientes')),
      ),
      body: const AddPatient(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: ElevatedButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/');
      //   },
      //   child: const Text(
      //     'Ver Fila Atual',
      //   ),
      // ),
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

  Future<void> _insertPatient() async {
    Patient? patient = await insertPatient(_textFieldController.text);

    if (patient != null) {
      _showSuccessDialog(patient);
      setState(() {
        _textFieldController.text = '';
      });
    }
  }

  void _showSuccessDialog(Patient patient) {
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
              child: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(
                  labelText: 'Insira o nome do paciente.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              await _insertPatient();
            },
            child: const Text('Entrar na fila'),
          ),
        ],
      ),
    );
  }
}
