import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/API/MakeupProduct/View_Product.dart';
import 'package:flutterproject/API/MakeupProduct/main.dart';
import 'Product.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  HomeScreen1State createState() => HomeScreen1State();
}

class HomeScreen1State extends State<HomeScreen1> {
  ProductModel? _productModel; // State variable to hold product data
  bool _isLoading = true; // State variable for loading
  String? _errorMessage; // State variable for error message

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ApiClient apiClient = ApiClient();
      ProductModel? productModel = await apiClient.getProduct();
      if (productModel != null) {
        setState(() {
          _productModel = productModel;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to load products.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle:true ,
        title:
        Text("PRODUCTS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      ),
      body: _isLoading
          ?  Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _productModel == null || _productModel!.products!.isEmpty
          ?  Center(child: Text("No products available."))
          : ProductList(_productModel!),
    );
  }

  Widget ProductList(ProductModel productList) {
    return ListView.builder(
      itemCount: productList.products!.length,
      itemBuilder: (context, index) {
        final data = productList.products![index];
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProduct(product: data),
                ),
              );
            },
            child: OpenContainer(closedBuilder: (context,container){
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:  EdgeInsets.only(right: 15),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data.thumbnail ?? ""),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title ?? "No title",
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Price: \$${data.price?.toStringAsFixed(2) ?? "N/A"}",
                                style:  TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Discount: ${data.discountPercentage?.toStringAsFixed(1) ?? "N/A"}%",
                                style:  TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        data.description ?? "No description available.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              );
            }, openBuilder: (context,_){
              return ViewProduct(product: data);
            })
        );
      },
    );
  }
}
