import 'dart:convert';

import 'package:http/http.dart';

import '../classes/user.dart';
import '../consts.dart';

class API {
  static Future<dynamic> login(String email, String password) async {
    // نستخدم تراي من اجل التأكد ان حدوث خطأ لا يؤدي الى توقف التطبيق
    try {
      Response response = await post(
        Uri.parse(url + "/login.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      // 200 تعني انا الاتصال كان ناجحا
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // في حال كان الكود = -1 يكون هناك خطأ بالتسجيل
        if (jsonResponse["code"] == "-1") {
          return jsonResponse["message"];
        } else {
          return User.fromJson(jsonResponse);
        }
      } else {
        return serverError;
      }
    } catch (e) {
      print(e);
      return connectionError;
    }
  }

  static Future<dynamic> logup(
      String email, String password, String fullName, String phone) async {
    // نستخدم تراي من اجل التأكد ان حدوث خطأ لا يؤدي الى توقف التطبيق
    try {
      Response response = await post(
        Uri.parse(url + "/register.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          "name": fullName,
          "phone": phone
        }),
      );
      // 200 تعني انا الاتصال كان ناجحا
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // في حال كان الكود = -1 يكون هناك خطأ بالتسجيل
        if (jsonResponse["code"] == "-1") {
          return jsonResponse["message"];
        } else {
          return User.fromJson(jsonResponse);
        }
      } else {
        return serverError;
      }
    } catch (e) {
      return connectionError;
    }
  }

  static Future<String> notificationNumber(String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/getNumofUnapprovedMeals.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_id': userID.toString()}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        print(jsonMap["num"]);
        if (jsonMap.isNotEmpty) {
          return jsonMap["num"];
        }
      }
      return "0";
    } catch (_) {
      return "0";
    }
  }

  static Future<String> forgotPassword(String email) async {
    try {
      Response response = await post(
        Uri.parse(url + "/reset_password.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email.toString()}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        if (jsonMap.isNotEmpty) {
          return jsonMap["message"];
        }
      }
      return "0";
    } catch (_) {
      return "0";
    }
  }

  static Future<void> add_serving(
      String userID, String serving, String num, String url) async {
    try {
      Response response = await post(
        Uri.parse(url + "/add_child_meal.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID.toString(),
          "serving": serving,
          "num": num,
          "URL": url
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {}
    } catch (_) {}
  }

  static Future<List<Map<String, dynamic>>?> servings(
      String userID, String day, String month, String year) async {
    try {
      Response response = await post(
        Uri.parse(url + "/servings.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID.toString(),
          "day": day,
          "month": month,
          "year": year,
        }),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonList = jsonDecode(response.body);
        return jsonList;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> discover(String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/discover.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID.toString(),
        }),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonList = jsonDecode(response.body);
        return jsonList;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> discoverItem(
      String userID, String id) async {
    try {
      Response response = await post(
        Uri.parse(url + "/discover_item.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID.toString(),
          'id': id.toString(),
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> unapproverServings(
      String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/getUnapprovedMeals.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_id': userID.toString()}),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonList = jsonDecode(response.body);
        if (jsonList[0]["code"] != "2") {
          return jsonList;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
