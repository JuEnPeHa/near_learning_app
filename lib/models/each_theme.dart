import 'package:flutter/material.dart';

class ListThemes {
  final List<EachTheme> themes;
  ListThemes({required this.themes});

  factory ListThemes.fromJson(List<dynamic> json) => ListThemes(
        themes: (json as List<dynamic>)
            .map((e) => EachTheme.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson(ListThemes instance) => <String, dynamic>{
        'themes': instance.themes.map((e) => e.toJson(e)).toList()
      };

  @override
  String toString() => 'ListThemes{themes: $themes}';
}

class EachTheme {
  final String title;
  final Color color;
  final List<String> subtitles;
  final List<String> keys;

  EachTheme({
    required this.title,
    required this.color,
    required this.subtitles,
    required this.keys,
  });

  factory EachTheme.fromJson(Map<String, dynamic> json) {
    return EachTheme(
      title: json['title'] as String,
      color: Color(int.parse(
          ((json['color'] as String).split('(0x')[1].split(')')[0]),
          radix: 16)),
      subtitles:
          (json['subtitles'] as List<dynamic>).map((e) => e as String).toList(),
      keys: (json['keys'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson(EachTheme instance) => <String, dynamic>{
        'title': instance.title,
        'color': instance.color.toString(),
        'subtitles': instance.subtitles,
        'keys': instance.keys,
        //'subtitles': instance.subtitles.toList(),
      };

  @override
  String toString() {
    return 'EachTheme{title: $title, color: $color, subtitles: $subtitles, keys: $keys}';
  }
}
