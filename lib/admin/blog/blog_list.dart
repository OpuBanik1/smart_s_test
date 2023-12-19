import 'package:flutter/material.dart';
import 'package:smart_s_test/auth/custtom_http.dart';
import 'package:smart_s_test/admin/blog/blog_delete.dart';
import 'package:smart_s_test/admin/blog/blog_store.dart';
import 'package:smart_s_test/admin/blog/blog_update.dart';
import 'package:smart_s_test/constant/constant.dart';
import 'package:smart_s_test/model/blog_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  late BlogModel blogModel;
  List<BlogModel> blogList = [];

  addblogStore() {
    return showBottomSheet(context: context, builder: (context) => BlogStore());
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int currentIndex = 1;
  List<int> pageNo = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Blogs"),
        centerTitle: true,
      ),
      body: Container(
        height: 600,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 90, vertical: 5),
                    margin: EdgeInsets.fromLTRB(100, 5, 80, 5),
                    padding: EdgeInsets.all(5),
                    height: 50,
                    width: double.infinity,
                    color: Color(0xff03045E),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: pageNo.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(12),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                    // print("pppppppppp$currentIndex");
                                  });
                                },
                                child: Text('${pageNo[index]}')),
                          );
                        }),
                  ),
                  Positioned(
                    top: 8,
                    left: -10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      color: Colors.blueAccent,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentIndex--;
                            });
                          },
                          child: Text(
                            'Previous',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: -10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.blueAccent,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentIndex++;
                            });
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
              FutureBuilder<List<BlogModel>>(
                  future: CusttomHttp.fetchBlogList(currentIndex),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.hasError.toString());
                    }
                    return Container(
                      height: 400,
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(snapshot.data![index].title
                                            .toString()),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            "Id:${snapshot.data![index].id.toString()}")
                                      ],
                                    ),
                                    Text(
                                        "Description: ${snapshot.data![index].description}")
                                  ]),
                            );
                          }),
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlogUpdate()));
                        },
                        icon: Icon(Icons.update_rounded)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlogDelte()));
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BlogStore()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
