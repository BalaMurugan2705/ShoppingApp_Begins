import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_2/cubit/product_cubit.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/helper/app_localizations.dart';
import 'package:food_app_2/helper/firebase_helper.dart';
import 'package:food_app_2/helper/nav_helper.dart';
import 'package:food_app_2/helper/secure_storage_helper.dart';
import 'package:food_app_2/model/GetProductDetails.dart';
import 'package:food_app_2/widget/container_button.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';
import 'package:food_app_2/widget/listViewBuilder_Widget.dart';
import 'package:food_app_2/widget/shimmer_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper().getToken();
    SecureStorage.getUserData();
    context.read<ProductCubit>().getAllProducts(context);
    return Scafold(
      child: SingleChildScrollView(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, productState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                offerContainer(context),
                newProductsTitle(context),
                (productState.process.name == "LOADING" ||
                        productState.process.name == "ERROR")
                    ? productListShimmer()
                    : newProductList(productState.getProductList),
                SizedBox(
                  height: 70,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  offerContainer(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/offers.png"),
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              AppLocalizations.of(context)?.translate("fashionSale") ?? "",
              style: FdStyle.sofiaBold(
                color: AppColor.appWhite1,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10, left: 10, right: 160, bottom: 20),
            child: ContainerButton(
              buttonTitle:
                  AppLocalizations.of(context)?.translate("check") ?? "",
              buttonSize: 40,
              onTap: () {
                openScreen(dashBoard);
              },
            ),
          ),
        ],
      ),
    );
  }

  newProductsTitle(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.translate("new") ?? "",
                style: FdStyle.metropolisBold(
                    fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Text(
                  AppLocalizations.of(context)?.translate("viewAll") ?? "",
                  style: FdStyle.metropolisRegular(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            AppLocalizations.of(context)?.translate("alreadySeen") ?? "",
            style: FdStyle.metropolisRegular(
                fontSize: 16, color: AppColor.textGrey),
          ),
        ),
      ],
    );
  }

  newProductList(list) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListViewBuilderWidget(
        productList: list.product,
      ),
    );
  }

  productListShimmer() {
    return ShimmerWidget();
  }
}
