import 'package:flutter/material.dart';

import '../dart_grpc_server.dart';

class ViewAllProductsScreen extends StatefulWidget {


  ViewAllProductsScreen();

  @override
  _ViewAllProductsScreenState createState() => _ViewAllProductsScreenState();
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  GroceriesServiceClient? stub;
  List<Items>? products;
  var response;

  @override
  void initState() {
    _viewAllProducts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: ListView.builder(
        itemCount: products!.length,
        itemBuilder: (context, index) {
          // final product = widget.products[index];
          return ListTile(
            title: Text('✅ ${products![index].items}'),
            subtitle: Text('ID: ${products![index].items[index].name} | Category ID: ${products![index].items[index].categoryId}'),
          );
        },
      ),
    );
  }

  void _viewAllProducts() async {
    response = await stub!.getAllItems(Empty());
    products = response.items;
    print(' --- Store products --- ');
    response.items.forEach((item) {
      print('✅: ${item.name} (id: ${item.id} | categoryId: ${item.categoryId})');
    });
  }

}