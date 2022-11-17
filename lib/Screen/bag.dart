import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';
import '../custom_directory/custom_navigator_bar.dart';
import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/nav_helper.dart';
import '../widget/custom_scaffold.dart';

class Bag extends StatelessWidget {
  const Bag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scafold(child: Container(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return state.cartList!=null&&state.cartList?.length!=0?ListView.builder(
              itemCount: state.cartList?.length??0,
              itemBuilder: (context, index) {
                var productList=state.cartList?[index];
                return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: (){
                        openScreen(productDetail,args: LinkedHashMap.from(
                            {"product": productList!}));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                height: 150,
                                width: 150,
                                padding: EdgeInsets.all(10),
                                child: Image.network(
                                  productList!.image ?? "",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${productList.category}",
                                      style: FdStyle.metropolisRegular(
                                        color: AppColor.textGrey,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${productList.title}",
                                      style: FdStyle.metropolisRegular(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${productList.price}\$",
                                      style: FdStyle.metropolisRegular(
                                        color: AppColor.textGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  context.read<ProductCubit>().removeFromCart(productList);
                                }, icon: Icon(Icons.remove)),
                                Text(productList.count.toString()),
                                IconButton(onPressed: (){
                                  context.read<ProductCubit>().addToCart(productList);
                                }, icon: Icon(Icons.add))
                              ],
                            )
                          ],

                        ),
                      ),  )
                );
              }):Center(
            child: InkWell( onTap :(){
              pageController.value.jumpToPage(0);
              index.value=0;
            },child: Text("Cart is Empty, click to add product")),
          );
        },
      ),
    ));
  }
}
