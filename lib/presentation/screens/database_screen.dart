import 'package:flutter/material.dart';
import 'package:hr_app/database/sqldb.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  State<DatabaseScreen> createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  SqlDb sqlDb = SqlDb();


  Future<List<Map>>insertData() async{
    List<Map>response = await sqlDb.insertData("INSERT INTO data (phone_number , name,vacation)VALUES (01273526705 , nada ,  days)");
    print(response);
    return response ;
   
  }
  

    Future<List<Map>>readData() async{
    List<Map>response = await sqlDb.readData("SELECT * FROM data");
    return response ;
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Center( child: 
MaterialButton(onPressed: ()async {
       
       insertData();
       readData();
      
       }
/*
      child: ListView(
        children: [
          FutureBuilder(
             future: readData(),
            builder: (BuildContext context ,AsyncSnapshot<List<Map>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context , i ){
                  return Text('${snapshot.data![i]}');

                });
            }
              return Center(child: CircularProgressIndicator(),);
            
          },),
        ],
      ),
      
    
      */
)
    );
  }
}