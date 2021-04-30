import 'package:google_fonts/google_fonts.dart';

import '../Model/addBlogModels.dart';
import 'package:flutter/material.dart';
import '../NetworkHandler.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.teal[50],
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Row(
              children: [
                Container(
                  height: 299,
                  width: 225,
                  padding: EdgeInsets.only(top: 10, bottom: 70, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: networkHandler.getImage(addBlogModel.id),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 30, bottom: 30, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            width: 70,
                            child: Text(
                              addBlogModel.username,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.yanoneKaffeesatz(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          child: Container(
                            width: 70,
                            child: Text(
                              addBlogModel.title,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.yanoneKaffeesatz(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          child: Container(
                            width: 70,
                            child: Text(
                              addBlogModel.body,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.yanoneKaffeesatz(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
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
      ),
    );
    // return Container(
    //   height: 280,
    //   padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
    //   width: MediaQuery.of(context).size.width,
    //   child: Card(
    //     child: Stack(
    //       children: <Widget>[
    // Container(
    //   height: MediaQuery.of(context).size.height,
    //   width: MediaQuery.of(context).size.width,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: networkHandler.getImage(addBlogModel.id),
    //         fit: BoxFit.fill),
    //   ),
    // ),
    //         Positioned(
    //           bottom: 2,
    //           child: Container(
    //             padding: EdgeInsets.all(7),
    //             height: 60,
    //             width: MediaQuery.of(context).size.width - 30,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(8)),
    //             child: Text(
    //               addBlogModel.title,
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 15,
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
