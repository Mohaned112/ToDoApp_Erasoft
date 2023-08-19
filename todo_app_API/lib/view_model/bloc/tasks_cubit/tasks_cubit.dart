import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api/model/tasks.dart';
import 'package:todo_app_api/view/components/widgets/toast_messages.dart';
import 'package:todo_app_api/view/screens/homme/add_task_screen.dart';
import 'package:todo_app_api/view_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:todo_app_api/view_model/data/local/cash_helper.dart';
import 'package:todo_app_api/view_model/data/local/local_keys.dart';
import 'package:todo_app_api/view_model/data/network/dio_helper.dart';
import 'package:todo_app_api/view_model/data/network/end_points.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of<TasksCubit>(context);


TasksModel? tasksModel;

  Future<void> getAllTasks() async {
    emit(GetAllTasksLoadingState());
    await DioHelper.getData(
        endPoint: EndPoints.tasks,
        token: CacheHelper.get(
          key: LocalKeys.token,
        )).then((value) {
          tasksModel = TasksModel.fromJson(value.data);

      emit(GetAllTasksSuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(GetAllTasksErrorState());
    });
  }

GlobalKey<FormState> formKey = GlobalKey<FormState>();


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();


 Future<void> addTask() async{
   emit(AddTaskLoadingState());
   await DioHelper.postData(
       endPoint: EndPoints.tasks,
     body: {
         'title' :titleController.text,
       'description':descriptionController.text,
       'start_date' : startDateController.text,
       'end_date' : endDateController.text,
     }

   ).then((value) {
     print(value.data);
     //Task newTask = Task.fromJson(value.data['response']);
    // tasksModel?.tasks?.add(newTask);
     showToast(message: 'Tasks Added Successfully');
     emit(AddTaskSuccessState());
     getAllTasks();
     titleController.clear();
     descriptionController.clear();
     startDateController.clear();
     endDateController.clear();
   }).catchError((error){
     print(error.toString());
     if (error is DioException){
       print(error.response?.data);
       showToast(message:error.response?.data ['response'].toString() ?? 'There\'s an Error',
         color: Colors.red,
           );
     }
     emit(AddTaskErrorState());
     throw error;
     
   }

   );


  }

}
