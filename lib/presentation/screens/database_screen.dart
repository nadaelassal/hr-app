// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hr_app/database/sqldb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  State<DatabaseScreen> createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM Test');
    return response;
  }

  Future<List<Map>> mydeleteData() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'test.db');
    deleteDatabase(path);
    return mydeleteData();
  }

  void sendWhatsappMessage(String phone, String days) {
    String url = 'whatsapp://send?phone=+2$phone' +
        "&text=${Uri.encodeComponent("You have $days off")}";
    Text('you have {$days} off');
    launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  body: Container(
      margin: EdgeInsets.all(50),
        child: ListView(
          children: [
            FutureBuilder(
                future: readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              leading: Text('${snapshot.data![i]["name"]}') ,
                              subtitle: Text('${snapshot.data![i]["phone_number"]}')  ,
                              trailing: Text('${snapshot.data![i]["vacation"]}'),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      child: 
         MaterialButton(
              padding: EdgeInsets.all(20),
              onPressed: () async {
              int? id1 = await sqlDb.insertData(
                  'INSERT INTO Test(name, phone_number, vacation) VALUES(" nada", "01273526705" , "5 days" )',
                );
                int? id2 = await sqlDb.insertData(
                  'INSERT INTO Test(name, phone_number, vacation) VALUES("omar","01553465128" , "3 days")',
                );
                int? id3 = await sqlDb.insertData(
                  'INSERT INTO Test(name, phone_number, vacation) VALUES("fatma","01229561800", "6 days")',
                );
                int? id4 = await sqlDb.insertData(
                  'INSERT INTO Test(name, phone_number, vacation) VALUES("Mahmoud","01000406130", "2 days")',
                );
                print(id1);
                print(id2);
                print(id3);
                print(id4);
              List<Map>? response = await sqlDb.readData('SELECT * FROM Test');
               print(response);
              
              //mydeleteData();

              
              },
              
              child: Text('insert')),*/

      body: Container(
        child: ListView(
          children: [
            FutureBuilder(
                future: readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              leading: Text('${snapshot.data![i]["name"]}'),
                              subtitle:
                                  Text('${snapshot.data![i]["phone_number"]}'),
                              title: Text('${snapshot.data![i]["vacation"]}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    sendWhatsappMessage(
                                        '${snapshot.data![i]["phone_number"]}', '${snapshot.data![i]["vacation"]}');
                                  },
                                  icon: Icon(Icons.message)),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
