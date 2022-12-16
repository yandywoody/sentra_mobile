import 'dart:ffi';

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color bgMenu = Color(0xFFF0F4F7);
  static const Color primaryColor = Color(0xFF03071C);
  static const Color succesColor = Color(0xFF198754);
  static const Color bgColorDark = Color(0xFF0275D8);
  static const Color bgColorLight = Color(0xFFFFFFFF);
  static const Color themeColor = Color(0xFF0084f3);
  static const Color infoColor = Color(0xFF0D6EFD);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color dangerColor = Color.fromARGB(255, 255, 0, 0);

  static const TextStyle lightText7 = TextStyle(
    color: Colors.white,
    fontSize: 7.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle text8 = TextStyle(
    color: Colors.black,
    fontSize: 8.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle lightText6 = TextStyle(
    color: Colors.white,
    fontSize: 6.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle lightText10 = TextStyle(
    color: Colors.white,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle text10 = TextStyle(
    color: Colors.black,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle text10opc50 = TextStyle(
    color: Colors.black54,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle lightSubText10 = TextStyle(
    color: Colors.white,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle lightText14 = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle yellowText14 = TextStyle(
    color: warningColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle text14 = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle text14opc20 = TextStyle(
    color: Colors.black38,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle lightText16 = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  //=====================================================================

  static const TextStyle bigTitle = TextStyle(
    color: Colors.black,
    fontSize: 29.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bigTitleLight = TextStyle(
    color: Colors.white,
    fontSize: 29.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bigSubTitle = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bigSubTitleLight = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle title = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleGrey = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle titleLight = TextStyle(
    color: Colors.white,
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle subTitle = TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subTitleLight = TextStyle(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [
      Color(0xFF0084f3),
      Color.fromARGB(255, 92, 170, 234),
    ],
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient bgGradientBlue = LinearGradient(
    colors: [
      Color.fromARGB(255, 54, 193, 201),
      Color.fromARGB(255, 6, 75, 81),
    ],
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
  );
}
