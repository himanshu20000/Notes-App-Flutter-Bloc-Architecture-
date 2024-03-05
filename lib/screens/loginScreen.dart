import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFD6E2EA),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.03),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Container(
                        height: size.height * 0.4,
                        width: size.height * 0.4,
                        child: RiveAnimation.asset("assets/login-teddy.riv",
                            fit: BoxFit.fitHeight,
                            stateMachines: ["Login Machine"],
                            onInit: (artboard) {
                          controller = StateMachineController.fromArtboard(
                              artboard, "Login Machine");
                          if (controller == null) return;
                          artboard.addController(controller!);
                          isChecking = controller?.findInput("isChecking");
                          numLook = controller?.findInput("numLook");
                          isHandsUp = controller?.findInput("isHandsUp");
                          trigSuccess = controller?.findInput("trigSuccess");
                          trigFail = controller?.findInput("trigFail");
                        })),
                    Center(
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: size.height * 0.05,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.height * 0.02),
                  ),
                  padding: EdgeInsets.all(size.height * 0.02),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.circular(size.height * 0.01),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.01,
                            vertical: size.height * 0.01),
                        child: TextField(
                          focusNode: emailFocusNode,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Email"),
                          style: Theme.of(context).textTheme.bodyMedium,
                          onChanged: (value) {
                            numLook?.change(value.length.toDouble());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.height * 0.02),
                  ),
                  padding: EdgeInsets.all(size.height * 0.02),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: size.height * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.circular(size.height * 0.01),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.01,
                            vertical: size.height * 0.01),
                        child: TextField(
                          obscureText: true,
                          focusNode: passwordFocusNode,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Password"),
                          style: Theme.of(context).textTheme.bodyMedium,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  height: size.height * 0.06,
                  width: size.height * 0.18,
                  child: ElevatedButton(
                    onPressed: () {
                      emailFocusNode.unfocus();
                      passwordFocusNode.unfocus();
                      if (emailController.text.contains("@gmail.com") &
                          passwordController.text.contains("51")) {
                        trigSuccess?.change(true);
                      } else {
                        trigFail?.change(true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.height * 0.025),
                        )),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.022),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
