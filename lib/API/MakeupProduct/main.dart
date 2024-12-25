import 'package:flutter/material.dart';
import 'package:flutterproject/API/MakeupProduct/Home_Screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Product.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  MyApp({super.key});
  Widget build(BuildContext context){
    return GetMaterialApp(
      title: "Makeup Products",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen1(),
    );
  }
}


class ApiClient {

  Future<ProductModel?> getProduct() async {
    var response = await http.get(
        Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      ProductModel productModel = ProductModel.fromJson(
          jsonDecode(response.body));
      return productModel;
    }
    return null;
  }

}
