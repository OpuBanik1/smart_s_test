import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart ' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_s_test/constant/constant.dart';
import 'package:smart_s_test/model/blog_model.dart';

class CusttomHttp {
  //Future<Map<String,String>>getHeadersWithToken(){}
  static getHeadersWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
    };

    return header;
  }

  static Future<List<BlogModel>> fetchBlogList(int pageNo) async {
    BlogModel blogModel;
    List<BlogModel> blogList = [];
    String link = '$baseUrl/admin/blog-news?page=$pageNo';
    var response = await http.get(Uri.parse(link),
        headers: await CusttomHttp.getHeadersWithToken());

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['data']['blogs']['data']);
        for (var i in data['data']['blogs']['data']) {
          blogModel = BlogModel.fromJson(i);
          blogList.add(blogModel);
        }
        return blogList;
      } else {
        throw ('Something wrong');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  static update(var id) async {
    var head = Map<String, String>();
    head = CusttomHttp.getHeadersWithToken();
    String url = '$baseUrl/admin/blog-news/update/${id}';
    var response = await http.post(Uri.parse(url), headers: head);
    try {
      if (response.statusCode == 200) {
        return showToast("Updated");
      } else {
        throw Text("not found");
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  static delete(var id) async {
    String url = '$baseUrl/admin/blog-news/delete/${id}';
    var response = await http.post(Uri.parse(url),
        headers: CusttomHttp.getHeadersWithToken());
    if (response.statusCode == 200) {
      return showToast("delated");
    }
  }

  // static blogPass(String link, Map<String, dynamic> map)async {
  //      await http.post(Uri.parse(link),
  //       headers: CusttomHttp.getHeadersWithToken(), body: map);
  // }
}
