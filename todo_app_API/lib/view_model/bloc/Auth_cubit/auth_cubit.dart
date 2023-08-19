import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api/model/user.dart';
import 'package:todo_app_api/view/components/widgets/toast_messages.dart';
import 'package:todo_app_api/view_model/bloc/Auth_cubit/auth_state.dart';
import 'package:todo_app_api/view_model/data/data_source.dart';
import 'package:todo_app_api/view_model/data/local/cash_helper.dart';
import 'package:todo_app_api/view_model/data/local/local_keys.dart';
import 'package:todo_app_api/view_model/data/network/dio_helper.dart';
import 'package:todo_app_api/view_model/data/network/end_points.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  WebService webService = WebService();

  // get userRegister => null;

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();

  User? user;

  Future<void> userLogin() async {
    emit(LoginLoadingState());
    // try {
    //   await webService.loginIn(
    //       name: registerNameController.text,
    //       email: loginEmailController.text,
    //       password: loginPasswordController.text);
    //   emit(LoginSuccessState());
    // } catch (e) {
    //   emit(LoginErrorState());
    // }

    await DioHelper.postData(
      endPoint: EndPoints.login,
      body: {
        'email': loginEmailController.text,
        'password': loginPasswordController.text,
      },
    ).then((value) {
      print(value.data);
      user = User.fromJson(value.data['user']);
      print(user?.name);
      emit(LoginSuccessState());
      showToast(message: 'Welcome,${user?.name ?? 'to do app'} ');
      CacheHelper.put(
          key: LocalKeys.token, value: value.data['authorisation']['token']);
      CacheHelper.put(key: LocalKeys.userName, value: user?.name);
      return true;
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        showToast(
            message: error.response?.data['message'] ?? 'There\'s an error',
            color: Colors.red);
      }
      emit(LoginErrorState());

      throw error;
    });
  }

  Future<void> userRegister() async {
    emit(RegisterLoadingState());
    // try {
    //   DioHelper.postData(endPoint: 'register', body: {
    //     'name': registerNameController.text,
    //     'email': registerEmailController.text,
    //     'password': registerPasswordController.text,
    //   }).then((value) {
    //     registerNameController.clear();
    //     registerEmailController.clear();
    //     registerPasswordController.clear();
    //     showToast(message: 'Register success');
    //
    //   });
    //   emit(RegisterSuccessState());
    // } catch (e) {
    //   emit(RegisterErrorState());
    // }
    await DioHelper.postData(
      endPoint: EndPoints.register,
      body: {
        'name': registerNameController.text,
        'email': registerEmailController.text,
        'password': registerPasswordController.text,
      },
    ).then((value) {
      print(value.data);
      user = User.fromJson(value.data['user']);
      print(user?.name);
      registerEmailController.clear();
      registerNameController.clear();
      registerPasswordController.clear();
      emit(RegisterSuccessState());

      showToast(message: 'You are ready,${user?.name ?? 'to do app'} ');
      CacheHelper.put(
          key: LocalKeys.token, value: value.data['authorisation']['token']);
      CacheHelper.put(key: LocalKeys.userName, value: user?.name);
      return true;
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
        showToast(
            message: error.response?.data['message'] ?? 'There\'s an error',
            color: Colors.red);
      }
      emit(RegisterErrorState());

      throw error;
    });

  }
}
