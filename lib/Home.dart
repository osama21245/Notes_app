import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:sql_app/AddNotes.dart';
import 'package:sql_app/Editnote.dart';
import 'package:sql_app/sqldb.dart';

class Homeos extends StatefulWidget {
  const Homeos({super.key});

  static const ScreenRoute = "Homepage";
  @override
  State<Homeos> createState() => _HomeosState();
}

class _HomeosState extends State<Homeos> {
  SQlDb sqldp = SQlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqldp.readData("SELECT * FROM 'notes'");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: Container(
        child: ListView(
          children: [
            FutureBuilder(
                future: readData(),
                builder:
                    ((BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                                title: Text("${snapshot.data![i]['title']}"),
                                subtitle: Text("${snapshot.data![i]['note']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            sqldp.deletetData(
                                                "DELETE FROM notes WHERE id = ${snapshot.data![i]['id']}");
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditNotes(
                                                        id: snapshot.data![i]
                                                            ['id'],
                                                        note: snapshot.data![i]
                                                            ['note'],
                                                        title: snapshot.data![i]
                                                            ['title'],
                                                      )));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ))
                                  ],
                                )));
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Addnotes.ScreenRoute);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
