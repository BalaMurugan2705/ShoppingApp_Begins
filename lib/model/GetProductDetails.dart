class GetProductList {
  List<GetProductDetails>? product = [];

  GetProductList({this.product});

  GetProductList.fromJson(Map<String, dynamic> json) {
    json["productList"].forEach((element) {
      product?.add(GetProductDetails.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["productList"] = product?.map((x) => x.toJson()).toList();
    return data;
  }
}

class GetProductDetails {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  int? count;

  GetProductDetails(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
        this.count=0,
      this.rating});

  GetProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = double.parse(json['price'].toString());
    description = json['description'];
    category = json['category'];
    image = json['image'];
    count = json['count']??0;
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    data['count'] = this.count;
    if (this.rating != null) {
      data['rating'] = this.rating?.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = double.parse(json['rate'].toString());
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
