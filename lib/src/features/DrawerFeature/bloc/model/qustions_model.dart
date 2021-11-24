
class QuestionsModel {
  QuestionsModel({
    required this.id,
    required this.qustion,
    required this.answer,
  });
  late final int id;
  late final String qustion;
  late final String answer;

  QuestionsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    qustion = json['qustion'];
    answer = json['answer'];
  }
}