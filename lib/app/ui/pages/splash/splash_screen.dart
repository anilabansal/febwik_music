import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    splashInit();
    super.initState();
  }

  Future<void> splashInit() async {
    await Future.delayed(const Duration(seconds: 3),);
    await Get.offAll(const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height ,
        child: Image.asset("assets/images/splash_updated.jpg",fit: BoxFit.fill,),
      ),
    );
  }
}
