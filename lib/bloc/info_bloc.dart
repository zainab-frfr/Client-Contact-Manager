import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client_contact_manager/data/client_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(LoadingState()) {
    on<FetchInformation>(_fetchInfo);
    on<AddInformation>(_addInfo);
    on<EditInformation>(_editInfo);
  }

  Future<void> _fetchInfo(FetchInformation event, Emitter<InfoState> emit) async {
    emit(LoadingState());
    List<Client> clients = await fetchInfoFromAPICall();
    emit(FetchedState(clients: clients));
  }

  Future<List<Client>> fetchInfoFromAPICall() async {
    final url = Uri.parse("http://localhost:4449/api/information");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); 

        if (data['data'] is List) {
          return (data['data'] as List)
              .map<Client>((comCenter) => Client.fromJson({
                    'name': comCenter[0],
                    'lastUpdated': comCenter[1],
                    'name1': comCenter[2],
                    'email1': comCenter[3],
                    'phnNum1': comCenter[4],
                    'name2': comCenter[5],
                    'email2': comCenter[6],
                    'phnNum2': comCenter[7],
                    'name3': comCenter[8],
                    'email3': comCenter[9],
                    'phnNum3': comCenter[10],
                  }))
              .toList();
        } else {
          debugPrint('Data format error: Expected a List.');
          return [];
        }
      } else {
        debugPrint("HTTP Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
      return [];
    }
  }

  Future<void> _addInfo(AddInformation event, Emitter<InfoState> emit) async {
    emit(LoadingState());
    final data = {
      'name': event.client.name,
      'lastUpdated': event.client.lastUpdated.toIso8601String().substring(0, 19),

      'name1': event.client.contact1.name,
      'email1': event.client.contact1.email,
      'phnNum1': event.client.contact1.phnNum,

      'name2': event.client.contact2.name,
      'email2': event.client.contact2.email,
      'phnNum2': event.client.contact2.phnNum,

      'name3': event.client.contact3.name,
      'email3': event.client.contact3.email,
      'phnNum3': event.client.contact3.phnNum,
    };

    await addInfoBackend(data);
    add(FetchInformation());
  }

  Future<void> addInfoBackend(Map<String, dynamic> data) async {

    final url = Uri.parse("http://localhost:4449/api/information");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data), // Encode the data into JSON format
      );

      if (response.statusCode == 200) {
        debugPrint('data successfully sent to the backend');
      } else {
        debugPrint('Failed to send data: ${response.statusCode}');
        debugPrint('Error message: ${response.body}');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }

  Future<void> _editInfo(EditInformation event, Emitter<InfoState> emit) async {
    emit(LoadingState());
    await editinfoBackend(event.information);
    add(FetchInformation());
  }

  Future<void> editinfoBackend(Map<String, dynamic> updatedData) async {
    final url = Uri.parse("http://localhost:4449/api/information");
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData), 
      );

      if (response.statusCode == 200) {
        debugPrint('Information updated successfully: ${response.body}');
      } else {
        debugPrint('Failed to update information: ${response.statusCode}');
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }
}
