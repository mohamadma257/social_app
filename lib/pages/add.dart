import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_media/colors/app_color.dart';
import 'package:social_media/models/user.dart';
import 'package:social_media/providers/user_provider.dart';
import 'package:social_media/services/cloud.dart';
import 'package:social_media/utils/picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Uint8List? file;

  TextEditingController desCon = TextEditingController();
  uploadPost(
      String uid, String displayName, String username, String pic) async {
    try {
      String res = await CloudMethods().uploadPost(
          description: desCon.text,
          uid: uid,
          displayName: displayName,
          profilePic: pic,
          file: file!,
          username: username);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Text("Add Post"),
          actions: [
            TextButton(
              onPressed: () {
                uploadPost(userModel.uid, userModel.displayName,
                    userModel.username, userModel.profilePic);
              },
              child: Text("Post"),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/man.png'),
                  ),
                  Gap(20),
                  Expanded(
                      child: TextField(
                    controller: desCon,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Type here ..."),
                  ))
                ],
              ),
              Expanded(
                child: file == null
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: MemoryImage(file!), fit: BoxFit.fill)),
                      ),
              ),
              Gap(40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: kSeconderyColor,
                    padding: EdgeInsets.all(
                      20,
                    )),
                onPressed: () async {
                  Uint8List? _file = await pickImage();
                  setState(() {
                    file = _file;
                  });
                  //  print(myFile);
                  //  pickImage();
                },
                child: Icon(Icons.camera, color: kWhiteColor),
              ),
              Gap(80),
            ],
          ),
        ));
  }
}
