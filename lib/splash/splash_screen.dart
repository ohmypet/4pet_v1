library petisland.splash;

import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/state/state.dart';

class SplashScreen extends TStatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.white,
      child: Center(
        child: Image.asset(TAssets.splash),
      ),
    );
  }
}
