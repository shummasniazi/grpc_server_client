
import 'package:grpc/grpc.dart';

import '../../dart_grpc_server.dart';


class ViewAllRepositoryImp {
  ViewAllRepositoryImp._internal();
  static final ViewAllRepositoryImp _viewAllRepositoryImp =
  ViewAllRepositoryImp._internal();
  GroceriesServiceClient? stub;
  ClientChannel? channel;
  var response;
  factory ViewAllRepositoryImp() {
    return _viewAllRepositoryImp;
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
