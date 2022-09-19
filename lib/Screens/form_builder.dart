import 'package:flutter/material.dart';
import '../Widgets/form_maker_widget.dart';
import '../providers/question.dart' show Questions, Option;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FormBuilder extends StatefulWidget {
  const FormBuilder({Key? key}) : super(key: key);

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  @override
  Widget build(BuildContext context) {
    var qs = Provider.of<Questions>(context).questions;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<Questions>(context, listen: false).addquestion(
              "Enter the question", "black", [Option('Option1', 1)]);
        },
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: qs.length,
                  itemBuilder: (ctx, position) {
                    return FormMaker(q: qs[position], p: position);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              child: RaisedButton(
                color: Colors.blueGrey,
                onPressed: () {
                  Provider.of<Questions>(context, listen: false).display();
                },
                child: Text('Generate Form'),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
