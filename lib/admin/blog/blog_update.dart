import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:smart_s_test/auth/custtom_http.dart';
import 'package:smart_s_test/constant/constant.dart';

class BlogUpdate extends StatelessWidget {
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(30),
              child: TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter the id",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  CusttomHttp.update(idController);
                },
                child: Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
