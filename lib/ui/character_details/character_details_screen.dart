import 'package:flutter/material.dart';
import 'package:itg_test/data/models/person/people_model.dart';
import 'package:itg_test/data/providers/person_details_provider.dart';
import 'package:itg_test/style/app_colors.dart';
import 'package:itg_test/style/app_text_style.dart';
import 'package:itg_test/utilities/images_handler/image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itg_test/utilities/navigation.dart';
import 'package:itg_test/widgets/sized_boxes.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/person_gallery.dart';

class PersonDetailsScreen extends StatefulWidget {
  final CharacterHero heroData;
  const PersonDetailsScreen({Key? key, required this.heroData})
      : super(key: key);

  @override
  _PersonDetailsScreenState createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PersonDetailsProvider>(context, listen: false)
        .fetchPersonImages(widget.heroData.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY,
      body: SizedBox(
        child: Consumer<PersonDetailsProvider>(
          builder: (context, value, child) => ListView(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.heroData.thumbnail!.path! +
                        '.' +
                        widget.heroData.thumbnail!.extension!,
                    child: ImageView(
                        url: widget.heroData.thumbnail!.path! +
                            '.' +
                            widget.heroData.thumbnail!.extension!,
                        width: 1.sw,
                        height: 0.8.sw),
                  ),
                  Positioned(
                      child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => NavigateUtil.pop(context),
                  ))
                ],
              ),
              SizedBoxConst.sizedBoxH10,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NAME',
                      textAlign: TextAlign.start,
                      style: redTextBold,
                    ),
                    SizedBoxConst.sizedBoxH10,
                    Text(
                      widget.heroData.name!,
                      textAlign: TextAlign.start,
                      style: whiteTextBold,
                    ),
                    SizedBoxConst.sizedBoxH10,
                    SizedBoxConst.sizedBoxH10,
                    Container(
                      child: widget.heroData.description!.length > 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DESCRIPTION',
                                  textAlign: TextAlign.start,
                                  style: redTextBold,
                                ),
                                SizedBoxConst.sizedBoxH10,
                                SizedBox(
                                  width: 0.9.sw,
                                  child: Text(
                                    widget.heroData.description!,
                                    textAlign: TextAlign.start,
                                    style: whiteTextBold,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ),
                    SizedBoxConst.sizedBoxH10,
                    SizedBoxConst.sizedBoxH10,
                  ],
                ),
              ),
              SizedBoxConst.sizedBoxH10,
              PersonGallery(
                title: 'Comics',
                gallery: value.personGallery.results!,
              ),
              PersonGallery(
                title: 'Series',
                gallery: value.personGallery.results!,
              ),
              PersonGallery(
                title: 'Stories',
                gallery: value.personGallery.results!,
              ),
              PersonGallery(
                title: 'Events',
                gallery: value.personGallery.results!,
              ),
              SizedBoxConst.sizedBoxH10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Related Links',
                  textAlign: TextAlign.start,
                  style: redTextBold,
                ),
              ),
              Column(
                  children: widget.heroData.urls!
                      .map((item) => ExpansionTile(
                            title: Text(
                              item.type!,
                              style: whiteTextBold,
                            ),
                            children: [
                              SizedBox(
                                height: 2.sh,
                                width: 1.sw,
                                child: WebView(
                                  initialUrl: item.url,
                                ),
                              )
                            ],
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                            ),
                          ))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
