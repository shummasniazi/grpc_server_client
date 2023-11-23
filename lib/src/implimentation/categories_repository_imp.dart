
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

}
