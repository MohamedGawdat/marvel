import 'package:flutter/material.dart';
import 'package:itg_test/data/models/person/person_gallery.dart';
import 'package:itg_test/style/app_text_style.dart';
import 'package:itg_test/utilities/images_handler/image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itg_test/widgets/sized_boxes.dart';

class PersonGallery extends StatelessWidget {
  final title;
  List<ResultsCharacterGallery> gallery;
  PersonGallery({Key? key, required this.title, required this.gallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gallery.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxConst.sizedBoxH10,
              Text(
                '  ' + title,
                textAlign: TextAlign.start,
                style: redTextBold,
              ),
              SizedBoxConst.sizedBoxH10,
              SizedBox(
                width: 0.95.sw,
                height: 0.4.sw,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: gallery[index].comics!.images!.isNotEmpty
                        ? ImageView(
                            url: gallery[index].comics!.images![0].path! +
                                '.' +
                                gallery[index].comics!.images![0].extension!,
                            width: 0.25.sw,
                            height: 0.4.sw,
                            downloadableImg: true,
                          )
                        : SizedBox(),
                  ),
                  itemCount: gallery.length,
                ),
              ),
              SizedBoxConst.sizedBoxH10,
              SizedBoxConst.sizedBoxH10,
            ],
          )
        : SizedBox();
  }
}
