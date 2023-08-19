import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_api/model/tasks.dart';
import 'package:todo_app_api/view/components/task/task_widget.dart';
import 'package:todo_app_api/view/components/widgets/text_costume.dart';
import 'package:todo_app_api/view/screens/auth/loigin_screen.dart';
import 'package:todo_app_api/view/screens/homme/add_task_screen.dart';
import 'package:todo_app_api/view_model/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:todo_app_api/view_model/bloc/tasks_cubit/tasks_state.dart';
import 'package:todo_app_api/view_model/data/local/cash_helper.dart';
import 'package:todo_app_api/view_model/utils/constatns.dart';
import 'package:todo_app_api/view_model/utils/navigations.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TasksCubit.get(context).getAllTasks();
    return BlocProvider.value(
      value: TasksCubit.get(context)
        ..getAllTasks(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: TextCustom(
            text: 'Todo App',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigation.pushAndRemove(
                  context,
                  LoginScreen(),
                );
                CacheHelper.clearData();
              },
              icon: Icon(Icons.exit_to_app_rounded),
            ),
          ],
        ),
        body: BlocConsumer<TasksCubit, TasksState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = TasksCubit.get(context);
            return state is GetAllTasksLoadingState
                ? Center(child: CircularProgressIndicator.adaptive())
                : Visibility(
              visible: cubit.tasksModel?.tasks?.isEmpty ?? false,
              child: ListView.separated(
                padding: EdgeInsets.all(12.sp),
                itemBuilder: (context, index) {
                  return TaskWidget(
                    task: cubit.tasksModel?.tasks?[index] ?? Task(),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(
                      height: 10.h,
                    ),
                itemCount: cubit.tasksModel?.tasks?.length ?? 0,
              ),
              replacement: Center(

                child: Column(
                  children: [
                    Lottie.network(
                        'https://lottie.host/e5be9638-b3a5-4ef0-8f6d-d7ced8f8bbb9/wGUouRIjto.json'),
                    TextCustom(text:'No Tasks Add Some Tasks Please...',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,

                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigation.push(context, AddTaskScreen());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
