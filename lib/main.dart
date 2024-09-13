import 'package:flutter/material.dart';

import 'custom_builder.dart';
import 'custom_notifier.dart';

void main() {
  runApp(const MyApp());
}

class _MyHomePageState extends State<MyHomePage> {
  final CustomNotifier<int> _counter = CustomNotifier<int>(0);

  final List<int> _options = [2, 4, 8, 12, 16];

  void _incrementCounter() {
    _counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomBuilder<int>(
              notifier: _counter,
              (_, int value) => Text(
                'You have pushed the button $value many times:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ..._options.map((int option) {
              return CustomBuilder(
                notifier: _counter,
                when: () async =>
                    _counter.value > 0 && _counter.value % option == 0,
                (_, int value) => Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'This widget have updated when you have clicked $value times:',
                  ),
                ),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
