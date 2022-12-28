import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_app/Home.dart';
import 'package:sql_app/sqldb.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, this.id, this.title, this.note});

  final id;
  final title;
  final note;

  static const ScreenRoute = "Editnotes";

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  SQlDb sqldp = SQlDb();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(
            children: [
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: note,
                        decoration: InputDecoration(hintText: 'note'),
                      ),
                      TextFormField(
                          controller: title,
                          decoration: InputDecoration(hintText: 'title')),
                      TextFormField(
                          controller: color,
                          decoration: InputDecoration(hintText: 'color')),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 99,
                          height: 33,
                          child: MaterialButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () async {
                              int response = await sqldp.UpdateData(
                                  'UPDATE notes SET note = "${note.text}" , title = "${title.text}" WHERE id = ${widget.id} ');
                              print("response===============");
                              print(response);

                              if (response > 0) {
                                Navigator.pushReplacementNamed(
                                    context, Homeos.ScreenRoute);
                              }
                            },
                            child: Text("Edit Note"),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
