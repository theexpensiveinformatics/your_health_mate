class ServiceFaqModel {
  final String question;
  final String answer;

  ServiceFaqModel({required this.question, required this.answer});

  factory ServiceFaqModel.fromMap(Map<String, dynamic> data) {
    return ServiceFaqModel(
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }
}