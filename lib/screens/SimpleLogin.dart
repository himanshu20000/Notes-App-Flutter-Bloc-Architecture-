import 'package:flutter/material.dart';

class SimpleLogin extends StatelessWidget {
  const SimpleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome back",
            style: TextStyle(
                fontSize: size.height * 0.05,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter the email",
                labelText: "Email"
              ),

            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter the password",
                  labelText: "Password"
              ),
            )
          ],
        ),
      ),
    );
  }
}
