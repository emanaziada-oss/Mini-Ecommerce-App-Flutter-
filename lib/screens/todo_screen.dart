import 'package:flutter/material.dart';
import 'package:myproject/bloc/todo/todo_cubit.dart';
import 'package:myproject/bloc/todo/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/core/data/models/todo_model.dart';
class TodoScreen extends StatelessWidget {
   TodoScreen({super.key});
 final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create :(context )=> TodoCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ToDo')),
          ),
          body: BlocBuilder<TodoCubit , TodoState>(
              builder: (BuildContext context , state) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                            controller: controller,
                          decoration: const InputDecoration(
                            hintText: ('Add task'),
                          ),
                        ),
                        ElevatedButton(onPressed: (){
                          if(controller.text.trim().isEmpty ) return ;
                          context.read<TodoCubit>().addToDo(controller.text.trim());
                          controller.clear();
                          }, child: Text('Add')),
                        Expanded(child: ListView.builder(
                            itemCount:state.todos.length,
                          itemBuilder: (BuildContext context , int index){
                              return ListTile(
                                leading: Checkbox(value: state.todos[index].isCompleted, onChanged: (value){
                                  context.read<TodoCubit>().toggleTask(state.todos[index].id);
                                }),
                                title: Text(state.todos[index].title), 
                                  trailing: IconButton(onPressed: (){
                                    context.read<TodoCubit>().removeToDo(state.todos[index].id);
                                  }, icon: Icon(Icons.delete, color: Colors.red,) 
                                  )    
                              );
                          },

                        ))
                      ],
                    ),
                  ),
                );
              })



          )
        ),
      );
  }
}
