import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization_demo/controller/language_change_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Langauge { english, hindi }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.helloWorld,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Consumer<LangaugeChangeController>(builder: (context, model, child) {
            return PopupMenuButton(
              onSelected: (Langauge item) {
                if (Langauge.english.name == item.name) {
                  model.changeLanguage(Locale('en'));
                } else {
                  model.changeLanguage(Locale('hi'));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Langauge>>[
                PopupMenuItem(
                  value: Langauge.english,
                  child: Text("English"),
                ),
                PopupMenuItem(
                  value: Langauge.hindi,
                  child: Text("Hindi"),
                ),
              ],
            );
          }),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.language,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
