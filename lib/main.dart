import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sus_lifo_frontend/screens/patient_form.dart';
import 'package:sus_lifo_frontend/screens/patient_queue.dart';
import 'package:sus_lifo_frontend/styles/color_schemes.g.dart';
import 'package:sus_lifo_frontend/styles/custom_color.g.dart';
import 'package:sus_lifo_frontend/styles/typography.dart';
import 'package:sus_lifo_frontend/models/patient_list_viewmodel.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => PatientListViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          extensions: [lightCustomColors],
          textTheme: textTheme),
      routes: {
        '/': (context) => const PatientQueue(),
        '/patient': (context) => const PatientForm(),
      },
    );
  }
}
