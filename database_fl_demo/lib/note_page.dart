import 'package:database_fl_demo/db/db_helper.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Map<String, dynamic>> allNotes = [];
  DbHelper? dbHelper;
  late TextEditingController textEditingControllerTitle;
  late TextEditingController textEditingControllerDescription;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper.getInstance;
    textEditingControllerTitle = TextEditingController();
    textEditingControllerDescription = TextEditingController();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notes"),
      ),
      //All notes show here -
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(allNotes[index][DbHelper.COLUMN_TITLE]),
                  subtitle: Text(allNotes[index][DbHelper.COLUMN_DESCRIPTION]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          showModalBottomSheet(
                            isDismissible: false,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              textEditingControllerTitle.text =
                                  allNotes[index][DbHelper.COLUMN_TITLE];
                              textEditingControllerDescription.text =
                                  allNotes[index][DbHelper.COLUMN_DESCRIPTION];
                              return _bottomSheetView(isUpdate: true, idNo: allNotes[index][DbHelper.COLUMN_SR_NO]);
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () async {
                            bool check = await dbHelper!.deleteNote(idNo: allNotes[index][DbHelper.COLUMN_SR_NO]);
                            if(check) {
                              getNotes();
                            }
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                );
              })
          : const Center(
              child: Text("No Notes Found."),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        backgroundColor: Colors.white70,
        onPressed: () async {
          showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              textEditingControllerTitle.clear();
              textEditingControllerDescription.clear();
              return _bottomSheetView();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void getNotes() async {
    allNotes = await dbHelper!.getAllNotes();
    setState(() {});
  }

  Widget _bottomSheetView({bool isUpdate = false, int idNo = 0}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isUpdate ? "Update Note" : "Add Note",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 21,
              ),
              TextField(
                controller: textEditingControllerTitle,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Enter title here",
                  label: const Text("Title*"),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              TextField(
                controller: textEditingControllerDescription,
                textInputAction: TextInputAction.done,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Enter description here",
                  label: const Text("Description*"),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)),
                          ),
                          onPressed: () async {
                            String title = textEditingControllerTitle.text
                                .toString()
                                .trim();
                            String description =
                                textEditingControllerDescription.text
                                    .toString()
                                    .trim();
                            if ((title.isNotEmpty && title != null) &&
                                (description.isNotEmpty &&
                                    description != null)) {
                              errorMessage = "";
                              bool check = isUpdate
                                  ? await dbHelper!.updateNote(
                                      mTitle: title,
                                      mDescription: description,
                                      idNo: idNo)
                                  : await dbHelper!.addNote(
                                      mTitle: textEditingControllerTitle.text
                                          .toString()
                                          .trim(),
                                      mDescription:
                                          textEditingControllerDescription.text
                                              .toString()
                                              .trim(),
                                    );
                              if (check) {
                                getNotes();
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please enter note value.")));
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            isUpdate ? "Update Note" : "Add Note",
                            style: TextStyle(color: Colors.black),
                          ))),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Text(errorMessage),
            ],
          ),
        ),
      ),
    );
  }
}
