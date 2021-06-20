import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itg_test/data/providers/home_screen_provider.dart';
import 'package:itg_test/data/providers/search_provider.dart';
import 'package:itg_test/ui/home/components/single_person_card.dart';
import 'package:itg_test/ui/search_page/search_page.dart';
import 'package:itg_test/utilities/navigation.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Provider.of<HomeScreenProvider>(context, listen: false)
        .getPopularCharactersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'marvel',
          child: Image.asset(
            'assets/images/Marvel_Logo.png',
            width: 0.2.sw,
            // height: 0.2.sw,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.red,
            ),
            onPressed: () {
              NavigateUtil.navigate(
                  context,
                  ChangeNotifierProvider(
                      create: (context) => SearchProvider(),
                      builder: (context, child) => SearchPage()));
            },
          )
        ],
      ),
      body: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) => SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                // shrinkWrap: true,
                itemCount: provider.charactersResult.length,
                itemBuilder: (BuildContext context, int index) =>
                    SinglePersonCard(
                        heroData: provider.charactersResult[index]))),
      ),
    );
  }

  void _onRefresh() async {
    await Provider.of<HomeScreenProvider>(context, listen: false)
        .resetPeopleList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Provider.of<HomeScreenProvider>(context, listen: false)
        .fetchNextPage();
    _refreshController.loadComplete();
  }
}
