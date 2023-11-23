import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../dart_grpc_server.dart';
import '../bloc/product_bloc/bloc.dart';
import '../bloc/product_bloc/event.dart';
import '../bloc/product_bloc/state.dart';

displayAddProductSheet(context, {allCategories}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: WillPopScope(
              onWillPop: () async {
                bool? result = await _onBackPressed(context);
                result ??= false;
                return result;
              },
              child: GestureDetector(
                onTap: () {},
                child: MultiBlocProvider(
                  providers: const [
                    // BlocProvider<SubmitRatingBloc>(
                    //     create: (context) => SubmitRatingBloc()),
                  ],
                  child: Container(
                    // width: getScreenWidth(context),
                    // height: 300,
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      bottom: 20,
                    ),
                    child: AddProduct(allCategories: allCategories),
                  ),
                ),
              ),
            ));
      });
}

_onBackPressed(context) {
  Navigator.pop(context);
}

class AddProduct extends StatefulWidget {
  final Categories? allCategories;

  const AddProduct({super.key, this.allCategories});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  String? categoryName;
  ProductsBloc? productsBloc;

  bool categorySelected = false;

  @override
  void initState() {
    productsBloc = ProductsBloc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            const Text("Enter Product Name"),
            Container(
              height: 150,
              margin: EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(153, 153, 153, 0.25),
                      offset: Offset(0, 0),
                      blurRadius: 7,
                      spreadRadius: 0,
                    ),
                  ],
                  //  border: Border.all(color:AppColors.outlineBorderColor),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                onTap: null,
                cursorColor: Colors.black,
                cursorHeight: 14,
                maxLines: 20,
                // maxLength: 500,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                controller: nameController,
                decoration: const InputDecoration(
                  enabled: true,
                  border: InputBorder.none,
                  focusColor: Colors.black,
                  labelText: ' Add name here!',
                  labelStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const Text("Select Category"),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.allCategories!.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        if(categorySelected){
                          setState(() {
                            categorySelected = !categorySelected;
                            categoryName =
                                widget.allCategories!.categories[index].name;
                          });
                        }{
                          setState(() {
                            categorySelected = true;
                            categoryName =
                                widget.allCategories!.categories[index].name;
                          });
                        }


                      },
                      child:
                          Text(widget.allCategories!.categories[index].name,style: TextStyle(color:categorySelected?Colors.green: Colors.black),),);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                productsBloc!
                    .add(AddNewProduct(nameController.text, categoryName));
              },
              child: const Text('Add Product'),
            ),
          ],
        );
      },
    );
  }
}
