import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_api/view/components/widgets/elevated_button.dart';
import 'package:todo_app_api/view/components/widgets/text_costume.dart';
import 'package:todo_app_api/view/components/widgets/text_form_field_costume.dart';
import 'package:todo_app_api/view/screens/auth/loigin_screen.dart';
import 'package:todo_app_api/view/screens/homme/all_tasks_screen.dart';
import 'package:todo_app_api/view_model/bloc/Auth_cubit/auth_cubit.dart';
import 'package:todo_app_api/view_model/bloc/Auth_cubit/auth_cubit.dart';
import 'package:todo_app_api/view_model/bloc/Auth_cubit/auth_state.dart';
import 'package:todo_app_api/view_model/utils/app_assets.dart';
import 'package:todo_app_api/view_model/utils/navigations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Form(
                key: cubit.registerFormKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Image.asset(
                      AppAssets.logoIcon,
                      height: 150.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const TextCustom(
                      text: 'Create Account',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCustom(
                      controller: cubit.registerNameController,
                      'Name',
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if ((value ?? '').isEmpty) {
                          return 'Name is required';
                        }

                        return null;
                      },
                      labelText: 'Name',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormFieldCustom(
                      controller: cubit.registerEmailController,
                      'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if ((value ?? '').isEmpty) {
                          return 'Email is required';
                        }

                        return null;
                      },
                      labelText: 'Email',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormFieldCustom(
                      controller: cubit.registerPasswordController,
                      'Password',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: (String? value) {
                        if ((value ?? '').isEmpty) {
                          return 'Password is required';
                        } else if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else if (RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
                        ).hasMatch(value ?? '')) {}

                        return null;
                      },
                      labelText: 'Password',
                      obSecure: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    state is RegisterLoadingState
                        ? CircularProgressIndicator.adaptive()
                        : ElevatedButtonCustom(
                            onPressed: () {
                              if (cubit.registerFormKey.currentState!
                                  .validate()) {
                                print("${cubit.registerFormKey}");

                                cubit.userRegister().then(
                                      (value) {
                                        cubit.registerEmailController.clear();
                                        cubit.registerPasswordController.clear();
                                        cubit.registerNameController.clear();
                                        Navigator.pop(context);
                                      }
                                    );
                              }
                            },
                            text: 'Create Account',
                          )
                  ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
