import 'package:bmi_calculator/data/session.dart';
import 'package:bmi_calculator/data/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  List<Session> sessionList = [];
  final TextEditingController textDescriptionController =
      TextEditingController();
  final TextEditingController textDurationController = TextEditingController();
  final SharedPreferenceHelper pref = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Training Session'),
      ),
      body: ListView(
        children: getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showSessionDialog(context);
        },
      ),
    );
  }

  @override
  void initState() {
    pref.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Insert Training Session'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: textDescriptionController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: 'Enter Training Description'),
                  ),
                  TextField(
                    controller: textDurationController,
                    keyboardType: TextInputType.name,
                    decoration:
                        const InputDecoration(labelText: 'Time Duration'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textDescriptionController.text = '';
                    textDurationController.text = '';
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    saveSession();
                  },
                  child: Text('Save'))
            ],
          );
        });
  }

  Future saveSession() async {
    DateTime currentDateTime = DateTime.now();
    String today =
        '${currentDateTime.day}/${currentDateTime.month}/${currentDateTime.year}';
    int id = pref.getCounter() + 1;
    Session newSession = Session(id, today, textDescriptionController.text,
        int.tryParse(textDurationController.text) ?? 0);
    pref.writeSession(newSession).then((_) {
      updateScreen();
      pref.setCounter();
    });
    textDescriptionController.text = " ";
    textDurationController.text = "";
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    sessionList.forEach((session) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          pref.deleteSession(session.id).then((value) => updateScreen());
        },
        child: ListTile(
          title: Text(session.description),
          subtitle:
              Text('${session.date} - duration: ${session.duration} minutes'),
        ),
      ));
    });
    return tiles;
  }

  void updateScreen() {
    sessionList = pref.getSessions();
    setState(() {});
  }
}
