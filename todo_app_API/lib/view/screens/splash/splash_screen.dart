 import 'package:flutter/material.dart';
import 'package:todo_app_api/view/screens/auth/loigin_screen.dart';
import 'package:todo_app_api/view/screens/homme/all_tasks_screen.dart';
import 'package:todo_app_api/view_model/data/local/cash_helper.dart';
import 'package:todo_app_api/view_model/data/local/local_keys.dart';
import 'package:todo_app_api/view_model/utils/app_assets.dart';
import 'package:todo_app_api/view_model/utils/navigations.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});
 
   @override
   State<SplashScreen> createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State<SplashScreen> {
   @override
   void initState(){
     Future.delayed(Duration(seconds: 2,), () {
       if(CacheHelper.get(key: LocalKeys.token)==null) {
         Navigation.pushAndRemove(context, LoginScreen());
       }
       else{
         Navigation.pushAndRemove(context, AllTasksScreen());

       }
     });
   }




   Widget build(BuildContext context) {
     return Scaffold(
       body: Center(
         child: Image.asset('assets/logo.png.png'),
       ),
     );
   }
 }
 