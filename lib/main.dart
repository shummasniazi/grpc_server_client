import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_client/products/bloc/product_bloc/bloc.dart';
import 'package:grpc_client/products/ui/add_new_product.dart';
import 'package:grpc_client/products/ui/view_all_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'categories/bloc/categories_bloc/bloc.dart';
import 'categories/bloc/categories_bloc/event.dart';
import 'categories/bloc/categories_bloc/state.dart';
import 'dart_grpc_server.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc()),
    ],
    child: MaterialApp(home: ClientApp()),
  ));
}

class ClientApp extends StatefulWidget {
  @override
  _ClientAppState createState() => _ClientAppState();
}

class _ClientAppState extends State<ClientApp> {
  ClientChannel? channel;
  GroceriesServiceClient? stub;
  var response;
  bool executionInProgress = true;

  Categories? categories;

  CategoriesBloc? categoriesBloc;
  @override
  void initState() {
    super.initState();
    categoriesBloc = CategoriesBloc();
    categoriesBloc!.add(ViewAllCategory());
    channel = ClientChannel(
      'localhost',
      port: 50000,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = GroceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));
  }

  @override
  void dispose() {
    channel?.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart Store API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Dart Store API'),
            Text('What do you want to do?'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewAllProductsScreen()));
              },
              child: Text('View All Products'),
            ),
            BlocConsumer<CategoriesBloc, CategoriesState>(
              bloc: categoriesBloc,
              listener: (context, state) {
                if(state is CategoriesLoadedState){
                  categories = state.viewAll;
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: ()=>displayAddProductSheet(context, allCategories:categories),
                  child: Text('Add New Product'),
                );
              },
            ),
            // Add buttons and handlers for other options
          ],
        ),
      ),
    );
  }

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

  int _randomId() => Random(1000).nextInt(9999);

  void _viewAllProducts() async {
    response = await stub!.getAllItems(Empty());
    print(' --- Store products --- ');
    response.items.forEach((item) {
      print(
          '✅: ${item.name} (id: ${item.id} | categoryId: ${item.categoryId})');
    });
  }

  void _addNewProduct() async {
    print('Enter product name');
    var name = "apple";
    var item = await _findItemByName(name);
    if (item.id != 0) {
      print('🔴 product already exists: name ${item.name} | id: ${item.id} ');
    } else {
      print('Enter product\'s category name');
      var categoryName = "Fruits";
      var category = await _findCategoryByName(categoryName);
      if (category.id == 0) {
        print(
            '🔴 category $categoryName does not exists, try creating it first');
      } else {
        item = Item()
          ..name = name
          ..id = _randomId()
          ..categoryId = category.id;
        response = await stub!.createItem(item);
        print(
            '✅ product created | name ${response.name} | id ${response
                .id} | category id ${response.categoryId}');
      }
    }
    // Implement the add new product logic here
    // Use setState to update the UI with the result
  }

// Implement handlers for other options as needed
}
