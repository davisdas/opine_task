import 'package:flutter/material.dart';
import 'package:opine_task/model/cart_model.dart';
import 'package:opine_task/model/meals_model.dart';

class CartController extends ChangeNotifier {
  // cart items list
  List<CartModel> cart = [];
  MealsModel? mealData;
  List cartItems = [];

  // add to cart
  void addToCart(Meal meal) {
    print(meal.idMeal);
    print(cart.length);
// to check whether the item is in cart or not with the meal id
    bool isInList = cart.any((element) => element.meal.idMeal == meal.idMeal);
    print(isInList);
    if (isInList) {
      cart = cart
          .map((e) => CartModel(
              itemCount: e.meal.idMeal == meal.idMeal
                  ? (e.itemCount + 1)
                  : e.itemCount,
              meal: e.meal))
          .toList();
    } else {
      cart.add(CartModel(meal: meal, itemCount: 1));
    }
    notifyListeners();
  }

  
}
