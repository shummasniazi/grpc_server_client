import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../src/implimentation/view_all_imp.dart';
import 'event.dart';
import 'state.dart';

class ViewAllProductBloc extends Bloc<ViewAllProductEvent, ViewAllProductState> {
  ViewAllRepositoryImp repository = ViewAllRepositoryImp();

  ViewAllProductBloc() : super(ViewAllInitial()) {
    on<ViewAllProductEvent>((event, emit) async {
      await _mapEventToState(event, emit);
    });
  }

  FutureOr<void> _mapEventToState(ViewAllProductEvent event,
      Emitter<ViewAllProductState> emit) async {
    if (event is ViewAllProduct) {
      await _mapEventViewAllProductsToState(event, emit);
    }
  }

  FutureOr<void> _mapEventViewAllProductsToState(ViewAllProduct event,
      Emitter<ViewAllProductState> emit) async {
    emit(ViewAllProductLoadingState());
    try {
      final response = await repository.viewAllProducts();
      if (response.items.isEmpty) {

      } else {
        emit(ViewAllProductLoadedState(viewAll: response));
      }
    } catch (e) {
      print(e.toString());
      //emit(ErrorState(error: e.toString()));
    }
  }
}