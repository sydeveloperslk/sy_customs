import 'package:flutter/material.dart';
import 'package:sy_customs/sy_customs.dart';
import 'package:sy_customs/widgets/alert_box/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

class _MyHomePageState extends State<MyHomePage> {
  int val = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ex"),
      ),
      body: Column(children: [
        Text("$val"),
        ElevatedButton(
            onPressed: () {
              loadingBox(context, "title");
              setState(() {
                val = SYCalculator().addOne(val);
              });
            },
            child: Text("add"))
      ]),
    );
  }
}
