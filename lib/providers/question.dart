import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Option {
  late final String optiontext;
  final int index;

  Map toJson() {
    return {"optiontext": optiontext, "index": index};
  }

  Option(this.optiontext, this.index);
}

class Question {
  late final String questiontext;
  late final String questiontype;
  late final List<Option> options;
  Map toJson() {
    List<Map>? ops = this.options != null
        ? this.options.map((e) => e.toJson()).toList()
        : null;
    return {
      "questiontext": questiontext,
      "questiontype": questiontype,
      "options": ops
    };
  }

  Question(this.questiontext, this.questiontype, this.options);
}

class Questions with ChangeNotifier {
  List<Question> _questions = [];
  final String id;
  List<Question> get questions {
    return [..._questions];
  }

  void addquestion(String qtext, String qtype, List<Option> ops) {
    _questions.add(Question(qtext, qtype, ops));
    notifyListeners();
  }

  void submitquestion(Question receivedobj, int idx) {
    _questions[idx] = receivedobj;
    notifyListeners();
  }

  void display() async {
    for (int i = 0; i < _questions.length; i++) {
      print("Question ${i + 1}");
      print("Questiontext : " + _questions[i].questiontext);
      print("Question Type : " + _questions[i].questiontype);
      List<Option> opt = _questions[i].options;
      for (int j = 0; j < opt.length; j++) {
        print("Option ${j + 1} : " + opt[j].optiontext);
      }
      print("************************************");
    }
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    String jsonqs = jsonEncode(_questions);
    var url = Uri.http('192.168.1.74:3000', '/postform');
    var response = await http.post(url, body: jsonqs, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void deletequestion(int idx) {
    _questions.removeAt(idx);
    notifyListeners();
  }

  Questions(this._questions, this.id);
}
