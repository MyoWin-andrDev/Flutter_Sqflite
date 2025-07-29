import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/database/database_helper.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Databases"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            DatabaseHelper databaseHelper = DatabaseHelper();
            var result = await databaseHelper.insertStudent({
              'name' : 'MyoWin',
              'address' : 'Yangon',
              'email' : '1235@gmail.com'
            });
            print(result);
          },
          child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: DatabaseHelper().getAllStudent(),
          builder: (context, snapshot){
            if(snapshot.hasData){
            return Text(snapshot.data.toString());
            }
            print(snapshot);
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
