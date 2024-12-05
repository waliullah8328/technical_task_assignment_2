import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:technical_task_assignment_2/resource/app_string.dart';
import '../resource/app_color.dart';
import '../resource/app_image_string.dart';
import '../utils/routes/route_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen(); // Call the asynchronous function
  }

  /// Asynchronous function to handle navigation logic
  Future<void> _navigateToNextScreen() async {


    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RouteName.allTaskList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SvgPicture.asset(AppImageString.appLogo,height: 100,width: 220,color: Colors.white,),
              const SizedBox(height: 20,),
              const Text(AppStrings.taskListApp2,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
              Lottie.asset(
                AppImageString.loadingSvg,
                height: 100,
                width: 120,
              ),
              const SizedBox(height: 40),


            ],
          ),
        ),
      ),
    );
  }
}
