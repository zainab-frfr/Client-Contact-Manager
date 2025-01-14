import 'package:client_contact_manager/bloc/info_bloc.dart';
import 'package:client_contact_manager/ui/view/view_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
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
