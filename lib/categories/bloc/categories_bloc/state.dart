
import '../../../dart_grpc_server.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}


class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  CategoriesLoadedState({required this.viewAll});
  final Categories viewAll;
}

class CategoriesNotAddedState extends CategoriesState {}