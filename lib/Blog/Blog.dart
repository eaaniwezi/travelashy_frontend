import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../NetworkHandler.dart';
import '../Model/addBlogModels.dart';

class Blog extends StatelessWidget {
  const Blog({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);
  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .62,
            width: MediaQuery.of(context).size.width,
            foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                image: networkHandler.getImage(addBlogModel.id),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 370),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    addBlogModel.username,
                    style: GoogleFonts.yanoneKaffeesatz(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title:",
                                style: GoogleFonts.yanoneKaffeesatz(
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                addBlogModel.title,
                                style: GoogleFonts.yanoneKaffeesatz(
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Body:",
                                  style: GoogleFonts.yanoneKaffeesatz(
                                    fontSize: 20,
                                    height: 1.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SingleChildScrollView(
                                  child: Container(
                                    height: 170,
                                    width: 250,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        addBlogModel.body,
                                        style: GoogleFonts.yanoneKaffeesatz(
                                          fontSize: 20,
                                          height: 1.5,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ],
      ),
      // body: ListView(
      //   children: [
      //     Container(
      //       height: 365,
      //       width: MediaQuery.of(context).size.width,
      //       child: Card(
      //         elevation: 8,
      //         child: Column(
      //           children: [
      //             Container(
      //               height: 230,
      //               width: MediaQuery.of(context).size.width,
      //               decoration: BoxDecoration(
      //                 image: DecorationImage(
      //                   image: networkHandler.getImage(addBlogModel.id),
      //                   fit: BoxFit.fill,
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 20, vertical: 10),
      //               child: Text(
      //                 addBlogModel.title,
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 20, vertical: 10),
      //               child: Row(
      //                 children: [
      //                   Icon(
      //                     Icons.chat_bubble,
      //                     size: 18,
      //                   ),
      //                   SizedBox(
      //                     width: 5,
      //                   ),
      //                   Text(
      //                     addBlogModel.comment.toString(),
      //                     style: TextStyle(fontSize: 15),
      //                   ),
      //                   SizedBox(
      //                     width: 15,
      //                   ),
      //                   Icon(
      //                     Icons.thumb_up,
      //                     size: 18,
      //                   ),
      //                   SizedBox(
      //                     width: 8,
      //                   ),
      //                   Text(
      //                     addBlogModel.count.toString(),
      //                     style: TextStyle(fontSize: 15),
      //                   ),
      //                   SizedBox(
      //                     width: 15,
      //                   ),
      //                   Icon(
      //                     Icons.share,
      //                     size: 18,
      //                   ),
      //                   SizedBox(
      //                     width: 8,
      //                   ),
      //                   Text(
      //                     addBlogModel.share.toString(),
      //                     style: TextStyle(fontSize: 15),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Container(
      //       width: MediaQuery.of(context).size.width,
      //       child: Card(
      //         elevation: 15,
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(
      //             horizontal: 10,
      //             vertical: 15,
      //           ),
      //           child: Text(addBlogModel.body),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
