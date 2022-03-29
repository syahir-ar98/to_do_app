import 'package:flutter/material.dart';

class Tag {
  final String tagName;
  final String bgColor;
  final String textColor;

  Tag({
    required this.tagName,
    required this.bgColor,
    required this.textColor,
  });

  get getTagName => tagName;
  Color get getBgColor => Color(int.parse(bgColor));
  Color get getTextColor => Color(int.parse(textColor));

  Tag.fromJson(Map<String, dynamic> json)
      : this(
          tagName: json['tagName'],
          bgColor: json['bgColor'],
          textColor: json['textColor'],
        );

  Map<String, Object?> toJson() {
    return {
      'tagName': tagName,
      'bgColor': bgColor,
      'textColor': textColor,
    };
  }
}
