import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myproject/provider_todo/provider_todo.dart'; // TodoProvider
import 'package:myproject/core/data/models/todo_model.dart'; // TodoModel

class TodoScreenProvider extends StatelessWidget {
  TodoScreenProvider({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('ToDo')),
          ),
          body: Consumer<TodoProvider>(
            builder: (context, todoProv, _) {
              return Padding(
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
                        todoProv.add(text);
                        controller.clear();
                      },
                      child: const Text('Add'),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: todoProv.todos.length,
                        itemBuilder: (context, index) {
                          final todo = todoProv.todos[index];
                          return ListTile(
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                todoProv.toggleTask(todo.id);
                              },
                            ),
                            title: Text(todo.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                todoProv.removeTodo(todo.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
