import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/helper/dialog_helper.dart';

import '../helper/nav_helper.dart';
import '../model/GetProductDetails.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(super.initialState);
  getAllProducts(context) async {
    state.process = ProductProcess.NONE;
    if (state.process == ProductProcess.NONE) {
      emit(state.copyWith(process: ProductProcess.LOADING));
      try {
        var res = await APIHelper().getAllProducts();
        emit(state.copyWith(
            getProductList: GetProductList.fromJson(res),
            process: ProductProcess.DONE));
      } catch (e) {
        emit(state.copyWith(process: ProductProcess.ERROR));
        await DialogueHelper.showErrorDialog(context, e.toString(), false);
      }
    }
  }
}

enum ProductProcess { NONE, LOADING, ERROR, DONE }

class ProductState {
  GetProductList? getProductList = GetProductList();
  ProductProcess process;
  ProductState({this.getProductList, this.process = ProductProcess.NONE});
  ProductState copyWith(
      {GetProductList? getProductList, ProductProcess? process}) {
    return ProductState(
        getProductList: getProductList ?? this.getProductList,
        process: process ?? this.process);
  }
}
