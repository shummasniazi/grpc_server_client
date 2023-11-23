import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../src/implimentation/product_repository_imp.dart';

import 'event.dart';
import 'state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepositoryImp repository = ProductRepositoryImp();

  ProductsBloc() : super(ProductInitial()) {
    on<ProductsEvent>((event, emit) async {
      await _mapEventToState(event, emit);
    });
  }

  FutureOr<void> _mapEventToState(ProductsEvent event,
      Emitter<ProductsState> emit) async {
    if (event is AddNewProduct) {
      await _mapEventAddNewProductsToState(event, emit);
    }
  }

  FutureOr<void> _mapEventAddNewProductsToState(AddNewProduct event,
      Emitter<ProductsState> emit) async {
    emit(AddProductLoadingState());
    try {
      final response = await repository.viewAllProducts();
      if (response.items.isEmpty) {

      } else {
        emit(AddProductLoadedState(viewAll: response));
      }
    } catch (e) {
      print(e.toString());
      //emit(ErrorState(error: e.toString()));
    }
  }
}