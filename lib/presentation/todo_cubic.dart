import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();
    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);

    await todoRepo.addTodo(newTodo);

    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);

    loadTodos();
  }

  Future<void> toggleComplete(Todo todo) async {
    final updatedTodo = todo.toggleComplete();

    await todoRepo.updateTodo(updatedTodo);

    loadTodos();
  }
}
