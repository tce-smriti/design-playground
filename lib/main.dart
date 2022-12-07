import 'package:art_flutter/presentation/custom_nav_bar.dart';
import 'package:art_flutter/presentation/customize_screen.dart';
import 'package:art_flutter/presentation/home_screen.dart';
import 'package:art_flutter/presentation/language_view.dart';
import 'package:art_flutter/presentation/splash_screen.dart';
import 'package:art_flutter/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:proste_bezier_curve/utils/type/index.dart';

import 'locales/l10.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: L10n.all,
    path: 'assets/locales',
    fallbackLocale: L10n.all[0],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ART Flutter',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: theme(), home: SplashScreen());
  }
}

