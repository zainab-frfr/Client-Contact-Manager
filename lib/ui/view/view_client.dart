import 'package:client_contact_manager/bloc/info_bloc.dart';
import 'package:client_contact_manager/data/client_model.dart';
import 'package:client_contact_manager/ui/widgets/input_field.dart';
import 'package:client_contact_manager/ui/widgets/my_button.dart';
import 'package:client_contact_manager/ui/widgets/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewClientPage extends StatelessWidget {
  const ViewClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Client Contact Manager', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: BlocBuilder<InfoBloc,InfoState>(
            builder: (context, state) {
              switch (state){
                case LoadingState():
                  return const Center(child: CircularProgressIndicator(),);
                case FetchedState():
                  return MyTable(allClients: state.clients,);
                case ErrorState():
                  return Center(child: Text(state.errorMessage));
              }
            },
          )
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    inputInformation(context);
                  },
                  child: const Text('Add Row', style: TextStyle(color: Colors.black),),
                ),
                const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: (){
                    editInformation(context);
                  },
                  child: const Text('Edit Row', style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

void inputInformation(BuildContext context){
  TextEditingController myClientController = TextEditingController();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController name3 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController email3 = TextEditingController();
  TextEditingController phnNum1 = TextEditingController();
  TextEditingController phnNum2 = TextEditingController();
  TextEditingController phnNum3 = TextEditingController();

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter Information'),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  MyInputField(labelText: 'Client Name', obscureText: false, controller: myClientController),
                  const SizedBox(height: 10,),
                  const Text('Contact 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  const SizedBox(height: 10,),
                  MyInputField(labelText: 'Name', obscureText: false, controller: name1),
                  const SizedBox(height: 5,),
                  MyInputField(labelText: 'Email', obscureText: false, controller: email1),
                  const SizedBox(height: 5,),
                  MyInputField(labelText: 'Phone Number', obscureText: false, controller: phnNum1),
                  
                  const SizedBox(height: 10,),
                  const Text('Contact 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  const SizedBox(height: 10,),
                  MyInputField(labelText: 'Name', obscureText: false, controller: name2),
                  const SizedBox(height: 5,),
                  MyInputField(labelText: 'Email', obscureText: false, controller: email2),
                  const SizedBox(height: 5,),
                  MyInputField(labelText: 'Phone Number', obscureText: false, controller: phnNum2),
                  
                  const SizedBox(height: 10,),
                  const Text('Contact 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  const SizedBox(height: 10,),
                  MyInputField(labelText: 'Name', obscureText: false, controller: name3),
                  const SizedBox(height: 5,),
                  MyInputField(labelText: 'Email', obscureText: false, controller: email3),
                  const SizedBox(height: 5,),
                  MyInputField(labelText: 'Phone Number', obscureText: false, controller: phnNum3),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton(
                onTap: (){
                  myClientController.dispose();
                  name1.dispose();
                  name2.dispose();
                  name3.dispose();
                  email1.dispose();
                  email2.dispose();
                  email3.dispose();
                  phnNum1.dispose();
                  phnNum2.dispose();
                  phnNum3.dispose();  
                  Navigator.pop(context);
                }, 
                color:Colors.red[300]!, 
                text: 'Cancel'
              ),
              MyButton(
                onTap: (){
                  bool valid = formKey.currentState?.validate()??false;

                  if(valid){
                    final data = {
                      'name': myClientController.text,
                      'lastUpdated': DateTime.now().toString(),

                      'name1': name1.text,
                      'email1': email1.text,
                      'phnNum1': phnNum1.text,

                      'name2': name2.text,
                      'email2': email2.text,
                      'phnNum2': phnNum2.text,

                      'name3': name3.text,
                      'email3': email3.text,
                      'phnNum3': phnNum3.text,
                    };
                    
                    context.read<InfoBloc>().add(AddInformation(client: Client.fromJson(data)));

                    Navigator.pop(context);

                  }
                }, 
                color:Colors.green[300]!, 
                text: '  Ok  '
              )
            ],
          )
        ],
      );
    },
  );
}

void editInformation(BuildContext context){
  TextEditingController myClientController = TextEditingController();

  TextEditingController attribute = TextEditingController();
  TextEditingController value = TextEditingController();

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter Information'),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  MyInputField(labelText: 'Client Name', obscureText: false, controller: myClientController),
                  const SizedBox(height: 12,),
                  MyInputField(labelText: 'Attribute', obscureText: false, controller: attribute),
                  const SizedBox(height: 1,),
                  const Text('Attribute: name1/email1/phnNum1/name2/email2/phnNum2..', style:TextStyle(color: Colors.grey, fontSize: 10)),
                  const SizedBox(height: 10,),
                  MyInputField(labelText: 'New Value', obscureText: false, controller: value),                 
                ],
              ),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton(
                onTap: (){
                  myClientController.dispose();
                  attribute.dispose();
                  value.dispose();
                  Navigator.pop(context);
                }, 
                color:Colors.red[300]!, 
                text: 'Cancel'
              ),
              MyButton(
                onTap: (){
                  bool valid = formKey.currentState?.validate()??false;

                  if(valid){
                    final data = {
                      'name': myClientController.text,
                      'lastUpdated': DateTime.now().toIso8601String().substring(0, 19),

                      attribute.text: value.text,
                    };
                    
                    context.read<InfoBloc>().add(EditInformation(information: data));

                    Navigator.pop(context);

                  }
                }, 
                color:Colors.green[300]!, 
                text: '  Ok  '
              )
            ],
          )
        ],
      );
    },
  );
}