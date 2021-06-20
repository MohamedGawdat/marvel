import 'package:flutter/material.dart';
import 'package:itg_test/data/providers/search_provider.dart';
import 'package:itg_test/style/app_colors.dart';
import 'package:itg_test/style/app_text_style.dart';
import 'package:itg_test/utilities/images_handler/image_view.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY,
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: buildFloatingSearchBar(),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: 1.sw,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        print(query);
        Provider.of<SearchProvider>(context, listen: false)
            .searchedCharacterResults = [];
        Provider.of<SearchProvider>(context, listen: false)
            .getSearchedList(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.black12,
            elevation: 4.0,
            child: Consumer<SearchProvider>(
                builder: (context, provider, child) => SizedBox(
                      height: 0.5.sh,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: provider.searchedCharacterResults.length,
                          itemBuilder: (BuildContext context, int index) => Row(
                                children: [
                                  ImageView(
                                    url: provider
                                            .searchedCharacterResults[index]
                                            .thumbnail!
                                            .path! +
                                        '.' +
                                        provider.searchedCharacterResults[index]
                                            .thumbnail!.extension!,
                                    width: .27.sw,
                                    height: .27.sw,
                                  ),
                                  SizedBox(
                                    height: .27.sw,
                                    width: 1.sw - 0.34.sw,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            provider
                                                .searchedCharacterResults[index]
                                                .name!,
                                            style: bigTextBold.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                        // Spacer(),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 0.1,
                                          height: 2,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                    )),
          ),
        );
      },
    );
  }
}
