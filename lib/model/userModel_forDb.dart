class UserModelDB {
  Address? address;
  String? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? iV;

  UserModelDB(
      {this.address,
      this.id,
      this.email,
      this.username,
      this.password,
      this.name,
      this.phone,
      this.iV});

  UserModelDB.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new Address.fromJson(json['address'])
        : Address();
    id = json['id'] ?? "";
    email = json['email'] ?? "";
    username = json['username'] ?? "";
    password = json['password'] ?? "";
    name = json['name'] != null ? new Name.fromJson(json['name']) : Name();
    phone = json['phone'] ?? "";
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.name != null) {
      data['name'] = this.name?.toJson();
    }
    data['phone'] = this.phone;
    data['__v'] = this.iV;
    return data;
  }
}

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? doorNumber;
  String? zipcode;

  Address(
      {this.geolocation,
      this.city,
      this.street,
      this.doorNumber,
      this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    geolocation = json['geolocation'] != null
        ? new Geolocation.fromJson(json['geolocation'])
        : Geolocation();
    city = json['city'] ?? "";
    street = json['street'] ?? "";
    doorNumber = json['door number'] ?? 0;
    zipcode = json['zipcode'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geolocation != null) {
      data['geolocation'] = this.geolocation?.toJson();
    }
    data['city'] = this.city;
    data['street'] = this.street;
    data['door number'] = this.doorNumber;
    data['zipcode'] = this.zipcode;
    return data;
  }
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({this.lat, this.long});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] ?? "";
    long = json['long'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class Name {
  String? firstname;
  String? lastname;

  Name({this.firstname, this.lastname});

  Name.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'] ?? "";
    lastname = json['lastname'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
