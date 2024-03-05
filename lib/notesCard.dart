import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({Key? key, required this.title, required this.desc});
  final String title;
  final String desc;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String dateT = DateTime.now().toString();
    return Card(
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.height * 0.02),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Container(
          height: size.height * 0.2, // Adjust the height as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size.height * 0.023,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    desc,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.002),
              Text(
                dateT.substring(0,10),
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: size.height * 0.015,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
