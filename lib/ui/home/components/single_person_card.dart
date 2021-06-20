import 'package:flutter/material.dart';
import 'package:itg_test/data/models/person/people_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itg_test/data/providers/person_details_provider.dart';
import 'package:itg_test/style/app_text_style.dart';
import 'package:itg_test/ui/character_details/character_details_screen.dart';
import 'package:itg_test/utilities/images_handler/image_view.dart';
import 'dart:ui' as ui;

import 'package:itg_test/utilities/navigation.dart';
import 'package:provider/provider.dart';

class SinglePersonCard extends StatelessWidget {
  final CharacterHero heroData;

  const SinglePersonCard({Key? key, required this.heroData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigateUtil.navigate(
            context,
            ChangeNotifierProvider(
                create: (context) => PersonDetailsProvider(),
                builder: (context, child) =>
                    PersonDetailsScreen(heroData: heroData)));
      },
      child: Hero(
        tag: heroData.resourceURI! + 'hero',
        child: Stack(
          children: [
            Container(
              height: .35.sw,
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      -40.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: ImageView(
                url: heroData.thumbnail!.path! +
                    '.' +
                    heroData.thumbnail!.extension!,
                width: 1.sw,
                height: .35.sw,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 1.sw / 2,
              top: 1.sw / 4.5,
              left: 10,
              child: CustomPaint(
                painter: MyParallelogram(),
                child: Center(
                  child: SizedBox(
                    width: 0.3.sw,
                    child: FittedBox(
                      child: Text(
                        heroData.name!,
                        style: bigTextBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.25, size.height * 0.39),
        Offset(size.width * 0.46, size.height * 0.39),
        [Color(0xffffffff), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2900000, size.height * 0.3571429);
    path_0.lineTo(size.width * 0.4575000, size.height * 0.3571429);
    path_0.lineTo(size.width * 0.4158333, size.height * 0.4285714);
    path_0.lineTo(size.width * 0.2483333, size.height * 0.4271429);
    path_0.lineTo(size.width * 0.2900000, size.height * 0.3571429);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyParallelogram extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5;

    Path path_1 = Path();

    path_1.moveTo(size.width * 0.05, size.height * 0.13);
    path_1.lineTo(size.width * 0.95, size.height * 0.13);
    path_1.lineTo(size.width * 0.85, size.height * 0.87);
    path_1.lineTo(size.width * 0.05, size.height * 0.87);
    path_1.lineTo(size.width * 0.15, size.height * 0.13);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
