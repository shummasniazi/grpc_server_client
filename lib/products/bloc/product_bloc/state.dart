
import '../../../dart_grpc_server.dart';

abstract class ProductsState {}

class ProductInitial extends ProductsState {}


class AddProductLoadingState extends ProductsState {}

class AddProductLoadedState extends ProductsState {
  AddProductLoadedState({required this.viewAll});
  final Item viewAll;
}

class ProductNotAddedState extends ProductsState {}




class ViewAllProductLoadingState extends ProductsState {}

class ViewAllProductLoadedState extends ProductsState {
  ViewAllProductLoadedState({required this.viewAll});
  final Items viewAll;
}

class NoProductFoundState extends ProductsState {}