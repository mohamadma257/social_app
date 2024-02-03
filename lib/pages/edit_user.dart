import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_media/colors/app_color.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/providers/user_provider.dart';
import 'package:social_media/services/cloud.dart';
import 'package:social_media/utils/picker.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  Uint8List? file;
  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).userModel!;
    TextEditingController displayCon = TextEditingController();
    TextEditingController usernameCon = TextEditingController();
    TextEditingController bioCon = TextEditingController();
    displayCon.text = userData.displayName;
    usernameCon.text = userData.username;
    bioCon.text = userData.bio;

    update() async {
      try {
        String res = await CloudMethods().editProfile(
            uid: userData.uid,
            displayName: displayCon.text,
            username: usernameCon.text,
            bio: bioCon.text,
            file: file);
        if (res == 'success') {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        // TODO
      }
      Provider.of<UserProvider>(context, listen: false).getDetails();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Gap(20),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    file == null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                AssetImage('assets/images/man.png'),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(file!),
                          ),
                    Positioned(
                        bottom: -10,
                        right: -10,
                        child: IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: kSeconderyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () async {
                            Uint8List _file = await pickImage();
                            setState(() {
                              file = _file;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: kWhiteColor,
                          ),
                        )),
                  ],
                ),
              ),
              Gap(20),
              TextField(
                controller: displayCon,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  labelText: "Display Name",
                  labelStyle: TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Gap(20),
              TextField(
                controller: usernameCon,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  labelText: "Username",
                  labelStyle: TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Gap(20),
              TextField(
                controller: bioCon,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.info),
                  labelText: "Bio",
                  labelStyle: TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kSeconderyColor,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        update();
                      },
                      child: Text(
                        'update'.toUpperCase(),
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
