import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_app/Home.dart';
import 'package:sql_app/sqldb.dart';

class Addnotes extends StatefulWidget {
  const Addnotes({super.key});

  static const ScreenRoute = "Addnotes";

  @override
  State<Addnotes> createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  SQlDb sqldp = SQlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
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
                              int response = await sqldp.insertData('''
                                  INSERT INTO notes ('note' , 'title' , 'color')
                              VALUES  ( "${note.text}" , "${title.text}" , "${color.text}" )''');
                              print("response===============");
                              print(response);

                              if (response > 0) {
                                Navigator.pushReplacementNamed(
                                    context, Homeos.ScreenRoute);
                              }
                            },
                            child: Text("Add Note"),
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
