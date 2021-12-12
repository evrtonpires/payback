import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:payback/app/app_routing.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayBack',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteNamed.login.fullPath,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            useCountryCode: false,
            fallbackFile: 'pt',
            basePath: 'assets/i18n',
            forcedLocale: const Locale('pt'),
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'), // Português
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
    ).modular();
  }
}
