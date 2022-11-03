import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/model/GetProductDetails.dart';

class ListViewBuilderWidget extends StatelessWidget {
  ListViewBuilderWidget({
    Key? key,
    this.productList,
  }) : super(key: key);
  List<GetProductDetails>? productList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: productList?.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 200,
                              width: 150,
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                productList![index].image ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColor.textGrey,
                            child: SvgPicture.asset(
                              "assets/images/favourite_inActive.svg",
                              height: 10,
                              width: 10,
                              color: AppColor.titleBlack,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: RatingBar.builder(
                              initialRating:
                                  productList![index].rating?.rate ?? 0,
                              allowHalfRating: true,
                              itemSize: 15,
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
                            "(${productList![index].rating?.rate ?? 0})",
                            style: FdStyle.sofia(
                              color: AppColor.textGrey,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "${productList![index].category}",
                        style: FdStyle.metropolisRegular(
                          color: AppColor.textGrey,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "${productList![index].title}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FdStyle.metropolisRegular(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "${productList![index].price}\$",
                        style: FdStyle.metropolisRegular(
                          color: AppColor.textGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
