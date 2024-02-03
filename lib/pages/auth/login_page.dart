import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_media/colors/app_color.dart';
import 'package:social_media/layout.dart';
import 'package:social_media/pages/auth/regitser_page.dart';
import 'package:social_media/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  singIn() async {
    try {
      String res = await AuthMethods()
          .signIn(email: emailCon.text, password: passwordCon.text);
      if (res == "success") {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
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
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 18),
              ),
              Gap(20),
              TextField(
                keyboardType: TextInputType.emailAddress,
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
                        singIn();
                      },
                      child: Text(
                        'login'.toUpperCase(),
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
                  Text("Don't have an account? "),
                  GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                          (route) => false),
                      child: Text(
                        "Register now",
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
