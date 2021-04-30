import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelashy/Model/profileModel.dart';
import 'package:travelashy/NetworkHandler.dart';
import 'package:travelashy/Pages/HomePage.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final networkHandler = NetworkHandler();
  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _about = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  NetworkHandler networkHandler1 = NetworkHandler();
  ProfileModel profileModel = ProfileModel();

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler1.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
    _name.text = profileModel.name;
    _city.text = profileModel.city;
    _country.text = profileModel.country;
    _dob.text = profileModel.DOB;
    _title.text = profileModel.titleline;
    _phoneNum.text = profileModel.phoneNum;
    _about.text = profileModel.about;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.yanoneKaffeesatz(
            fontSize: 25,
            height: 1.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.brown[900],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            // imageProfile(),
            SizedBox(height: 20),
            nameTextField(),
            SizedBox(height: 20),
            cityTextField(),
            SizedBox(height: 20),
            countryTextField(),
            SizedBox(height: 20),
            dobField(),
            SizedBox(height: 20),
            phoneNumTextField(),
            SizedBox(height: 20),
            titleTextField(),
            SizedBox(height: 20),
            aboutTextField(),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                setState(() {
                  circular = true;
                });
                if (_globalkey.currentState.validate()) {
                  Map<String, String> data = {
                    "name": _name.text,
                    "city": _city.text,
                    "country": _country.text,
                    "phoneNum": _phoneNum.text,
                    "DOB": _dob.text,
                    "titleline": _title.text,
                    "about": _about.text,
                  };
                  // var response =
                  await networkHandler.patch("/profile/update", data);
                  SnackBar snackbar =
                      SnackBar(content: Text("Profile Edited!"));
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                  setState(() {
                    circular = false;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                  // if (response.statusCode == 200 ||
                  //     response.statusCode == 201) {
                  // if (_imageFile.path != null) {
                  //   var imageResponse = await networkHandler.patchImage(
                  //       "/profile/add/image", _imageFile.path);
                  //   if (imageResponse.statusCode == 200) {
                  //     setState(() {
                  //       circular = false;
                  //     });
                  //     Navigator.of(context).pushAndRemoveUntil(
                  //         MaterialPageRoute(builder: (context) => HomePage()),
                  //         (route) => false);
                  //   }
                  // }
                  //    else {
                  //     setState(() {
                  //       circular = false;
                  //     });
                  //     Navigator.of(context).pushAndRemoveUntil(
                  //         MaterialPageRoute(builder: (context) => HomePage()),
                  //         (route) => false);
                  //   }
                  // }
                }
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? ColoredCircularProgressIndicator()
                        : Text(
                            "Submit",
                            style: GoogleFonts.yanoneKaffeesatz(
                              fontSize: 25,
                              height: 1.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? new NetworkHandler().getImage(profileModel.username)
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 25.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: GoogleFonts.yanoneKaffeesatz(
              fontSize: 25,
              height: 1.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.camera,
                color: Colors.brown[900],
              ),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.image,
                color: Colors.brown[900],
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.brown[900],
        ),
        labelText: "Name",
        helperText: "Name can't be empty",
        hintText: "Lewiz",
      ),
    );
  }

  Widget cityTextField() {
    return TextFormField(
      controller: _city,
      validator: (value) {
        if (value.isEmpty) return "City can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.home,
          color: Colors.brown[900],
        ),
        labelText: "City",
        helperText: "City can't be empty",
        hintText: "Some where in the World",
      ),
    );
  }

  Widget countryTextField() {
    return TextFormField(
      controller: _country,
      validator: (value) {
        if (value.isEmpty) return "Country can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.brown[900],
        ),
        labelText: "Country",
        helperText: "Country can't be empty",
        hintText: "Lost in the Wild",
      ),
    );
  }

  Widget phoneNumTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _phoneNum,
      validator: (value) {
        if (value.isEmpty) return "Phone-Number can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.brown[900],
        ),
        labelText: "Phone-Number",
        helperText: "Phone-Number can't be empty",
        hintText: "+0 000 000 00 00",
      ),
    );
  }

  Widget dobField() {
    return TextFormField(
      controller: _dob,
      validator: (value) {
        if (value.isEmpty) return "DOB can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Colors.brown[900],
        ),
        labelText: "Date Of Birth",
        helperText: "Provide DOB on dd/mm/yyyy",
        hintText: "01/01/2020",
      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        if (value.isEmpty) return "Title can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.brown[900],
        ),
        labelText: "Title",
        helperText: "It can't be empty",
        hintText: "A Tourist",
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _about,
      validator: (value) {
        if (value.isEmpty) return "About can't be empty";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "About",
        helperText: "Write about yourself",
        hintText: "I love..",
      ),
    );
  }
}
