import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_s_test/auth/custtom_http.dart';
import 'package:smart_s_test/constant/constant.dart';
import 'package:http/http.dart ' as http;

class BlogStore extends StatefulWidget {
  const BlogStore({super.key});

  @override
  State<BlogStore> createState() => _BlogStoreState();
}

class _BlogStoreState extends State<BlogStore> {
  GlobalKey<ScaffoldState> _fromKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController sub_titleController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController descreptionController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  blogPass() async {
    var link = '${baseUrl}/admin/blog-news/store';

    var map = Map<String, dynamic>();
    map['title'] = titleController.text.toString();
    map['subtitle'] = sub_titleController.text.toString();
    map['slug'] = slugController.text.toString();
    map['description'] = descreptionController.text.toString();
    map['category_id'] = idController.toString();
    map['date'] = dateController.text.toString();
    var response = await http.post(Uri.parse(link),
        body: map, headers: CusttomHttp.getHeadersWithToken());
    if (response.statusCode == 200) {
      return showToast("Blog stored");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(30),
        height: 500,
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Pass blog store",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      labelText: "please enter title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: sub_titleController,
                  decoration: InputDecoration(
                      hintText: "Subtitle",
                      labelText: "please enter subtitle",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: slugController,
                  decoration: InputDecoration(
                      hintText: "Slug",
                      labelText: "Slug",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: descreptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "description",
                      labelText: "Write the description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "category_id",
                      labelText: "enter the id",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      hintText: "date",
                      labelText: "date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 30,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
