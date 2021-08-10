import 'package:flutter/material.dart';
abstract class ThemeText {
  static const TextStyle kHeading = TextStyle(
      fontFamily: 'ArimaMadurai-Bold',
      color: Color(0xffFFBD69),
      fontSize: 24,
      fontWeight: FontWeight.w600);
  static const primaryColor = Color(0xffFFBD69);
  static const backgroundColor = Color(0xff241D2B);
  static const containerColor =  Color(0xff141416);
  static const buttonColor =  Color(0xffFF9A67);
  static const priceColor = Color(0xffE75A5A);
  static const TextStyle kSubHeading = TextStyle(
      fontFamily: 'OpenSans-Regular',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600);

  // static const TextStyle kSubHeading = TextStyle(
  //     fontFamily: 'Raleway-Italic',
  //     color: Colors.white,
  //     fontSize: 16,
  //     fontWeight: FontWeight.w600);

  static const TextStyle kNormalText = TextStyle(
      fontFamily: 'Raleway-Italic',
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600);

  static const TextStyle kBigHeading = TextStyle(
      fontFamily: 'ArimaMadurai-Bold',
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.w600);
}