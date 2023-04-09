import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
          FutureProvider<List<User>?>(
            create: (_) async => UserProvider().loadUsers(),
            initialData: null,
            child: const MyUserPage(),
          ),
        ],
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('WhatsApp'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  splashRadius: 25,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                  splashRadius: 25,
                ),
              ],
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.add)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.message)),
              ]),
            ),
            body: const TabBarView(
              children: [
                MyCountPage(),
                MyUserPage(),
                MyEventPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyEventPage extends StatelessWidget {
  const MyEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Event page")),
    );
  }
}

// User page, User Provider and User Model
class MyUserPage extends StatelessWidget {
  const MyUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<List<User>?>(
        builder: (context, users, _) {
          return SizedBox(
            child: users == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              "${users[index].firtsName} ${users[index].lastName} "),
                          Text("| ${users[index].website}"),
                        ],
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class User {
  final String firtsName;
  final String lastName;
  final String website;

  User(this.firtsName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firtsName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}

class UserList {
  final List<User> users;
  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((e) => User.fromJson(e)).toList();
}

class UserProvider {
  final dataPath = 'assets/users.json';
  late List<User> users;
  bool isLoading = true;

  Future<String> loadAsset() async {
    return await Future.delayed(const Duration(seconds: 5), () async {
      return await rootBundle.loadString(dataPath);
    });
  }

  Future<List<User>> loadUsers() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    isLoading = false;
    debugPrint(isLoading.toString());
    return users;
  }
}

// Counter page and Counter Provider
class MyCountPage extends StatelessWidget {
  const MyCountPage({super.key});
  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Counter: ${_state._count}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _state._decrementCount(),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(
                  width: 15,
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: () => value._incrementCount(),
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _count = 0;
  int get currentCount => _count;

  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}
