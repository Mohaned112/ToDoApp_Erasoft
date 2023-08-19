import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_api/model/tasks.dart';
import 'package:todo_app_api/view/components/widgets/text_costume.dart';
import 'package:todo_app_api/view_model/utils/constatns.dart';



class TaskWidget extends StatelessWidget {
  final Task task;
  const TaskWidget({required this.task,super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.cyan[120],
      borderRadius: BorderRadius.circular(12.r),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.blue,
                width: 1.w,
              )

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text:
              task.title ?? '',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              TextCustom(text:
              task.description ?? '',
                fontSize: 14.sp,
                maxline: 2,
              ),
              SizedBox(height: 10.h),


              Visibility(
                visible: task.image != null,
                child: Image.network('$baseImageUrl${task.image}',
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error_outline_rounded,color: Colors.red,));
                },
                ),
              ),
              SizedBox(height: 10.h),


              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.w,
                          )
                      ),

                      child: Row(
                        children: [
                          Icon(Icons.timer_sharp),
                          SizedBox(width: 5.w,),
                          Expanded(child: TextCustom(text: task.startDate ?? '',
                            maxline: 2,

                          )
                          ),
                        ],
                      ),
                    ),
                    ),
                    SizedBox(height: 10.h,),
                    Expanded(child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.w,
                          )
                      ),

                      child: Row(
                        children: [
                          Icon(Icons.timer_off_outlined),
                          SizedBox(width: 5.w,),
                          Expanded(child: TextCustom(
                            text: task.endDate ?? '',
                            maxline: 2,

                          )

                          ),
                        ],
                      ),
                    ),
                    ),

                  ],
                ),
              )

            ],
          ),

        ),
      ),
    );
  }
}
