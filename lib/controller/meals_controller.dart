import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opine_task/model/meals_model.dart';

class MealsController with ChangeNotifier {
  // Loading boolean
  bool isLoading = true;
  //  Data of meals
  MealsModel? mealData;

  // function to get meals
  Future<void> fetchData(String categoryName, BuildContext context) async {
    isLoading = true;
    var url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=${categoryName}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      mealData = MealsModel.fromJson(responseData);
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
