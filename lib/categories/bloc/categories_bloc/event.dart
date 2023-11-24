abstract class CategoriesEvent {}

class InitEvent extends CategoriesEvent {}

class AddNewCategory extends CategoriesEvent {
  final String? categoryName;
  AddNewCategory(this.categoryName);
}
class AddNewCategoryLoading extends CategoriesEvent {}
class AddNewCategoryLoaded extends CategoriesEvent {}
class AddNewCategoryError extends CategoriesEvent {}



class ViewAllCategory extends CategoriesEvent {}
class ViewAllLoading extends CategoriesEvent {}
class ViewAllLoaded extends CategoriesEvent {}
class ViewAllError extends CategoriesEvent {}

