import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  int get counterValue => count;

  void incrementCount() {
    count++;
    setState(() {});
    debugPrint(count.toString());
  }

  void decrementCount() {
    count--;
    setState(() {});
    debugPrint(count.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MyInhWidget(
            myState: this,
            child: const AppRoot(),
          )
        ],
      ),
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final rootStateCount = MyInhWidget.of(context)!.myState;

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            "Root state: ${rootStateCount.counterValue}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            CounterApp(),
            CounterApp(),
          ],
        )
      ],
    );
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final rootState = MyInhWidget.of(context)!.myState;

    return Container(
      color: Colors.yellow,
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width / 2.2,
      child: Column(
        children: [
          Text(
            "Count - ${rootState.counterValue}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  rootState.decrementCount();
                },
                child: const Icon(Icons.remove),
              ),
              ElevatedButton(
                onPressed: () {
                  rootState.incrementCount();
                },
                child: const Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MyInhWidget extends InheritedWidget {
  final _MyAppState myState;

  const MyInhWidget({super.key, required this.myState, required super.child});

  @override
  bool updateShouldNotify(MyInhWidget oldWidget) {
    return oldWidget.myState.counterValue != myState.counterValue;
  }

  static MyInhWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInhWidget>();
  }
}
