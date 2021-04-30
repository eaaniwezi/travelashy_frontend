import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../NetworkHandler.dart';
import '../Model/addBlogModels.dart';
import '../Model/SuperModel.dart';
import '../CustumWidget/BlogCard.dart';
import '../Blog/Blog.dart';

class Blogs extends StatefulWidget {
  Blogs({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (contex) => Blog(
                                  addBlogModel: item,
                                  networkHandler: networkHandler,
                                ),
                              ),
                            );
                          },
                          child: BlogCard(
                            addBlogModel: item,
                            networkHandler: networkHandler,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        child: Align(
                          child: new Text(
                            'Nothing Yet!!',
                            style: GoogleFonts.yanoneKaffeesatz(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0x008080),
                          image: new DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.7),
                                BlendMode.dstATop),
                            image: new AssetImage("images/image/homePage.jpg"),
                            fit: BoxFit.fitHeight,
                          ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:travelashy/Blog/Blog.dart';
// import 'package:travelashy/CustumWidget/BlogCard.dart';
// import 'package:travelashy/Model/SuperModel.dart';
// import 'package:travelashy/Model/addBlogModels.dart';
// import 'package:travelashy/NetworkHandler.dart';

// class Blogs extends StatefulWidget {
//   final String url;
//   Blogs({Key key, this.url}) : super(key: key);

//   @override
//   _BlogsState createState() => _BlogsState();
// }

// class _BlogsState extends State<Blogs> {
//   NetworkHandler networkHandler = NetworkHandler();
//   SuperModel superModel = SuperModel();
//   List<AddBlogModel> data = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     var response = await networkHandler.get(widget.url);
//     superModel = SuperModel.fromJson(response);
//     setState(() {
//       data = superModel.data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: data.map((item) => BlogCard())
//     )
//   }
// }
