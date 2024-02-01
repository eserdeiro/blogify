import 'package:blogify/config/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.page);
    currentIndex = widget.page;

   if(!kIsWeb){
     pageController.addListener(() {
      if (pageController.page != null && (pageController.page! % 1 == 0)) {
        setState(() {
          currentIndex = pageController.page!.round();
          context.go('/home/$currentIndex');
        });
      }
    });
   }
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
      setState(() {
        currentIndex = widget.page;
      });
      pageController.animateToPage(
        widget.page,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }
    if (kIsWeb) {
      return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: viewRoutes,
        ),
        key: scaffoldKey,
        //drawer: SideMenu(scaffoldKey: scaffoldKey),
      );
    } else {
      return Scaffold(
        body: PageView(
          controller: pageController,
          children: viewRoutes,
        ),
        bottomNavigationBar:
            CustomBottomNavigationBar(currentIndex: currentIndex),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
