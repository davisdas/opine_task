import 'package:flutter/material.dart';
import 'package:opine_task/controller/category_controller.dart';
import 'package:opine_task/controller/meals_controller.dart';
import 'package:opine_task/view/categories/categories.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        ),
        ChangeNotifierProvider(create: (context) => MealsController(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Categories(),
      ),
    );
  }
}
