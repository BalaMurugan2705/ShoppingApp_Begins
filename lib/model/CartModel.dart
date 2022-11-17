class CartModel {
  Cart? cart;

  CartModel({this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart?.toJson();
    }
    return data;
  }
}

class Cart {
  String? sId;
  int? id;
  String? userId;
  String? date;
  List<Products>? products;
  int? iV;

  Cart({this.sId, this.id, this.userId, this.date, this.products, this.iV});

  Cart.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    id = json['id']??0;
    userId = json['userId']??"";
    date = json['date']??"";
    if (json['products'] != null) {
      products = <Products>[]??[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    iV = json['__v']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  String ?sId;
  String? productId;
  int? quantity;

  Products({this.sId, this.productId, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??"";
    productId = json['productId']??"";
    quantity = json['quantity']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
