import 'dart:collection';

import 'baseModel.dart';

class AppUser extends BaseModel {
  String? name = "";
  String? lastname = "";
  String? email = "";
  String? password = "";
  String? city = "";
  String? street = "";
  String? doorNo;
  String? zipcode = "";
  String? phone = "";
  String? uid = "";
  String? dob = "";
  String? image = "";
  bool? isAdmin = false;

  AppUser(
      {this.name,
      this.lastname,
      this.email,
      this.password,
      this.city,
      this.street,
      this.doorNo,
      this.zipcode,
      this.phone,
      this.uid,
      this.dob,
      this.image,
      this.isAdmin});

  @override
  fromMap(LinkedHashMap<dynamic, dynamic> json, {String? uid}) {
    if (json.containsKey("Email")) {
      email = json["Email"] ?? "";
    }
    if (json.containsKey("Name")) {
      name = json["Name"] ?? "";
    }
    if (json.containsKey("LastName")) {
      lastname = json["LastName"] ?? "";
    }
    if (json.containsKey("Password")) {
      password = json["Password"] ?? "";
    }
    if (json.containsKey("City")) {
      city = json["City"] ?? "";
    }
    if (json.containsKey("Street")) {
      street = json["Street"] ?? "";
    }
    if (json.containsKey("Door No")) {
      doorNo = json["Door No"] ?? "";
    }
    if (json.containsKey("Zipcode")) {
      zipcode = json["Zipcode"] ?? "";
    }
    if (json.containsKey("uid")) {
      this.uid = json["uid"] ?? uid ?? "";
    }
    if (json.containsKey("Phone")) {
      phone = json["Phone"] ?? "";
    }
    if (json.containsKey("DOB")) {
      dob = json["DOB"] ?? "";
    }
    if (json.containsKey("image")) {
      image = json["image"] ?? "";
    }
    if (json.containsKey("isAdmin")) isAdmin = json["isAdmin"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        'Name': name ?? "",
        'LastName': lastname ?? "",
        'Email': email ?? "",
        'Password': password ?? "",
        'City': city ?? "",
        'Street': street ?? "",
        'Door No': doorNo ?? "",
        'Zipcode': zipcode ?? "",
        'DOB': dob ?? "",
        'phone': phone ?? "",
        'image': image ?? "",
        'isAdmin': isAdmin ?? false,
        'uid': uid ?? "",
      };
}
