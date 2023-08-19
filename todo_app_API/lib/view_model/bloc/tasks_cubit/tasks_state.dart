
abstract class TasksState {}

class TasksInitial extends TasksState {}

class GetAllTasksLoadingState extends TasksState{}

class GetAllTasksSuccessState extends TasksState{}

class GetAllTasksErrorState extends TasksState{}

class AddTaskLoadingState extends TasksState{}
class AddTaskSuccessState extends TasksState{}
class AddTaskErrorState extends TasksState{}
