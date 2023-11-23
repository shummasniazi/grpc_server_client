abstract class ProductsEvent {}

class AddProductInitEvent extends ProductsEvent {}
class AddNewProduct extends ProductsEvent {

  final String? productName;
  final String? categoryName;

  AddNewProduct(this.productName,this.categoryName);



}





class ViewAllProductInitEvent extends ProductsEvent {}
class ViewAllProduct extends ProductsEvent {}
