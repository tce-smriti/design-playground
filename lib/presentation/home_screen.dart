import 'dart:io';

import 'package:art_flutter/components/quick_tips_card.dart';
import 'package:art_flutter/components/service_card.dart';
import 'package:art_flutter/components/special_offer_card.dart';
import 'package:art_flutter/locales/locale_keys.g.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:http/http.dart' as http;
import '../assets_type.dart';
import '../components/custom_button.dart';
import '../components/custom_header_view_home.dart';
import '../components/custom_paint_bar.dart';
import '../components/policy_card.dart';
import '../constants.dart';
import '../models/bottom_bar.dart';
import '../text_style.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  bool isOpened = false;
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  int selectBtn = 0;
  late String title;
  bool forArabic = false;
  final _myDuration = Duration(seconds: 1);
  double _myValue = 260.0;
  double _myNewValue = 460;
  late Box<Asset> dataBox;
  late String _dir;
  List<int> assets = [];
  List<Asset> _assetList = <Asset>[];

  List get assetList => _assetList;
  bool isLoading = true;

  @override
  void initState() {
    title = "Home";
    super.initState();
   /* dataBox = Hive.box<Asset>("assetFolder1");
    _assetList = dataBox.values.toList();
    _downloadAssets(_assetList, dataBox);*/
    //var data = dataBox.getAt(0);
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _endSideMenuKey,
      inverse: true,
      // end side menu
      background: kPrimaryColor,
      type: SideMenuType.shrinkNSlide,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: IgnorePointer(
        ignoring: isOpened,
        child: Scaffold(
          bottomNavigationBar: navigationBar(),
          body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomPaint(
                        painter: CurvePainter(),
                        child: AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: _myValue,
                            duration: _myDuration,
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/logo-horizontal.svg",
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        /*  setState(() async {
                                                    await context.setLocale(context.supportedLocales[0]);
                                                  });*/
                                                      },
                                                      child: SvgPicture.asset(
                                                        "assets/icons/notification.svg",
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        child: SvgPicture.asset(
                                                          "assets/icons/nav_icon.svg",
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          toggleMenu(true),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Text(
                                                    LocaleKeys.good_morning
                                                        .tr(),
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                kHeaderColor)),
                                                    textAlign: TextAlign.left)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Text(
                                                    "Smriti Ranjan Biswal",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            color: kHeaderColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    textAlign: TextAlign.left)),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                height: 30,
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: <Widget>[
                                                    HeaderButton(
                                                        title: LocaleKeys
                                                            .motor_renewal
                                                            .tr()),
                                                    HeaderButton(
                                                      title: LocaleKeys
                                                          .medical_renewal
                                                          .tr(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20,
                                                    left: 10,
                                                    right: 10),
                                                child: Row(
                                                  children: [
                                                    Text("Arabic",
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    kHomeHeaderColor)),
                                                        textAlign:
                                                            TextAlign.left),
                                                    Switch(
                                                      // thumb color (round icon)
                                                      activeColor: Colors.amber,
                                                      activeTrackColor:
                                                          Colors.cyan,
                                                      inactiveThumbColor: Colors
                                                          .blueGrey.shade600,
                                                      inactiveTrackColor:
                                                          Colors.grey.shade400,
                                                      splashRadius: 50.0,
                                                      // boolean variable value
                                                      value: forArabic,
                                                      // changes the state of the switch
                                                      onChanged: (value) {
                                                        setState(() async {
                                                          if (forArabic == true)
                                                            await context
                                                                .setLocale(context
                                                                    .supportedLocales[1]);
                                                          else
                                                            await context
                                                                .setLocale(context
                                                                    .supportedLocales[0]);
                                                          forArabic = value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ))),
                                Positioned(
                                  top: 190,
                                  right: 78,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _myValue = _myNewValue;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/arrow_down.svg",
                                    ),
                                  ),
                                ),
                                /* Positioned(
                            top: 340,
                            right: 78,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  _myValue = 260;
                                });
                              },
                              child: SvgPicture.asset(
                                "assets/icons/arrow_down.svg",
                              ),
                            ),
                          )*/
                              ],
                            )),
                      ),
                      CustomHeaderView(title: LocaleKeys.my_policies.tr()),
                      Container(
                        height: 170.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.add),
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(20)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  // <-- Button color
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Colors.red; // <-- Splash color
                                  }),
                                ),
                              ),
                            ),
                            PolicyCard(
                              cardHeight: 20,
                              assetPath: 'assets/icons/motor_policy.svg',
                              onPressed: () {},
                              imageType: 1,
                              subTitle: '',
                              isRenewal: false,
                              title: LocaleKeys.Medical.tr(),
                            ),
                            PolicyCard(
                              cardHeight: 20,
                              assetPath: 'assets/icons/motor_policy_1.svg',
                              onPressed: () {},
                              imageType: 1,
                              subTitle: '',
                              isRenewal: true,
                              title: LocaleKeys.Motor.tr(),
                            ),
                          ],
                        ),
                      ),
                      DotsIndicator(
                        dotsCount: 2,
                        position: 0,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      CustomHeaderView(title: LocaleKeys.services.tr()),
                      Container(
                        child: Row(
                          children: [
                            ServicesCard(
                              cardHeight: 20,
                              assetPath: 'assets/icons/road_assistance.svg',
                              onPressed: () {},
                              imageType: 1,
                              subTitle: LocaleKeys.assistance.tr(),
                              cardType: 1,
                              title: LocaleKeys.Road_Side.tr(),
                              titleColor: Color(0xFFF5A800),
                            ),
                            Column(
                              children: [
                                ServicesCard(
                                    cardHeight: 20,
                                    assetPath:
                                        'assets/icons/health_services.svg',
                                    onPressed: () {},
                                    imageType: 1,
                                    subTitle: LocaleKeys.services.tr(),
                                    cardType: 2,
                                    title: LocaleKeys.Health.tr(),
                                    titleColor: Color(0xFF2ED8AA)),
                                ServicesCard(
                                    cardHeight: 20,
                                    assetPath:
                                        'assets/icons/claim_services.svg',
                                    onPressed: () {},
                                    imageType: 1,
                                    subTitle: LocaleKeys.services.tr(),
                                    cardType: 2,
                                    title: LocaleKeys.Claim.tr(),
                                    titleColor: Color(0xFF39A9ED)),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomHeaderView(title: LocaleKeys.special_offers.tr()),
                      Container(
                        height: 170.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SpecialOfferCard(),
                            SpecialOfferCard(),
                          ],
                        ),
                      ),
                      CustomHeaderView(title: LocaleKeys.quick_tips.tr()),
                      Column(
                        children: [
                          QuickTipsCard(
                            cardHeight: 20,
                            assetPath: 'assets/icons/quick_tips_health.svg',
                            onPressed: () {},
                            imageType: 1,
                            subTitle: '',
                            isRenewal: false,
                            title: LocaleKeys.healthy_tips.tr(),
                          ),
                          QuickTipsCard(
                            cardHeight: 20,
                            assetPath: 'assets/icons/quick_tips_2.svg',
                            onPressed: () {},
                            imageType: 1,
                            subTitle: '',
                            isRenewal: false,
                            title: LocaleKeys.ride_safe.tr(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Hello, John Doe",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
            title: const Text("Home"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.verified_user,
                size: 20.0, color: Colors.white),
            title: const Text("Profile"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.monetization_on,
                size: 20.0, color: Colors.white),
            title: const Text("Wallet"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.shopping_cart,
                size: 20.0, color: Colors.white),
            title: const Text("Cart"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.star_border, size: 20.0, color: Colors.white),
            title: const Text("Favorites"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.settings, size: 20.0, color: Colors.white),
            title: const Text("Settings"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0000000D),
            blurRadius: 25.0,
            spreadRadius: 25,
            offset: Offset(
              -20,
              -20,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight:
              Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 60.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              navBtn[i].imagePath,
              width: 15,
              height: 15,
              color: isActive ? kPrimaryColor : kBottomBarSelected,
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(navBtn[i].name,
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 12, color: kBottomBarSelected)),
                  textAlign: TextAlign.left)),
        ],
      ),
    );
  }

  SizedBox customAppBar(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 400.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
                height: height,
                width: width,
                duration: const Duration(milliseconds: 600),
                child: CustomPaint(
                  painter: TopNotch(),
                )),
          ),
        ],
      ),
    );
  }

  void showLanguages(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() async {
                        await context.setLocale(context.supportedLocales[1]);
                      });
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("English",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: kHomeHeaderColor)),
                            textAlign: TextAlign.left)),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("Arabic",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kHomeHeaderColor)),
                          textAlign: TextAlign.left)),
                ],
              ),
            ),
          );
        });
  }

  File _getLocalImageFile(String name, String dir) => File('$dir/$name');

  Future<void> _downloadAssets(List<Asset> assets, Box<Asset> dataBox) async {
    isLoading = true;
    try {
   /*   if (_dir == null) {
        _dir = (await getApplicationDocumentsDirectory()).path;
      }*/
      for (int i = 0; i < assets.length; i++) {
        Directory documentDirectory =  await getApplicationDocumentsDirectory();
        File file = await _downloadFile(
            '${assets.elementAt(i).httpUrl}', '${assets.elementAt(i).filename}', documentDirectory.path);
        assets.elementAt(i).localUrl = file.path;
      }
      print(assets);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }

    /* if (!await _hasToDownloadAssets(name, _dir)) {
      return;
    }*/
  }
}

/*  Future<bool> _hasToDownloadAssets(String name, String dir) async {
    var file = File('$dir/$name.zip');
    return !(await file.exists());
  }*/

Future<File> _downloadFile(String url, String filename, String dir) async {
  var req = await http.Client().get(Uri.parse(url));
  var file = File('$dir/$filename');
  return file.writeAsBytes(req.bodyBytes);
}
