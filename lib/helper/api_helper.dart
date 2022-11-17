import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:food_app_2/helper/api_constant.dart';
import 'package:food_app_2/model/GetProductDetails.dart';
import 'package:food_app_2/model/userModel_forDb.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

enum Method { POST, GET, PUT, PATCH, DELETE }

class APIHelper {
  // static String host_url = "http://192.168.65.206:3000";
  static String hostUrl =
      // "http://universal-ledger.ac4cbcefc3d74b409497.eastus.aksapp.io";
      "https://com-kb-shoppingapp.herokuapp.com";

  // static String host_url = "http://192.168.137.1:3000";

  getAllProducts(
      {String url = "", String limit = "N", String sort = "asc"}) async {
    url = "$hostUrl/products?limit=${limit}&sort=$sort";
    var body = {};
    return await makeReq(url, body, method: Method.GET);
  }

  createUserDetails({
    String url = "",
    var body,
  }) async {
    url = "$hostUrl/users";
    return await makeReq(url, body, method: Method.POST);
  }

  addProduct(String userID,String productId,int quantity) async {
    String url = "";
    var body = {
      "userId":userID,
      "products":[{
        "productId":productId,
        "quantity": quantity
      }]
    };
    try {
      url = "${hostUrl+addCart}";
      var data = await makeReq(url, body, method: Method.POST);
      if (data != null) {
        return  data;
      }
    } on ApiFailure catch (e) {
      return e.message;
    }
    return "";
  }

  getCartProduct({
    String url = "",
    var body,
    String user="",
  }) async {
    url = "${hostUrl+getCarts+user}";
    return await makeReq(url, body, method: Method.POST);
  }
  makeReq(String URL, dynamic body,
      {Method method = Method.POST, String token = ""}) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final https = new IOClient(
        ioc); /*try { final result = await InternetAddress.lookup('example.com'); if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) { print('connected'); } } on SocketException catch (_) { print('not connected'); throw ApiFailure(404, "network error"); }*/
    Uri url = Uri.parse(URL);
    Response response;
    var headers = {
      'Content-Type': 'application/json',
    };
    if (token.isNotEmpty) {
      headers['Authorization'] = "Bearer $token";
    }
    try {
      print(
          "API : ${method.toString()} url : $url \nrequest : ${body.toString()} ");
      switch (method) {
        case Method.POST:
          response = await https.post(url,
              headers: headers,
              body: jsonEncode(body),
              encoding: Encoding.getByName("utf-8"));
          break;
        case Method.GET:
          if (body != null &&
              body is Map &&
              body.isNotEmpty &&
              body is Map<String, dynamic>) {
            String queryString = Uri(queryParameters: body).query;
            url = Uri.parse(URL + "?" + queryString);
          }
          response = await https.get(url, headers: headers);
          break;
        case Method.PUT:
          response = await https.put(url,
              headers: headers,
              body: jsonEncode(body),
              encoding: Encoding.getByName("utf-8"));
          break;
        case Method.PATCH:
          response = await https.patch(url,
              headers: headers,
              body: jsonEncode(body),
              encoding: Encoding.getByName("utf-8"));
          break;
        case Method.DELETE:
          response = await https.delete(url,
              headers: headers,
              body: jsonEncode(body),
              encoding: Encoding.getByName("utf-8"));
          break;
        default:
          response = await https.post(url,
              headers: headers,
              body: jsonEncode(body),
              encoding: Encoding.getByName("utf-8"));
      }
    } catch (e) {
      print(e.toString());
      throw ApiFailure(400, e.toString());
    }
    if (response != null) {
      if (response.body != null) {
        print("Response: ${jsonDecode(response.body).toString()}");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        var message = "";
        var body = jsonDecode(response.body) as LinkedHashMap?;
        if (body != null && body.containsKey("errors")) {
          message = (body["errors"] as List)[0]["message"];
        }
        throw ApiFailure(response.statusCode, message);
      } else {
        throw ApiFailure(response.statusCode, "");
      }
    } else {
      throw ApiFailure(404, "");
    }
  }
}

class ApiFailure implements Exception {
  String message = "";
  int code = 400;

  ApiFailure(this.code, this.message);
}
