import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/database/database_helper.dart';
import 'package:sqlite/ui/add_student.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Databases"),
        centerTitle: true,
        actions: [IconButton(
            onPressed: () async{
              var result  = await Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (context) => AddStudent()));
              if(result == "success"){
                setState(() {});
              }
            },
            icon: Icon(Icons.add))],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: DatabaseHelper().getAllStudent(),
          builder: (context, snapshot){
            if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index){
                  Map student = snapshot.data![index];
                 return ListTile(
                   leading: Text(student['id'].toString()),
                   title : Text(student['name']),
                   subtitle : Text(student['address']),
                   trailing: Text(student['email'])
                 );
                }
            );
            }
            print(snapshot);
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
