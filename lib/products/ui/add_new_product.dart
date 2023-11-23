

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../dart_grpc_server.dart';

displayAddProductSheet(context,) {
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
                    child: AddProduct(),
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
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController nameController = TextEditingController();





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Text("Enter Product Name"),

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
              labelText: ' Add comment here!',
              labelStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),


        Text("Select Category"),

        // Container(
        //   child: ListView.builder(itemBuilder: itemBuilder),
        // )



      ],
    );
  }


  getAllCategories(){
    // response = await stub!.getAllCategories(Empty());
    // print(' --- Store product categories --- ');
    // response.categories.forEach((category) {
    //   print('👉: ${category.name} (id: ${category.id})');
    // });
  }

}

