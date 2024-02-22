import 'package:flutter/material.dart';
import 'package:opine_task/controller/cart_controller.dart';
import 'package:opine_task/utils/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartController>(context);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        // title
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: provider.cart.length,
            itemBuilder: (context, index) => Card(
                    child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorConstants.white),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // item name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${provider.cart[index].meal.strMeal}',
                            style: TextStyle(
                                color: ColorConstants.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // image
                            Container(
                              height: 150,
                              width: 150,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(provider
                                          .cart[index].meal.strMealThumb
                                          .toString()),
                                      fit: BoxFit.contain)),
                            ),

                            // cart item count
                            Row(
                              children: [
                                // minus button
                                Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.background,
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(15))),
                                  child: Center(
                                    child: Text('-'),
                                  ),
                                ),
                                // number
                                Container(
                                  width: 60,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.background),
                                  child: Center(
                                    child: Text(
                                        '${provider.cart[index].itemCount}'),
                                  ),
                                ),
                                // add button
                                Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.background,
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(15))),
                                  child: Center(
                                    child: Text('+'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ]),
                ))),
      ),
    );
  }
}
