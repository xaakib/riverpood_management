import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: deprecated_member_use
import 'package:hooks_riverpod/all.dart';
import 'package:riverpood_management/notifier/todos_notifiers.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController();
    final todoList = useProvider(todoListProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: Text("TodoApp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: descriptionController,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final todoListItem = todoList[index];

                    return Card(
                      child: ListTile(
                        title: Text("${todoListItem.description}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit), onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  context
                                      .read(todoListProvider)
                                      .removeTodo(todoListItem.id);
                                }),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read(todoListProvider)
              .addTodo(description: descriptionController.text);
          descriptionController.clear();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
