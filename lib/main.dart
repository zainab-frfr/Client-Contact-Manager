import 'dart:io';

import 'package:client_contact_manager/bloc/info_bloc.dart';
import 'package:client_contact_manager/ui/view/view_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  await startBackend();
  runApp(const MainApp());
}

Future<void> startBackend() async {
  try {
    String backendPath = 'backend';
    Process.start(
      'npm',
      ['start'], // Arguments for npm
      workingDirectory: backendPath, 
      runInShell: true, 
    ).then((process) {
      debugPrint('Backend started successfully!');

      // Optionally, listen to the output of the backend
      process.stdout.transform(const SystemEncoding().decoder).listen((data) {
        debugPrint('Backend output: $data');
      });

      process.stderr.transform(const SystemEncoding().decoder).listen((error) {
        debugPrint('Backend error: $error');
      });
    });
  } catch (e) {
    debugPrint('Failed to start backend: $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfoBloc()..add(FetchInformation()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ViewClientPage()
      ),
    );
  }
}
