class APODModel {
  APODModel({
    required this.title,
    required this.imageURL,
    required this.explanation,
    required this.date,
    required this.copyright,
    required this.mediaType,
  });
  final String title;
  final String imageURL;
  final String explanation;
  final String date;
  final String copyright;
  final String mediaType;

  factory APODModel.fromJSON(Map<String, dynamic> json) {
    return APODModel(
      title: json['title'],
      imageURL: json['url'],
      explanation: json['explanation'],
      date: json['date'],
      copyright: json['copyright'],
      mediaType: json['media_type'],
    );
  }
}
