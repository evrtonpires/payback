import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';
import 'package:payback/app/src/modules/home/views/point/point_page.dart';
import 'package:payback/app/src/modules/home/views/prescribe/prescribe_page.dart';
import 'package:payback/app/src/modules/home/views/remedy/remedy_page.dart';

import '../../../modules/util/constants/icons_constants.dart';
import '../../util/colors/colors.dart';
import '../stores/home_store.dart';
import 'widgets/tab_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.prescribeStore}) : super(key: key);

  final PrescribeStore prescribeStore;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ModularState<HomePage, HomeStore>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    widget.prescribeStore.getAllDrugs(context: context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .01),
              child: SvgPicture.asset(
                IconConstant.logoWide,
                color: ColorsConstants.white,
                height: MediaQuery.of(context).size.height * .05,
              ),
            ),
            backgroundColor: ColorsConstants.primary,
            centerTitle: true,
            bottom: TabBar(
              onTap: (page) {
                if (page == 0) {
                  _pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.bounceInOut);
                }
                if (page == 1) {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.bounceInOut);
                }
                if (page == 2) {
                  _pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.bounceInOut);
                }
              },
              controller: _tabController,
              tabs: [
                TabWidget(
                    iconPath: IconConstant.iconDoc,
                    titlePath: 'telaHome.receitas'),
                TabWidget(
                    iconPath: IconConstant.iconDroug,
                    titlePath: 'telaHome.remedios'),
                TabWidget(
                    iconPath: IconConstant.iconDash,
                    titlePath: 'telaHome.pontos'),
              ],
              indicatorColor: ColorsConstants.laranjaSGS,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PrescribePage(prescribeStore: widget.prescribeStore),
              const RemedyPage(),
              const PointPage(),
            ],
          ),
        ),
      ),
    );
  }
}
