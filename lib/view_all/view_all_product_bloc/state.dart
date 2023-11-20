import '../../dart_grpc_server.dart';



abstract class ViewAllProductState {}

class ViewAllInitial extends ViewAllProductState {}


class ViewAllProductLoadingState extends ViewAllProductState {}

class ViewAllProductLoadedState extends ViewAllProductState {
  ViewAllProductLoadedState({required this.viewAll});
  final Items viewAll;
}

class NoProductFoundState extends ViewAllProductState {}







