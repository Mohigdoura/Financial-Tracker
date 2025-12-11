import 'package:financial_tracker/services/db.dart';
import 'package:financial_tracker/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  List<int> list = [1, 2, 3];
  final TextEditingController textEditingController = TextEditingController();
  final db = Db();
  @override
  void initState() {
    super.initState();
    db.getList().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Financial Tracker',
              style: TextStyle(
                color: theme.colorScheme.inversePrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          IconButton(
            onPressed: () async => await authNotifier.signOut(),
            icon: Icon(Icons.logout, color: theme.colorScheme.inversePrimary),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    list[index].toString(),
                    style: TextStyle(color: theme.colorScheme.inversePrimary),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (value) async {
                if (value.logicalKey == LogicalKeyboardKey.enter) {
                  final text = textEditingController.text.trim();

                  if (text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter a value",
                          style: TextStyle(
                            color: theme.colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    );
                    return;
                  }

                  final number = int.tryParse(text);
                  if (number == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please enter a valid number',
                          style: TextStyle(
                            color: theme.colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    );
                    return;
                  }

                  await db.addToDB(number);

                  final newList = await db.getList();
                  setState(() {
                    list = newList;
                  });

                  textEditingController.clear();

                  if (context.mounted) Navigator.pop(context);
                }
              },

              child: AlertDialog(
                title: Text(
                  'Add a new item',
                  style: TextStyle(color: theme.colorScheme.inversePrimary),
                ),
                content: TextField(
                  autofocus: true,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: theme.colorScheme.inversePrimary),
                  decoration: const InputDecoration(hintText: 'Enter a number'),
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      final text = textEditingController.text.trim();
                      if (text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please enter a value',
                              style: TextStyle(
                                color: theme.colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                        );
                        return;
                      }
                      final value = int.tryParse(text);
                      if (value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please enter a valid number',
                              style: TextStyle(
                                color: theme.colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                        );
                        return;
                      }
                      await db.addToDB(value);
                      final newList = await db.getList();
                      setState(() {
                        list = newList;
                      });
                      textEditingController.clear();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.add),
                    isSelected: true,
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
