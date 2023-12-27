import 'package:flutter/material.dart';
import 'package:sus_lifo_frontend/add_patients.dart';
import 'get_patients.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PatientQueue(),
        '/patient': (context) => const AddPatientForm()
      },
    );
  }
}

class PatientQueue extends StatefulWidget {
  const PatientQueue({super.key});

  @override
  State<PatientQueue> createState() => _PatientQueueState();
}

class _PatientQueueState extends State<PatientQueue> {
  late Future<List<Patient>> patients;

  @override
  void initState() {
    super.initState();
    patients = fetchPatient();
  }

  Future<void> updateQueue() async {
    var patientUpdated = await assistPatient();
    if (patientUpdated != null) {
      setState(() {
        patients = fetchPatient();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/patient');
              },
              child: const Text(
                'Adicionar Paciente',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => updateQueue(),
              child: const Text(
                'Atender Paciente',
              ),
            ),
          ]),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Patients Queue')),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<List<Patient>>(
              future: patients,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final patientsList =
                      snapshot.data!.where((e) => !e.assisted).toList();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: patientsList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patientsList[index].createdAt.toString()),
                            Text(
                              capitalizeFirstLetter(patientsList[index].name),
                            ),
                          ],
                        ));
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}
