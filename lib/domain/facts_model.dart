class Facts {
  final String? text;

  Facts({
    required this.text,
  });

  factory Facts.fromJson(Map<String, dynamic> json) =>
      Facts(text: json['text']);

  toJson() {
    return {
      'text': text,
    };
  }
}
