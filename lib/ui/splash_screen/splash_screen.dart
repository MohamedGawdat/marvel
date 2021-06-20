import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:itg_test/data/providers/home_screen_provider.dart';
import 'package:itg_test/style/app_colors.dart';
import 'package:itg_test/ui/home/home_screen.dart';
import 'package:itg_test/widgets/sized_boxes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(vsync: this);

    sequenceAnimation = new SequenceAnimationBuilder()
        .addAnimatable(
            animatable: new Tween(begin: 0.0, end: -120.0),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 3000),
            curve: Curves.easeInOut,
            tag: "translate")
        .addAnimatable(
            animatable: new Tween(begin: 0.0, end: 1.0),
            from: const Duration(milliseconds: 1500),
            to: const Duration(milliseconds: 2500),
            curve: Curves.easeInOut,
            tag: "opacity")
        .animate(controller);

    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (context) => HomeScreenProvider(),
                    builder: (context, child) => HomeScreen(
                          title: 'Flutter ITG Task',
                        ))),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 1.sw,
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        0, sequenceAnimation['translate'].value as double),
                    child: Image.asset(
                      'assets/images/ironMan.png',
                      width: 0.5.sw,
                    ),
                  );
                },
              ),
              Column(
                children: [
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Hero(
                        tag: 'marvel',
                        child: Opacity(
                          opacity: sequenceAnimation['opacity'].value as double,
                          child: Image.asset(
                            'assets/images/Marvel_Logo.png',
                            width: 0.6.sw,
                            height: 0.1.sh,
                            // color: AppColors.Sec_Color,
                            // color: Colors.white,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBoxConst.sizedBoxH10
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
