import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

import 'Product.dart';



class ViewProduct extends StatefulWidget{
  final Products product;
  ViewProduct({super.key,required this.product});
  ViewProductState createState(){
    return ViewProductState();
  }
}
class ViewProductState extends State<ViewProduct>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.black,),
        title: Text(widget.product.title.toString(),style:  TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
      ),
      body:Padding(padding:EdgeInsets.symmetric(horizontal: 500),
          child: Form(
            child:
            ListView(
              children: [
                SizedBox(
                    height: 200,
                    child:
                    Carousel(
                        autoplay: false,
                        showIndicator: false,
                        images: widget.product.images!.map((e)=>Container(
                          height: 600,width: 400,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:NetworkImage(e))
                          ),
                        )).toList()
                    )
                ),
                Padding(padding: EdgeInsets.all(30),
                    child:Form(child: Column(children: [
                      Text(widget.product.title.toString(),style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),),

                      SizedBox(height: 10,),
                      Text("Brand : ${widget.product.brand.toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),

                      SizedBox(height: 10,),
                      Text("Price : \$${widget.product.price.toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                      SizedBox(height: 10,),
                      Text("Discount :${widget.product.discountPercentage.toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),

                      SizedBox(height: 10,),
                      Text("Rating : ${widget.product.rating.toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),

                      SizedBox(height: 10,),
                      Text(widget.product.description.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                    ]
                    ))),
              ],
            ),)),

      bottomSheet: Container(
          height: 70,width: double.infinity,
          padding: EdgeInsets.only(bottom: 20),
          margin: EdgeInsets.only(top: 10,right: 20,left: 20,bottom: 30),
          child: ElevatedButton(onPressed: (){},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white
            ), child: Text("BUY",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),)),
    );
  }
}
