// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smart_s_test/auth/custtom_http.dart';

class BlogDelte extends StatelessWidget {
  TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              CusttomHttp.delete(idController);
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
    ;
  }
}
