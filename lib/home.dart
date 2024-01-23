import 'dart:math';

import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isLoading = true;
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  final List<Map<String, String>> imageList = List.generate(16, (index) {
    int width = 200 + Random().nextInt(16);
    int height = 200 + Random().nextInt(16);
    String imageUrl = "https://picsum.photos/$width/$height";
    // Add your own description logic
    return {'url': imageUrl, 'description': "$index"};
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Image Gallary"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/564x/0a/a8/bf/0aa8bfa73e2f93d3816b75bbd1b4a95a.jpg"),
                fit: BoxFit.fill)),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: null,
          itemBuilder: (context, index) {
            final itemIndex = index % imageList.length;
            final imageUrl = imageList[itemIndex]['url']!;
            final description = imageList[itemIndex]['description']!;
            return isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.all(20),
                                        padding: EdgeInsets.all(
                                            MediaQuery.sizeOf(context).width *
                                                0.03),
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                      blurRadius: 3,
                                                      color: Colors.black,
                                                      spreadRadius: 0.1)
                                                ],
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(imageUrl),
                                                    fit: BoxFit.fill),
                                                // Container background color
                                                borderRadius:
                                                    BorderRadius.circular(14.5),
                                              ),
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.5,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Title             : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "Image from picsum photos"),
                                              ],
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Author         : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text("Jaydeep Sarvaiya"),
                                              ],
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Description : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "Lorem Ipsum is simply dummy text "),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.sizeOf(context).width * 0.02,
                                horizontal:
                                    MediaQuery.sizeOf(context).width * 0.01),
                            child: GridTile(
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 3,
                                          color: Colors.black,
                                          spreadRadius: 0.1)
                                    ],
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.white,
                                        style: BorderStyle.solid),
                                    // Container background color
                                    borderRadius: BorderRadius.circular(
                                        14.5), // Border radius

                                    image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
