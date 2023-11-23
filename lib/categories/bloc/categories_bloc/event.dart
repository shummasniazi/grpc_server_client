abstract class CategoriesEvent {}

class InitEvent extends CategoriesEvent {}

class AddNewCategory extends CategoriesEvent {}
class AddNewCategoryLoading extends CategoriesEvent {}
class AddNewCategoryLoaded extends CategoriesEvent {}
class AddNewCategoryError extends CategoriesEvent {}



class ViewAllCategory extends CategoriesEvent {}
class ViewAllLoading extends CategoriesEvent {}
class ViewAllLoaded extends CategoriesEvent {}
class ViewAllError extends CategoriesEvent {}

