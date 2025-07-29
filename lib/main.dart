import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/ui/home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();//Flutter engine and framework are properly set up before running the app
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
    );
  }
}
