import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import '../../dart_grpc_server.dart';
import '../view_all_product_bloc/bloc.dart';
import '../view_all_product_bloc/event.dart';
import '../view_all_product_bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllProductsScreen extends StatefulWidget {
  const ViewAllProductsScreen({super.key});

  @override
  _ViewAllProductsScreenState createState() => _ViewAllProductsScreenState();
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  ClientChannel? channel;
  GroceriesServiceClient? stub;
  Items? products;
  ViewAllProductBloc? viewAllProductBloc;

  bool isLoading = false;

  @override
  void initState() {
    viewAllProductBloc = ViewAllProductBloc();
    viewAllProductBloc!.add(ViewAllProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewAllProductBloc, ViewAllProductState>(
      bloc: viewAllProductBloc,
      listener: (context, state) {
        if (state is ViewAllProductLoadingState) {
          isLoading = true;
        } else if (state is ViewAllProductLoadedState) {
          products = state.viewAll;
          isLoading = false;
        }
      },
      builder: (context, state) {
        return isLoading
            ? const CircularProgressIndicator(color: Colors.blueAccent,)
            : Scaffold(
                appBar: AppBar(),
                body: products != null
                    ? Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: products!.items.length,
                          itemBuilder: (context, index) {
                            // final product = widget.products[index];
                            return Text(
                                'ID: ${products!.items[index].name} \n Category ID: ${products!.items[index].categoryId}');
                          },
                        ),
                      )
                    : Container(),
              );
      },
    );
  }

// void _viewAllProducts() async {
//   response = await stub!.getAllItems(Empty());
//   print(' --- Store products --- ');
//   products = response.items;
//
//   response.items.forEach((item) {
//     print('✅: ${item.name} (id: ${item.id} | categoryId: ${item.categoryId})');
//   });
// }

}
