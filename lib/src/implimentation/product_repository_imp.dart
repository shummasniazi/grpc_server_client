
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

}
