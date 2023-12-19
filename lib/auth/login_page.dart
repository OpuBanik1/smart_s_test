import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_s_test/admin/blog/blog_list.dart';
import 'package:smart_s_test/admin/blog/blog_store.dart';
import 'package:smart_s_test/constant/constant.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final _fromKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;
  login() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var link = '${baseUrl}/login';
      var map = Map<String, dynamic>();
      map['email'] = emailController.text.toString();
      map['password'] = passwordController.text.toString();

      var response = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(response.body);
      print('Access token is ${data["data"]["token"]}');
      setState(() {
        isLoading = false;
      });
      if (data["data"]["token"] != null) {
        sharedPreferences.setString('token', data["data"]["token"]);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BlogList()));
      } else {
        showToast('Email or Password is incorrect');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      child: Scaffold(
        body: Form(
            key: _fromKey,
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.pexels.com/photos/4386467/pexels-photo-4386467.jpeg?auto=compress&cs=tinysrgb&w=600'),
                      fit: BoxFit.cover)),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Center(
                        child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 25, color: Colors.lightBlueAccent),
                    )),
                  ),
                  SizedBox(
                    height: 175,
                  ),
                  Card(
                    elevation: 4,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.red)),
                          hintText: 'Email',
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(1)),
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(1))),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'please enter a valid email';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordVisible == false;
                                });
                              },
                              child: Icon(Icons.visibility)),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Colors.green),
                          ),
                          hintText: ' Password',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.length < 5) {
                          return 'Password atleast contains 5 character';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        login();
                      } else {
                        return showToast('Please give correct information');
                      }
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
