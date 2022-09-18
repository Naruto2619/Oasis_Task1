import 'dart:convert';

import 'package:flutter/material.dart';
import './providers/question.dart';
import './optionWidget.dart';
import 'package:provider/provider.dart';

class FormMaker extends StatefulWidget {
  final Question q;
  final int p;
  const FormMaker({Key? key, required this.q, required this.p})
      : super(key: key);

  @override
  State<FormMaker> createState() => _FormMakerState();
}

class _FormMakerState extends State<FormMaker> {
  late List<Option> oplist = widget.q.options;
  List<String>? optex;
  late String finqtext;
  String inptype = "";
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var qconv = widget.q;
    var p = widget.p;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.black12),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        onSaved: (value) {
                          finqtext = value!;
                        },
                        decoration:
                            InputDecoration(hintText: qconv.questiontext),
                      ),
                    ),
                    DropdownButton<String>(
                        underline: Text(''),
                        hint: const Text('Type'),
                        icon: const Icon(Icons.arrow_downward),
                        items: const [
                          DropdownMenuItem(
                              value: 'Checkbox', child: Text('Checkbox')),
                          DropdownMenuItem(
                              value: 'Dropdown', child: Text('Dropdown'))
                        ],
                        onChanged: (val) {
                          setState(() {
                            inptype = val!;
                          });
                        }),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                if (inptype != "")
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: oplist
                            .map((e) => Container(
                                  width: 300,
                                  child: Card(
                                    child: ListTile(
                                      trailing: IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            oplist.removeAt(oplist.indexOf(e));
                                          });
                                        },
                                      ),
                                      leading: inptype == "Checkbox"
                                          ? Icon(Icons
                                              .check_box_outline_blank_outlined)
                                          : Text(
                                              (oplist.indexOf(e) + 1)
                                                      .toString() +
                                                  ".",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                      title: TextFormField(
                                        onSaved: (val) {
                                          setState(() {
                                            optex ??= [];
                                            optex!.add(val!);
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: e.optiontext),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              oplist.add(Option('Option', oplist.length));
                              // print(oplist[3].optiontext);
                            });
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                        color: Colors.black,
                        onPressed: () {
                          _formkey.currentState!.save();
                          List<Option> awplist = [];
                          for (int i = 0; i < optex!.length; i++) {
                            awplist.add(Option(optex![i], i));
                          }
                          var subq = Question(finqtext, inptype, awplist);
                          Provider.of<Questions>(context, listen: false)
                              .submitquestion(subq, p);
                          optex = [];
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        )),
                    IconButton(
                        onPressed: () {
                          Provider.of<Questions>(context, listen: false)
                              .deletequestion(p);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
