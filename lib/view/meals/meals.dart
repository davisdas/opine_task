import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:opine_task/controller/meals_controller.dart';
import 'package:opine_task/utils/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Meals extends StatefulWidget {
  final String categoryName;
  const Meals({super.key, required this.categoryName});

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // calling api function
    Provider.of<MealsController>(context, listen: false)
        .fetchData(widget.categoryName, context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealsController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        // back button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),

        // title
        centerTitle: true,
        title: Text(
          '${widget.categoryName} items',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: provider.isLoading == true
          ?
          // server loading
          Center(
              child: CircularProgressIndicator(),
            )

          // server loaded
          : provider.mealData!.meals!.length == 0
              ? Center(
                  child: Text(
                  'Meals are empty',
                  style: TextStyle(color: ColorConstants.textColor),
                ))
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: MasonryGridView.count(
                    padding: EdgeInsets.all(5),
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 3,
                    itemCount: provider.mealData!.meals!.length,
                    itemBuilder: (context, index) => Card(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // meal name
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${provider.mealData!.meals![index].strMeal}',
                                  style: TextStyle(
                                      color: ColorConstants.textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              // meal image
                              provider.mealData!.meals![index].strMealThumb !=
                                      null
                                  ? Container(
                                      height: 200,
                                      width: 200,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(provider
                                                  .mealData!
                                                  .meals![index]
                                                  .strMealThumb
                                                  .toString()),
                                              fit: BoxFit.contain)),
                                    )
                                  : SizedBox()
                            ]),
                      ),
                    ),
                  )),
    );
  }
}
