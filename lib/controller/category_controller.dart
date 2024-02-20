import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opine_task/model/category_model.dart';

class CategoryController with ChangeNotifier {
  // loading boolean
  bool isLoading = true;
  //  categories
  CategoryModel? categoryResponse;

  //  get all categories from server
  Future<void> fetchData(BuildContext context) async {
    isLoading = true;
    var url =
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      categoryResponse = CategoryModel.fromJson(responseData);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Server error'),
        ),
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
