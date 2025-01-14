part of 'info_bloc.dart';

sealed class InfoState{
  const InfoState();
}

final class LoadingState extends InfoState{}

final class FetchedState extends InfoState{
  final List<Client> clients;
  const FetchedState({required this.clients});
}

final class ErrorState extends InfoState{
  final String errorMessage; 
  const ErrorState({required this.errorMessage});
}
