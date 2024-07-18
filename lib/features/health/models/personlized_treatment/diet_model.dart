// diet_plan.dart
class DietPlan {
  final String diseaseName;
  final String paragraph;
  final List<String> symptoms;
  final List<String> whatToDo;
  final List<String> whatNotToDo;
  final GraphData graphData;

  DietPlan({
    required this.diseaseName,
    required this.paragraph,
    required this.symptoms,
    required this.whatToDo,
    required this.whatNotToDo,
    required this.graphData,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      diseaseName: json['diseaseName'] ?? '',
      paragraph: json['paragraph'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      whatToDo: List<String>.from(json['whatToDo'] ?? []),
      whatNotToDo: List<String>.from(json['whatNotToDo'] ?? []),
      graphData: GraphData.fromJson(json['graphData'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diseaseName': diseaseName,
      'paragraph': paragraph,
      'symptoms': symptoms,
      'whatToDo': whatToDo,
      'whatNotToDo': whatNotToDo,
      'graphData': graphData.toJson(),
    };
  }
}

class GraphData {
  final List<String> xValues;
  final List<double> yValues;

  GraphData({
    required this.xValues,
    required this.yValues,
  });

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
      xValues: List<String>.from(json['xValues'] ?? []),
      yValues: List<double>.from((json['yValues'] ?? []).map((e) => e.toDouble())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xValues': xValues,
      'yValues': yValues,
    };
  }
}
