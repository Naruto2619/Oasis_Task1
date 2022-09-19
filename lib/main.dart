import 'package:flutter/material.dart';
import './Screens/form_builder.dart';
import 'package:oasis_1/providers/question.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Questions([
            Question("Enter the question", "type", [Option('Option', 1)])
          ], "1"),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FormBuilder(),
      ),
    );
  }
}
