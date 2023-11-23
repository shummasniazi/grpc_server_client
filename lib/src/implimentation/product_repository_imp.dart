
import 'dart:math';

import 'package:grpc/grpc.dart';

import '../../dart_grpc_server.dart';


class ProductRepositoryImp {
  ProductRepositoryImp._internal();
  static final ProductRepositoryImp _productRepositoryImp =
  ProductRepositoryImp._internal();
  GroceriesServiceClient? stub;
  ClientChannel? channel;
  var response;
  factory ProductRepositoryImp() {
    return _productRepositoryImp;
  }

  Future<Items> viewAllProducts() async {
    channel = ClientChannel(
      'localhost',
      port: 50000,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = GroceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));
    response = await stub!.getAllItems(Empty());

    print(' --- Store products --- ');
    response.items.forEach((item) {
      print(
          '✅: ${item.name} (id: ${item.id} | categoryId: ${item.categoryId})');
    });
    return response;
  }



  Future<Items> addNewProducts(String? productName, String? categoryName) async {
    channel = ClientChannel(
      'localhost',
      port: 50000,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = GroceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));
    print('Enter product name');
    // var name = stdin.readLineSync()!;
    var item = await _findItemByName(productName!);
    if(item.id != 0){
      print('🔴 product already exists: name ${item.name} | id: ${item.id} ');
    }else{
      // print('Enter product\'s category name');
      // var categoryName = stdin.readLineSync()!;
      var category = await _findCategoryByName(categoryName!);
      if(category.id == 0){
        print('🔴 category $categoryName does not exists, try creating it first');
      }else{
        item = Item()
          ..name = productName
          ..id = _randomId()
          ..categoryId = category.id;
        response = await stub!.createItem(item);
        print('✅ product created | name ${response.name} | id ${response.id} | category id ${response.categoryId}');
      }

    }
    return response;
  }



  int _randomId() => Random(1000).nextInt(9999);


  Future<Category> _findCategoryByName(String name) async {
    var category = Category()
      ..name = name;
    category = await stub!.getCategory(category);
    return category;
  }

  Future<Item> _findItemByName(String name) async {
    var item = Item()
      ..name = name;
    item = await stub!.getItem(item);
    return item;
  }

}
