import 'package:flutter/material.dart';
import 'package:localization_demo/controller/language_change_controller.dart';
import 'package:localization_demo/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final languageCode = sp.getString("language_code") ?? "";
  runApp(MyApp(locale: languageCode));
}

class MyApp extends StatelessWidget {

  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LangaugeChangeController()),
      ],
      child: Consumer<LangaugeChangeController>(
        builder: (context, model, child) {
          if(locale.isEmpty || locale == null) {
            model.changeLanguage(Locale('en'));
          }
          return MaterialApp(
            title: 'Flutter Demo',
            locale: locale == "" ? Locale('en') : model.appLocale ?? Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: [
              Locale('en'),
              Locale('hi')
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        }
      ),
    );
  }
}