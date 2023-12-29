import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sus_lifo_frontend/utils.dart';
import 'package:sus_lifo_frontend/models/patient_list_viewmodel.dart';

class PatientQueue extends StatefulWidget {
  const PatientQueue({super.key});

  @override
  State<PatientQueue> createState() => _PatientQueueState();
}

class _PatientQueueState extends State<PatientQueue> {
  @override
  void initState() {
    super.initState();
    Provider.of<PatientListViewModel>(context, listen: false).fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Fila de Pacientes - SUS LIFO 🤪',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPatientList(),
          ],
        ),
      ),
      floatingActionButton: _buildActionButtons(),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/patient');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 100),
            ),
            child: const Text('Adicionar Paciente'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context.read<PatientListViewModel>().remove(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 100),
            ),
            child: const Text('Atender Paciente'),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientList() {
    final patients = Provider.of<PatientListViewModel>(context).patients;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: patients.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text(
              DateFormat.yMd().add_Hms().format(patients[index].createdAt)),
          title: Text(
            Utils.capitalizeFirstLetter(patients[index].name),
          ),
        );
      },
    );
  }
}
