import 'package:flutter/material.dart';
import 'package:myproject/getx/todo_controller.dart';
import 'package:get/get.dart';

class TodoScreengetx extends StatelessWidget {
  TodoScreengetx({super.key});
  final TextEditingController controller = TextEditingController();
  final TodoController controllerGetx = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('ToDo')),
          ),
          body: Obx(()=>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Add task',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isEmpty) return;
                        controllerGetx.addToDo(text);
                        controller.clear();
                      },
                      child: const Text('Add' , style: TextStyle(color: Colors.red),),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controllerGetx.todos.length,
                        itemBuilder: (context, index) {
                          final todo = controllerGetx.todos[index];
                          return ListTile(
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                controllerGetx.toggleTask(todo.id);
                              },
                            ),
                            title: Text(todo.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                controllerGetx.removeTodo(todo.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
          )

          ),
        );
  }
}
