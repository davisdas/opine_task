import 'package:flutter/material.dart';
import 'package:opine_task/controller/category_controller.dart';
import 'package:opine_task/utils/constants/color_constants.dart';
import 'package:opine_task/view/meals/meals.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // api function call
    Provider.of<CategoryController>(context, listen: false).fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryController>(context);
    return Scaffold(
        appBar: AppBar(
          // title
          centerTitle: true,
          title: Text(
            'Categories',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: ColorConstants.background,
        body: provider.isLoading == true
            ?
            // server loading
            Center(
                child: CircularProgressIndicator(),
              )

            // server loaded
            : provider.categoryResponse!.categories!.length == 0
                ? Center(
                    child: Text(
                    'Category list is empty',
                    style: TextStyle(color: ColorConstants.textColor),
                  ))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: provider.categoryResponse!.categories!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Meals(
                                    categoryName: provider.categoryResponse!
                                        .categories![index].strCategory
                                        .toString()),
                              ));
                        },
                        child: Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorConstants.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // category name
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${provider.categoryResponse!.categories![index].strCategory}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    // image
                                    provider
                                                .categoryResponse!
                                                .categories![index]
                                                .strCategoryThumb !=
                                            null
                                        ? Image.network(
                                            '${provider.categoryResponse!.categories![index].strCategoryThumb}',
                                            height: 170,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.4,
                                          )
                                        : SizedBox(),

                                    // category description
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 20),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        child: Text(
                                          '${provider.categoryResponse!.categories![index].strCategoryDescription}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: ColorConstants.textColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
  }
}
