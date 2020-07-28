import 'package:a_im/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: BACKGROUND_CONTAINER_COLOR,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.pink,
          size: 50,
        ),
      ),
    );
  }
}
