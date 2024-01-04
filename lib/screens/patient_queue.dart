import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sus_lifo/models/error_viewmodel.dart';
import 'package:sus_lifo/utils.dart';
import 'package:sus_lifo/models/patient_list_viewmodel.dart';

class PatientQueue extends StatefulWidget {
  const PatientQueue({super.key});

  @override
  State<PatientQueue> createState() => _PatientQueueState();
}

class _PatientQueueState extends State<PatientQueue> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<PatientListViewModel>(context, listen: false).fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      floatingActionButton: _buildActionButtons(context),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    void showDialogs(result) {
      if (result is ErrorViewModel) {
        Utils.showErrorDialog(
            result, context, "Não foi possível atender o paciente");
      } else {
        Utils.showSuccessDialog(result, context,
            "Paciente atendido com sucesso", () => {Navigator.pop(context)});
      }
    }

    void assistPatient() async {
      if (_isLoading) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        var result = await context.read<PatientListViewModel>().remove();
        showDialogs(result);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.baseElevatedButton(
            () => {Navigator.pushNamed(context, '/patient')},
            'Adicionar Paciente',
          ),
          const SizedBox(width: 10),
          Utils.baseElevatedButton(assistPatient, 'Atender Paciente',
              isLoading: _isLoading)
        ],
      ),
    );
  }

  Widget _buildPatientList() {
    final patients = Provider.of<PatientListViewModel>(context).patients;

    if (patients.isEmpty) {
      return const Center(child: Text('Nenhum paciente cadastrado'));
    }

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
                Utils.formatDate(patients[index].createdAt, TipoData.entrada)),
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
