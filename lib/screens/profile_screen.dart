import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  static String id = 'Profile';
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Text('Your profile is nice')
        ),
      ),
    );
  }
}
