import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Image Gallery",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Container(
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 3,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            final imageUrl = imageList[index]['url']!;

            return isLoading
                ? const Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () {
                      _showImageDetails(context, imageUrl);
                    },
                    child: Container(
                      //  margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.3),
                        //     spreadRadius: 2,
                        //     blurRadius: 5,
                        //     offset: const Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Stack(
                          children: [
                            Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(1, index.isEven ? 1.2 : 1.8),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
      ),
    );
  }

  void _showImageDetails(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Builder(
          builder: (BuildContext context) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: animation.value,
                  child: Opacity(
                    opacity: animation.value,
                    child: _buildDetailsDialog(context, imageUrl),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDetailsDialog(BuildContext context, String imageUrl) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.36,
                width: double.infinity,
                // height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.black.withOpacity(0.07),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Title:",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 124, 124),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Image from Picsum Photos",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 124, 124),
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Author:",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 124, 124),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Jaydeep Sarvaiya",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 124, 124),
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Description:",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 124, 124),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text",
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 124, 124),
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> imageList = List.generate(500, (index) {
  int width = 200 + Random().nextInt(500);
  int height = 200 + Random().nextInt(500);
  String imageUrl = "https://picsum.photos/$width/$height";
  return {'url': imageUrl};
});
