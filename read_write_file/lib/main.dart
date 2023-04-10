import 'package:flutter/material.dart';
import 'package:read_write_file/db/database.dart';
import 'package:read_write_file/models/user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  final _editCtrl = TextEditingController();

  late Future<List<User>> _userList;
  String? _userName;
  bool isUpdate = false;
  int? userId;

  updateUserList() {
    setState(() {
      _userList = DBProvider.db.getUsers();
    });
  }

  @override
  void initState() {
    updateUserList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _editCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              TextFormField(
                controller: _editCtrl,
                onSaved: (newValue) => setState(() => _userName = newValue),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Enter student name here...",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (isUpdate) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          DBProvider.db
                              .updateUser(User(id: userId!, name: _userName!))
                              .then((value) {
                            setState(() {
                              isUpdate = false;
                            });
                          });
                        }
                      } else {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          DBProvider.db.insertUser(
                            User(id: null, name: _userName!),
                          );
                        }
                      }
                      _editCtrl.text = '';
                      updateUserList();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(isUpdate ? "Update" : "Add"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isUpdate = false;
                        _editCtrl.text = '';
                        setState(() {});
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(isUpdate ? "Cancel update" : "Clear"),
                  ),
                ],
              ),
              Expanded(
                  child: FutureBuilder(
                future: _userList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return generateUser(snapshot.data);
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Text("Database is empty!");
                  }
                  return const CircularProgressIndicator();
                },
              ))
            ]),
          ),
        ),
      ),
    );
  }

  Widget generateUser(List<User>? data) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400.0,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("NAME")),
            DataColumn(label: Text("DELETE")),
          ],
          rows: data!
              .map(
                (user) => DataRow(
                  cells: [
                    DataCell(
                      Text(user.name!),
                      onTap: () {
                        userId = user.id!;
                        isUpdate = true;
                        _editCtrl.text = user.name!;
                        setState(() {});
                      },
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          DBProvider.db.deleteUser(user.id!);
                          updateUserList();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
