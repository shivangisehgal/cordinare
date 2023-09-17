import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collegecomp/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void>main() async {
WidgetsFlutterBinding.ensureInitialized();
  //init the hive
  await Hive.initFlutter();
  await Firebase.initializeApp();

  //open a box 
  var box = await Hive.openBox("myBox");
  runApp(const Cordinare());
}
class Cordinare extends StatelessWidget {
  const Cordinare({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primary: Color(0xFFF35588)),
      ),
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}
