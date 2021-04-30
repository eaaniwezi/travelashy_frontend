import 'package:google_fonts/google_fonts.dart';
import 'package:travelashy/Profile/CreateProfile.dart';
import 'package:travelashy/Profile/MyProfile.dart';

import '../Blog/addBlog.dart';
import '../Pages/WelcomePage.dart';
import '../Screen/HomeScreen.dart';
import '../Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../NetworkHandler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  List<String> titleString = ["Travelashy", "Profile Page"];
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 40,
          backgroundImage: NetworkHandler().getImage(response['username']),
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  _drawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  toolbarHeight: 100,
                  title: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '#work hard!',
                            style: GoogleFonts.yanoneKaffeesatz(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '#Travel harder!!!!',
                          style: GoogleFonts.yanoneKaffeesatz(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.teal,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 40, top: 25),
                  child: Container(
                    width: 90,
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.brown[600],
                          Colors.brown[700],
                          Colors.brown[800],
                          Colors.brown[900],
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                    child: profilePhoto,
                    // child: CircleAvatar(
                    //   radius: 40,
                    //   backgroundImage: AssetImage('images/image/profile.png'),
                    // ),
                  ),
                ),
                SizedBox(height: 9.0),
                Text(
                  username,
                  style: GoogleFonts.yanoneKaffeesatz(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 9.0),
                // Text(
                //   "emmanuel@gmail.com",
                //   style: GoogleFonts.yanoneKaffeesatz(
                //     fontSize: 18.0,
                //     color: Colors.black,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.brown[900],
                  ),
                  title: Text(
                    'Home',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.person_pin,
                    color: Colors.brown[900],
                  ),
                  title: Text(
                    'My Profile',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.brown[300],
                  ),
                  title: Text(
                    'Settings',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.brown[300],
                  ),
                  title: Text(
                    'Report a bug',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.brown[300],
                  ),
                  title: Text(
                    'Help',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.brown[900],
                  ),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: logout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.brown[800],
        title: Text(
          titleString[currentState],
          style: GoogleFonts.yanoneKaffeesatz(
            fontSize: 29,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddBlog()));
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 40),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.brown[800],
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed: () {
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 40,
                )
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
