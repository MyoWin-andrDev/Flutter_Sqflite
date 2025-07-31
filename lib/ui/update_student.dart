import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../model/student_model.dart';

class UpdateStudent extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;

  const UpdateStudent({super.key, required this.id, required this.name, required this.email, required this.phone, required this.address});


  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String? name, address, email, phone;
  @override
  void initState() {
    super.initState();
    name = widget.name;
    address = widget.address;
    email = widget.email;
    phone = widget.phone;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async{
                if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  int result = await DatabaseHelper().insertStudent(
                      StudentModel.insertStudent(name: name ?? '', email: email ?? '', address: address ?? '', phone: phone ?? '')
                  );
                  if(result > 0){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Added Successfully")));
                    Navigator.pop(context);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!!!")));
                  }
                  print(result);
                }
              },
              child: Text("Update"))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            // Name Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter Name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (value){
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
              ],
            ),

            // Email Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter Email",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (value){
                    email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
              ],
            ),

            // Phone Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Phone No.", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      hintText: "Enter Phone",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (value){
                    phone = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
              ],
            ),

            // Address Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: address,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      hintText: "Enter Address",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (value){
                    address = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

