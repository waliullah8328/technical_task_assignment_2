import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../app_color.dart';






class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitWaveSpinner(
        color: AppColors.kPrimaryColor
    );
  }
}