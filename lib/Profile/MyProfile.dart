import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelashy/Blog/Blogs.dart';
import 'package:travelashy/Model/profileModel.dart';
import 'package:travelashy/NetworkHandler.dart';
import 'package:travelashy/Pages/HomePage.dart';
import 'package:travelashy/Profile/AllPosts.dart';
import 'package:travelashy/Profile/CreateProfile.dart';
import 'package:travelashy/Profile/EditProfile.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: circular
          ? Center(
              child: ColoredCircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkHandler()
                              .getImage(profileModel.username),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    profileModel.username,
                                    style: GoogleFonts.yanoneKaffeesatz(
                                      fontSize: 27,
                                      height: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                      profileModel.name,
                                      style: GoogleFonts.yanoneKaffeesatz(
                                        fontSize: 23,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      profileModel.titleline,
                                      style: GoogleFonts.yanoneKaffeesatz(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "285",
                                              style:
                                                  GoogleFonts.yanoneKaffeesatz(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "Likes",
                                              style:
                                                  GoogleFonts.yanoneKaffeesatz(
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "650",
                                              style:
                                                  GoogleFonts.yanoneKaffeesatz(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "Posts",
                                              style:
                                                  GoogleFonts.yanoneKaffeesatz(
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkHandler()
                                      .getImage(profileModel.username),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              margin: EdgeInsets.only(left: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false);
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.brown[900],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Go Back",
                                      style: GoogleFonts.yanoneKaffeesatz(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()))
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: GoogleFonts.yanoneKaffeesatz(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllPosts()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.brown[900],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "View Posts",
                                      style: GoogleFonts.yanoneKaffeesatz(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("Your information"),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Phone"),
                                subtitle: Text(profileModel.phoneNum),
                                leading:
                                    Icon(Icons.phone, color: Colors.brown[900]),
                              ),
                              ListTile(
                                title: Text("Date of Birth"),
                                subtitle: Text("0/00/0000"),
                                leading:
                                    Icon(Icons.web, color: Colors.brown[900]),
                              ),
                              ListTile(
                                title: Text("City"),
                                subtitle: Text(profileModel.city),
                                leading:
                                    Icon(Icons.home, color: Colors.brown[900]),
                              ),
                              ListTile(
                                title: Text("Country"),
                                subtitle: Text(profileModel.country),
                                leading: Icon(Icons.location_city,
                                    color: Colors.brown[900]),
                              ),
                              ListTile(
                                title: Text("About"),
                                subtitle: Text(profileModel.about),
                                leading: Icon(Icons.help_outline,
                                    color: Colors.brown[900]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
