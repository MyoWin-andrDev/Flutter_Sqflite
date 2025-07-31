import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/database/database_helper.dart';
import 'package:sqlite/ui/add_student.dart';
import 'package:sqlite/ui/update_student.dart';

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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent()));
            },
            icon: Icon(Icons.add))],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: DatabaseHelper().getAllStudent(),
          builder: (context, snapshot){
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No students found"));
            }
            else if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index){
                  Map student = snapshot.data![index];
                 return ListTile(
                   leading: Text(student['id'].toString()),
                   title : Text(student['name']),
                   subtitle : Text(student['address']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateStudent(id: student['id'], name: student['name'], email: student['email'], phone: student['phone'], address: student['address'])));
                              },
                              icon: Icon(Icons.edit, color: Colors.blue),
                              padding: EdgeInsets.all(8)
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.delete, color: Colors.red),
                              padding: EdgeInsets.all(8)
                          ),
                        ],
                      ),
                    ),
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
