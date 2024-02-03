import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_media/colors/app_color.dart';
import 'package:social_media/layout.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController displayCon = TextEditingController();
  TextEditingController usernameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  register() async {
    try {
      String res = await AuthMethods().signUp(
          email: emailCon.text,
          password: passwordCon.text,
          username: usernameCon.text,
          display: displayCon.text);
      if (res == "sucssess") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LayoutPage(),
            ),
            (route) => false);
      } else {
        print(res);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svg/n_logo.svg',
                  height: 150,
                  width: 150,
                  //  color: kPrimaryColor,
                  colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                ),
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "06",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "16",
                    style: TextStyle(
                        fontSize: 26,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(20),
              TextField(
                controller: displayCon,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  hintText: "Display Name",
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
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  hintText: "Username",
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
                controller: emailCon,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
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
                controller: passwordCon,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: kWhiteColor,
                  filled: true,
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
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
                        register();
                      },
                      child: Text(
                        'Register'.toUpperCase(),
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => false),
                      child: Text(
                        "login now",
                        style: TextStyle(color: kPrimaryColor),
                      ))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
