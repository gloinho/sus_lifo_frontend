import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sus_lifo/models/error_viewmodel.dart';
import 'package:sus_lifo/models/patient_list_viewmodel.dart';
import 'package:sus_lifo/models/patient_viewmodel.dart';
import 'package:sus_lifo/utils.dart';

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
  bool _isLoading = false;
  final TextEditingController _textFieldController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    void showSuccessDialog(PatientViewModel patient) {
      Utils.showSuccessDialog(
          patient,
          context,
          "Paciente Adicionado com Sucesso",
          () => {Navigator.pushReplacementNamed(context, '/')});
    }

    Future<void> insertPatient() async {
      String patientName = _textFieldController.text.trim();

      if (_isLoading) {
        return;
      }

      setState(() {
        errorMessage = '';
        _isLoading = true;
      });

      try {
        var result =
            await context.read<PatientListViewModel>().add(patientName);

        if (result is PatientViewModel) {
          showSuccessDialog(result);
          setState(() {
            _textFieldController.text = '';
          });
        } else if (result is ErrorViewModel) {
          setState(() {
            errorMessage = result.message;
          });
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

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
          Utils.baseElevatedButton(
            insertPatient,
            'Entrar na Fila',
            isLoading: _isLoading,
          )
        ],
      ),
    );
  }
}
