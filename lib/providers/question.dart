import 'package:flutter/cupertino.dart';

class Option {
  late final String optiontext;
  final int index;

  Option(this.optiontext, this.index);
}

class Question {
  late final String questiontext;
  late final String questiontype;
  late final List<Option> options;

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

  void display() {
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
  }

  void deletequestion(int idx) {
    _questions.removeAt(idx);
    notifyListeners();
  }

  Questions(this._questions, this.id);
}
