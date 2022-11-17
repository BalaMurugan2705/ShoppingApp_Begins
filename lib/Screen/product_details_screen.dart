
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app_2/model/GetProductDetails.dart';
import 'package:food_app_2/widget/container_button.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';

import '../cubit/product_cubit.dart';
import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/app_localizations.dart';
import '../helper/nav_helper.dart';

class ProductDetails extends StatelessWidget {
  GetProductDetails productList=GetProductDetails();
   ProductDetails(LinkedHashMap<dynamic, dynamic> args, {Key? key}) : super(key: key){
     if ( args is Map){
      if (args.containsKey("product")) {
        productList = args["product"];
      }
    }
  }
ValueNotifier<bool> read= ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scafold(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(

          ),
          detailHeader(context),
          Expanded(
              flex: 1,
              child: Center(child: imageProduct(context))),
          bottomContent(context),



        ],
      ),
    );
  }

  Expanded bottomContent(BuildContext context) {
    return Expanded(
            flex: 1,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight:  Radius.circular(40))
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: RatingBar.builder(
                              initialRating:
                              productList.rating?.rate ?? 0,
                              allowHalfRating: true,
                              itemSize: 25,
                              itemPadding: EdgeInsets.all(1),
                              ignoreGestures: true,
                              itemBuilder: (context, _) {
                                // return SvgPicture.asset(
                                //   "assets/images/star.svg",
                                // );
                                return Icon(
                                  Icons.star,
                                  color: AppColor.amber,

                                );
                              },
                              onRatingUpdate: (value) {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "(${productList.rating?.rate ?? 0})",
                            style: FdStyle.sofia(
                              color: AppColor.textGrey,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(productList.title??"",
                    style: FdStyle.metropolisRegular(
                      fontWeight: FontWeight.w800,
                      fontSize: 26
                    ),),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.01
                    ),
                    Text("\$ ${productList.price.toString()??""}",
                      style: FdStyle.metropolisRegular(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        color: Colors.amber
                      ),),
                    SizedBox(
                        height: MediaQuery.of(context).size.height*0.02
                    ),

                    ValueListenableBuilder(
                      builder: (context,data,child) {
                        return Flexible(
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: [
                                data==true? Text("${productList.description.toString()??""}",
                                   style: FdStyle.metropolisRegular(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: AppColor.textGrey
                                  ),):Text("${productList.description.toString()??""}",
                                  maxLines: 3,
                                  style: FdStyle.metropolisRegular(

                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,

                                      color: AppColor.textGrey
                                  ),),
                                 InkWell(
                                   onTap: (){
                                     read.value =!read.value;
                                   },
                                   child: Text(data==true?"Read less":"Read More",
                                    style: FdStyle.metropolisRegular(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.blue
                                    ),),
                                 )

                              ],
                            ),
                          ),
                        );
                      }, valueListenable: read,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: bottomButton(context),
                    )
                  ],
                ),
              ),
            ));
  }
  Widget detailHeader(context) {
     print(productList.image);
    return Padding(
      padding: const EdgeInsets.only(top: 40.0,bottom: 20,left: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              back(null);

            },
            child: Icon(Icons.arrow_back_ios,
            color: AppColor.appBlack1,),
          ),

        ],
      ),
    );
  }
  Widget imageProduct(context) {

    return Image.network(
      productList.image??'',
      fit: BoxFit.contain,
      width: MediaQuery.of(context).size.width*0.7,
      height: MediaQuery.of(context).size.width*0.7,
    );
  }
  Widget bottomButton(context) {

    return BlocBuilder<ProductCubit, ProductState>(
  builder: (context, state) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: productList.count==0?InkWell(
            onTap: (){
              context.read<ProductCubit>().addToCart(productList);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.appOrange1,
                  borderRadius: BorderRadius.all(Radius.circular(40))
              ),

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    "Add to Cart",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ):Row(
            children: [
              IconButton(onPressed: (){
                context.read<ProductCubit>().removeFromCart(productList);
              }, icon: Icon(Icons.remove)),
              Text(productList.count.toString()),
              IconButton(onPressed: (){
                context.read<ProductCubit>().addToCart(productList);
              }, icon: Icon(Icons.add))
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.05,
        ),

        Expanded(
          flex: 1,
          child: InkWell(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.appOrange1,
                  borderRadius: BorderRadius.all(Radius.circular(40))
              ),

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    "Buy Now",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  },
);
  }
}
