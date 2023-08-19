import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_api/view/components/widgets/elevated_button.dart';
import 'package:todo_app_api/view/components/widgets/text_costume.dart';
import 'package:todo_app_api/view/components/widgets/text_form_field_costume.dart';
import 'package:todo_app_api/view_model/bloc/tasks_cubit/tasks_cubit.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: TextCustom(
          text: 'Add Task',
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              TextFormFieldCustom(
                'Add task',
                labelText: 'Add task',
                prefix: Icon(Icons.task_outlined),
                controller: cubit.titleController,
                validator: (String? value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Title must not be Empty';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormFieldCustom(
                'Add Description',
                labelText: 'Add Description',
                controller:cubit.descriptionController ,
                prefix: Icon(Icons.description_outlined),
                validator: (String? value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Description must not be Empty';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormFieldCustom(
                'Start Date',
                labelText: 'Start Date',
                  controller: cubit.startDateController,
                prefix: Icon(Icons.timer_sharp),
                validator: (String? value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Start Date must not be Empty';
                  }
                  return null;
                },
                keyboardType: TextInputType.none,
                onTap: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 10),
                  ).then((value){
                    if(value != null){
    cubit.startDateController.text = DateFormat('yyy/MM/dd').format(value);
    }
                    else{
                      cubit.startDateController.clear();


                    }
                  }
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormFieldCustom(
                'End Date',
                labelText: 'End Date',
                controller: cubit.endDateController,
                prefix: Icon(Icons.timer_off_outlined),
                validator: (String? value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'End Date must not be Empty';
                  }
                  return null;
                },
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 10),
                  ).then((value){
                    if(value != null){
                      cubit.endDateController.text = DateFormat('yyy/MM/dd').format(value);
                    }
                    else{
                      cubit.endDateController.clear();


                    }
                  }
                  );
                },
                keyboardType: TextInputType.none,
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButtonCustom(
                onPressed: () {
                  if(cubit.formKey.currentState!.validate()){
                    cubit.addTask().then((value) => Navigator.pop(context));

                  }
                },
                text: 'Add Task',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
