import 'package:blogify/config/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int page;

  const HomeScreen({required this.page, super.key});
  static String name = Strings.homeScreenName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final viewRoutes = appMenuItems.map((menuItem) => menuItem.view).toList();

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.page,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }
    if (kIsWeb) {
      return Scaffold(
        body: IndexedStack(
          index: widget.page,
          children: viewRoutes,
        ),
      key: scaffoldKey,
      //drawer: SideMenu(scaffoldKey: scaffoldKey),

      );
    }
     //If is mobile
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: widget.page),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
