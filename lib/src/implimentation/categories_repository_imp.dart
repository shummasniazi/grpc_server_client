
import 'dart:math';

import 'package:grpc/grpc.dart';

import '../../dart_grpc_server.dart';


class CategoriesRepositoryImp {
  CategoriesRepositoryImp._internal();
  static final CategoriesRepositoryImp _categoriesRepositoryImp =
  CategoriesRepositoryImp._internal();
  GroceriesServiceClient? stub;
  ClientChannel? channel;
  var response;
  factory CategoriesRepositoryImp() {
    return _categoriesRepositoryImp;
  }

  Future<Categories> getAllCategories() async {
    channel = ClientChannel(
      'localhost',
      port: 50000,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = GroceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));


    response = await stub!.getAllCategories(Empty());

    print(' --- Store product categories --- ');
    response.categories.forEach((category) {
      print('👉: ${category.name} (id: ${category.id})');
    });

    // print(' --- Store products --- ');
    // response.items.forEach((item) {
    //   print(
    //       '✅: ${item.name} (id: ${item.id} | categoryId: ${item.categoryId})');
    // });
    return response;
  }

  Future<Categories> createCategory(String? name) async {
    channel = ClientChannel(
      'localhost',
      port: 50000,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = GroceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));


    print('Enter category name');
    // var name = stdin.readLineSync()!;
    var category = await _findCategoryByName(name!);
    if(category.id != 0){
      print('🔴 category already exists: category ${category.name} (id: ${category.id})');
    }else{
      category =
      Category()
        ..id = _randomId()
        ..name = name;
      response = await stub!.createCategory(category);
      print('✅ category created: name ${category.name} (id: ${category.id})');
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
