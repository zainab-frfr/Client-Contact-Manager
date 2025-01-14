part of 'info_bloc.dart';

sealed class InfoEvent{
  const InfoEvent();
}

final class FetchInformation extends InfoEvent{}

final class AddInformation extends InfoEvent{
  final Client client;
  const AddInformation({required this.client});
}

final class EditInformation extends InfoEvent{
  final Map<String, dynamic> information; 
  const EditInformation({required this.information});
}