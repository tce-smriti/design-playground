import 'dart:io';
import 'package:art_components/components/custom_header_view_home.dart';
import 'package:art_components/components/custom_paint_bar.dart';
import 'package:art_components/components/header_medical_policy_card.dart';
import 'package:art_components/components/header_policy_card.dart';
import 'package:art_components/components/policy_card.dart';
import 'package:art_components/components/quick_tips_card.dart';
import 'package:art_components/components/service_card.dart';
import 'package:art_components/components/special_offer_card.dart';
import 'package:art_flutter/locales/locale_keys.g.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:http/http.dart' as http;
import '../assets_type.dart';
import '../constants.dart';
import '../models/bottom_bar.dart';
import '../text_style.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool isOpened = false;
  int selectBtn = 0;
  double indicatorPosition = 0;
  late String title;
  bool forArabic = false;
  bool isOpen = false;
  late Box<Asset> dataBox;
  late String _dir;
  List<int> assets = [];
  List<Asset> _assetList = <Asset>[];

  List get assetList => _assetList;
  bool isLoading = true;
  late double _scrollPosition;

  @override
  void initState() {
    _scrollController = ScrollController();
    title = "Home";
    super.initState();
    /* dataBox = Hive.box<Asset>("assetFolder1");
    _assetList = dataBox.values.toList();
    _downloadAssets(_assetList, dataBox);*/
    //var data = dataBox.getAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZoomDrawer(
      menuScreen: DrawerScreen(
        setIndex: (index) {},
      ),
      mainScreen: Scaffold(
        bottomNavigationBar: navigationBar(),
        body: SingleChildScrollView(
          physics: isOpen
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          child: Stack(
            key: UniqueKey(),
            children: [
              Container(
                color: Colors.red,
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                    ),
                    CustomHeaderView(title: LocaleKeys.my_policies.tr()),
                    Container(
                      height: 170.0,
                      child: NotificationListener(
                        child: ListView(
                          controller: _scrollController,
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
                              assetPath: 'assets/icons/motor_policy.svg',
                              onPressed: () {},
                              imageType: 1,
                              subTitle: '',
                              isRenewal: false,
                              title: LocaleKeys.Medical.tr(),
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
                          ],
                        ),
                        onNotification: (t) {
                          if (t is ScrollEndNotification) {
                            print(_scrollController.position.pixels);
                          }
                          if (_scrollController.position.pixels > 400) {
                            setState(() {
                              indicatorPosition = 1;
                            });
                            //  indicatorPosition = 1;
                          } else {
                            /* setState(() {
                              indicatorPosition = 0;
                            });*/
                          }
                          //How many pixels scrolled from pervious frame
                          print(t);

                          //List scroll position
                          // print(t.metrics.pixels);
                          return false;
                        },
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: 2,
                      position: indicatorPosition,
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
                                  assetPath: 'assets/icons/health_services.svg',
                                  onPressed: () {},
                                  imageType: 1,
                                  subTitle: LocaleKeys.services.tr(),
                                  cardType: 2,
                                  title: LocaleKeys.Health.tr(),
                                  titleColor: Color(0xFF2ED8AA)),
                              ServicesCard(
                                  cardHeight: 20,
                                  assetPath: 'assets/icons/claim_services.svg',
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
              Container(
                width: MediaQuery.of(context).size.width,
                height:
                    isOpen ? MediaQuery.of(context).size.height * 0.80 : null,
                child: isOpen
                    ? Image(
                        image: AssetImage("assets/icons/expanded_header_2.png"),
                        fit: BoxFit.fill,
                      )
                    : Image(
                        image:
                            AssetImage("assets/icons/collapsed_header_2.png"),
                      ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                    child: Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: EdgeInsets.all(20),
                                          child: SvgPicture.asset(
                                            "assets/icons/nav_icon.svg",
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                        onTap: () {
                                          ZoomDrawer.of(context)!.toggle();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(LocaleKeys.good_morning.tr(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 12, color: kHeaderColor)),
                                    textAlign: TextAlign.left)),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text("Smriti Ranjan Biswal",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: kHeaderColor,
                                            fontWeight: FontWeight.bold)),
                                    textAlign: TextAlign.left)),
                            isOpen
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.55,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 127,
                                                child: HeaderButton(
                                                    title: LocaleKeys
                                                        .motor_renewal
                                                        .tr()),
                                              ),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Text(
                                                      LocaleKeys.view_all.tr(),
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  kHeaderColor)),
                                                      textAlign:
                                                          TextAlign.left)),
                                            ],
                                          ),
                                          HeaderPolicyCard(),
                                          HeaderPolicyCard(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          /*  SizedBox(
                                          width: 140,
                                          child: HeaderButton(
                                            title:
                                                LocaleKeys.medical_renewal.tr(),
                                          ),
                                        ),*/
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 140,
                                                child: HeaderButton(
                                                    title: LocaleKeys
                                                        .medical_renewal
                                                        .tr()),
                                              ),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Text(
                                                      LocaleKeys.view_all.tr(),
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  kHeaderColor)),
                                                      textAlign:
                                                          TextAlign.left)),
                                            ],
                                          ),
                                          HeaderMedicalPolicyCard(),
                                          HeaderMedicalPolicyCard(),
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 20, left: 10),
                                    child: Container(
                                      height: 30,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          HeaderButton(
                                              title: LocaleKeys.motor_renewal
                                                  .tr()),
                                          HeaderButton(
                                            title:
                                                LocaleKeys.medical_renewal.tr(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            isOpen
                                ? Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text("+ Check More",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          notificationTextColor)),
                                              textAlign: TextAlign.left),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox()
                            /*Padding(
                              padding:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              child: Row(
                                children: [
                                  Text("Arabic",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: kHomeHeaderColor)),
                                      textAlign: TextAlign.left),
                                  Switch(
                                    // thumb color (round icon)
                                    activeColor: Colors.amber,
                                    activeTrackColor: Colors.cyan,
                                    inactiveThumbColor:
                                        Colors.blueGrey.shade600,
                                    inactiveTrackColor: Colors.grey.shade400,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: forArabic,
                                    // changes the state of the switch
                                    onChanged: (value) {
                                      setState(() async {
                                        if (forArabic == true)
                                          await context.setLocale(
                                              context.supportedLocales[1]);
                                        else
                                          await context.setLocale(
                                              context.supportedLocales[0]);
                                        forArabic = value;
                                      });
                                    },
                                  ),
                                ],
                              ))*/
                          ],
                        ))),
              ),
              isOpen
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.74,
                      right: MediaQuery.of(context).size.width * 0.08,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Positioned(
                      top: MediaQuery.of(context).size.height * 0.20,
                      right: MediaQuery.of(context).size.width * 0.08,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      slideWidth: 300,
      isRtl: true,
      menuBackgroundColor: bgColor,
    ));
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
       /* boxShadow: [
          BoxShadow(
            color: Color(0xffE5E5EB),
            blurRadius: 15.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, -3.0),
          )
        ],*/
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
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
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        File file = await _downloadFile('${assets.elementAt(i).httpUrl}',
            '${assets.elementAt(i).filename}', documentDirectory.path);
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

  void showDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Card(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () => Navigator.of(context).pop('item1'),
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () => Navigator.of(context).pop('item2'),
                    ),
                    ListTile(
                      title: Text('Item 3'),
                      onTap: () => Navigator.of(context).pop('item3'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
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

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;

  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int? currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), //or 15.0
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: dashboardBackground,
                    child: Icon(Icons.person, color: Colors.white, size: 50.0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 12),
                          color: notificationTextColor),
                    ),
                    Text("Smriti Ranjan Biswal",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 12),
                            fontWeight: FontWeight.bold,
                            color: kHeaderColor)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.person_rounded,
                    size: 20.0, color: currentIndex == 1
                        ? bgColor:kHeaderColor),
              ),
              title: Text("Profile",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: currentIndex == 1
                      ? bgColor:kHeaderColor)),
              tileColor: currentIndex == 1 ? Colors.white : null,
              shape: RoundedRectangleBorder( //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
              ),
              //textColor: Colors.white,
              dense: true,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.home_rounded,
                    size: 20.0, color: currentIndex == 2
                    ? bgColor:kHeaderColor),
              ),
              title: Text("Home",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: currentIndex == 2
                      ? bgColor:kHeaderColor)),
              tileColor: currentIndex == 2 ? Colors.white : null,
              shape: RoundedRectangleBorder( //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
              ),
              textColor: Colors.white,
              dense: true,

              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 20),
                child:  Icon(Icons.production_quantity_limits_rounded,
                    size: 20.0, color: currentIndex == 3
                        ? bgColor:kHeaderColor),
              ),
              tileColor: currentIndex == 3 ? Colors.white : null,
              shape: RoundedRectangleBorder( //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text("Products",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12),
                      color: currentIndex == 3
                          ? bgColor
                          : kHeaderColor)),
              //textColor: currentIndex == 3 ? Colors.blue:Colors.white,
              dense: true,

              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.miscellaneous_services_rounded,
                    size: 20.0, color: currentIndex == 4
                        ? bgColor:kHeaderColor),
              ),
              title: Text("Services",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
              textColor: Colors.white,
              dense: true,

              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 5;
                });
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 20),
                child: const Icon(Icons.policy_rounded,
                    size: 20.0, color: Colors.white),
              ),
              title: Text("My Policies",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 6;
                });
              },
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: const Icon(Icons.cached_rounded,
                    size: 20.0, color: Colors.white),
              ),
              title: Text("Claims",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
              textColor: Colors.white,
              dense: true,
              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  currentIndex = 7;
                });
              },
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: const Icon(Icons.settings_rounded,
                    size: 20.0, color: Colors.white),
              ),
              title: Text("Settings",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
              textColor: Colors.white,
              dense: true,
              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {},
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: const Icon(Icons.policy_rounded,
                    size: 20.0, color: Colors.white),
              ),
              title: Text("Terms & Conditions",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
              textColor: Colors.white,
              dense: true,
              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {},
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: const Icon(Icons.support_agent_rounded,
                    size: 20.0, color: Colors.white),
              ),
              title: Text("Support",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
              textColor: Colors.white,
              dense: true,
              // padding: EdgeInsets.zero,
            ),
            ListTile(
              onTap: () {},
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: const Icon(Icons.logout_rounded,
                    size: 20.0, color: Colors.white),
              ),
              title: Text("Logout",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12), color: kHeaderColor)),
              textColor: Colors.white,
              dense: true,
              // padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
