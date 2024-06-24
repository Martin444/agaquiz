class AnswerModel {
  int id;
  String value;

  AnswerModel({
    required this.id,
    required this.value,
  });

  // Método para convertir un mapa (JSON) en una instancia de AnswerModel.
  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] as int,
      value: json['value'] as String,
    );
  }

  // Método para convertir una instancia de AnswerModel en un mapa (JSON).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}
