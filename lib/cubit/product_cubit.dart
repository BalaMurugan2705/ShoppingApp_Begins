import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/model/CartModel.dart';

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
        state.getProductList=GetProductList.fromJson(res);
        emit(state.copyWith(
            getProductList: state.getProductList,
            process: ProductProcess.DONE));
      } catch (e) {
        emit(state.copyWith(process: ProductProcess.ERROR));
        await DialogueHelper.showErrorDialog(context, e.toString(), false);
      }
    }
  }
  addToCart(GetProductDetails product){
    state.getProductList?.product?.forEach((element) {
      if(product == element){
        int? index=state.getProductList?.product?.indexOf(element);
        state.getProductList?.product?.remove(element);
        product.count=(product.count??0) + 1;
        state.getProductList?.product?.insert(index!, product);
      }
    });
    updateCartList();
    emit(state.copyWith(getProductList: state.getProductList));
  }
  removeFromCart(GetProductDetails product){
    state.getProductList?.product?.forEach((element) {
      if (product.count! >= 0){
        if (product == element) {
          int? index = state.getProductList?.product?.indexOf(element);
          state.getProductList?.product?.remove(element);
          product.count = (product.count ?? 0) - 1;
          state.getProductList?.product?.insert(index!, product);
        }

      }
    });
    updateCartList();
    emit(state.copyWith(getProductList: state.getProductList));
  }
  updateCartList(){
    List<GetProductDetails> list=[];
    state.getProductList?.product?.forEach((element) {
      if(element.count!=0){
      list.add(element);}
    });
    emit(state.copyWith(cartList: list));
  }
}

enum ProductProcess { NONE, LOADING, ERROR, DONE }

class ProductState {
  GetProductList? getProductList = GetProductList();
  ProductProcess process;
  List<GetProductDetails>? cartList = [];
  ProductState({this.getProductList, this.process = ProductProcess.NONE,this.cartList});
  ProductState copyWith(
      {GetProductList? getProductList, ProductProcess? process,List<GetProductDetails>? cartList}) {
    return ProductState(
        getProductList: getProductList ?? this.getProductList,
        process: process ?? this.process,
    cartList: cartList??this.cartList);
  }
}
