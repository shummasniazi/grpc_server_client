import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../src/implimentation/categories_repository_imp.dart';

import 'event.dart';
import 'state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepositoryImp repository = CategoriesRepositoryImp();

  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) async {
      await _mapEventToState(event, emit);
    });
  }

  FutureOr<void> _mapEventToState(
      CategoriesEvent event, Emitter<CategoriesState> emit) async {
    if (event is AddNewCategory) {
      await _mapEventAddNewCategoryToState(event, emit);
    }
    if (event is ViewAllCategory) {
      await _mapEventGetAllCategoriesToState(event, emit);
    }
  }

  FutureOr<void> _mapEventAddNewCategoryToState(
      AddNewCategory event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());
    try {
      final response = await repository.getAllCategories();
      if (response.categories.isEmpty) {
      } else {
        emit(CategoriesLoadedState(viewAll: response));
      }
    } catch (e) {
      print(e.toString());
      //emit(ErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _mapEventGetAllCategoriesToState(
      ViewAllCategory event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());
    try {
      final response = await repository.getAllCategories();
      if (response.categories.isEmpty) {
      } else {
        emit(CategoriesLoadedState(viewAll: response));
      }
    } catch (e) {
      print(e.toString());
      //emit(ErrorState(error: e.toString()));
    }
  }

}
