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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Fila de Pacientes - SUS LIFO',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        shadowColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.82,
        child: Column(
          children: [
            Expanded(child: _buildPatientList()),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildActionButtons(),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/patient');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 100),
            ),
            child: const Text('Adicionar Paciente'),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => context.read<PatientListViewModel>().remove(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 100),
            ),
            child: const Text('Atender Paciente'),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientList() {
    final patients = Provider.of<PatientListViewModel>(context).patients;

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: patients.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              radius: 30, // ajuste conforme necessário
              backgroundImage: AssetImage('assets/patient_img.png'),
            ),
            subtitle: Text(
                'Data de Entrada: ${DateFormat('dd-MM-yyy').add_Hms().format(patients[index].createdAt)}'),
            title: Text(
              Utils.capitalizeFirstLetter(patients[index].name),
              textAlign: TextAlign.justify,
            ),
          ),
        );
      },
    );
  }
}
