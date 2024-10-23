import 'dart:convert';

import 'package:arcitech/features/home/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final searchProductAPIprovider = FutureProvider<List<Product>>((ref) async{
   const String _baseURL = 'https://dummyjson.com/products?limit=0&select=id,title,brand,price,discountPercentage,images,category,description';
   final responce  = await  http.get(Uri.parse(_baseURL));
   if(responce.statusCode == 200){
     List<dynamic> jsonResponce = jsonDecode(responce.body)['products'];
     return jsonResponce.map((value) => Product.fromJson(value)).toList();
   }
   else {
     debugPrint("Some error occour while fetching data");
     return [];
   }

});

