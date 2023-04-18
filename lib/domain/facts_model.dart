class Facts {
  final String? text;
  final String? image;

  Facts({
    required this.text,
    required this.image,
  });

  factory Facts.fromJson(Map<String, dynamic> json) =>
      Facts(text: json['text'], image: json['image']);

  toJson() {
    return {
      'text': text,
      'image': image,
    };
  }
}
