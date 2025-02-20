import 'package:demo/models/login_request_model.dart';
import 'package:demo/services/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'homescreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Loginscreen> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF2E7D32),
        body: ProgressHUD(
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: _loginUI(context),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Login to your account",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 40),

            FormHelper.inputFieldWidget(
              context,
              "username",
              "Username",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
              (onSavedVal) {
                username = onSavedVal;
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white70,
              borderRadius: 15,
            ),
            const SizedBox(height: 15),

            // INPUT FIELD PASSWORD
            FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              (onSavedVal) {
                password = onSavedVal;
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white70,
              borderRadius: 15,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TOMBOL LOGIN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // OR SEPARATOR
            const Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 15),

            // LINK SIGN UP
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, fontSize: 14.0),
                children: <TextSpan>[
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Sign Up");
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      isAPIcallProcess = true; // Aktifkan loading
    });

    LoginRequestModel model = LoginRequestModel(
      username: "emilys", // Dummy user
      password: "emilyspass",
    );

    try {
      bool success = await ApiService.login(model);

      setState(() {
        isAPIcallProcess = false; // Matikan loading setelah respons diterima
      });

      if (success) {
        print("Login berhasil, navigasi ke home...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
      } else {
        showSnackBar("Invalid Username/Password!");
      }
    } catch (e) {
      setState(() {
        isAPIcallProcess = false;
      });
      showSnackBar("Error: ${e.toString()}");
      print("Error saat login: $e");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
