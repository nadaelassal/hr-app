// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr_app/app_router.dart';
import 'package:hr_app/constants/strings.dart';

late String initialRoute ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp( options: FirebaseOptions(
    apiKey: 'AIzaSyCZHuRMXdDdkuzvAnpgII7ts-FjFnKtYOI',
    appId: '1:529111039511:android:f9a1ed66e7e1262ebf6652',
    messagingSenderId: '529111039511',
    projectId: 'hr-app-5f9b6',
    storageBucket: 'hr-app-5f9b6.appspot.com',
  )
 );
 FirebaseAuth.instance.authStateChanges().listen((user){
  if(user == null){
    initialRoute = loginScreen ;  
    }else{
      initialRoute = dataScreen ;
    }
 });
 
  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});


final AppRouter appRouter ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute ,
    );
  }
}


