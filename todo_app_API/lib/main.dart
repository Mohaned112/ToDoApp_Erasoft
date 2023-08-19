import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_api/view/screens/splash/splash_screen.dart';
import 'package:todo_app_api/view_model/bloc/Auth_cubit/auth_cubit.dart';
import 'package:todo_app_api/view_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:todo_app_api/view_model/data/local/cash_helper.dart';
import 'package:todo_app_api/view_model/data/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  CacheHelper.clearData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => TasksCubit()..getAllTasks()),

          ],
          child: MaterialApp(
            title: 'To Do App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
