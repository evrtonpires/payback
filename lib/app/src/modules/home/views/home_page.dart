import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../modules/home/home_routing.dart';
import '../../../modules/util/constants/icons_constants.dart';
import '../../util/colors/colors.dart';
import '../stores/home_store.dart';
import 'widgets/tab_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ModularState<HomePage, HomeStore>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Modular.to.navigate(HomeRouteNamed.remedy.fullPath!);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                  Modular.to.navigate(HomeRouteNamed.remedy.fullPath!);
                }
                if (page == 1) {
                  Modular.to.navigate(HomeRouteNamed.prescribe.fullPath!);
                }
                if (page == 2) {
                  Modular.to.navigate(HomeRouteNamed.point.fullPath!);
                }
              },
              controller: _tabController,
              tabs: [
                TabWidget(
                    iconPath: IconConstant.iconDroug,
                    titlePath: 'telaHome.remedios'),
                TabWidget(
                    iconPath: IconConstant.iconDoc,
                    titlePath: 'telaHome.receitas'),
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
          body: RouterOutlet(),

        ),
      ),
    );
  }
}
