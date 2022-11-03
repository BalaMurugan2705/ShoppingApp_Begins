import 'package:flutter/material.dart';
import 'package:food_app_2/helper/app_color.dart';
import '../packages_class/shimmer_package.dart';

class ShimmerWidget extends StatelessWidget {
  ShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
        baseColor: AppColor.textGrey,
        highlightColor: AppColor.appWhite1,
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 3,
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
                                    color: AppColor.textGrey,
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      color: AppColor.textGrey,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                  width: 50,
                                  height: 5,
                                  color: AppColor.textGrey,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Container(
                                height: 5,
                                width: 20,
                                color: AppColor.textGrey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              color: AppColor.textGrey,
                              height: 5,
                              width: 150,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            height: 5,
                            width: 150,
                            color: AppColor.textGrey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            height: 5,
                            width: 150,
                            color: AppColor.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
