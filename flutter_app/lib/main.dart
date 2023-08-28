import 'package:flutter/material.dart';
import 'package:flutter_app/global_bindings.dart';
import 'package:flutter_app/views/homepage/home_page.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
      return GetMaterialApp(
         debugShowCheckedModeBanner: false,
         home: HomePage(),
         title: "Let Him Cook! App",
         initialBinding: GlobalBindings(),
      );
   }
}
