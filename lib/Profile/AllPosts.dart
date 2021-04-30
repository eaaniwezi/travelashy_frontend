import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelashy/Blog/Blogs.dart';

class AllPosts extends StatefulWidget {
  AllPosts({Key key}) : super(key: key);

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.brown[800],
        title: Text(
          "Your Posts",
          style: GoogleFonts.yanoneKaffeesatz(
            fontSize: 29,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Blogs(
            url: "/posts/getOwnBlog",
          ),
        ),
      ),
    );
  }
}
