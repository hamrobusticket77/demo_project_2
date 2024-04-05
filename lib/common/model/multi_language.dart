import 'package:hive_flutter/hive_flutter.dart';

part 'multi_language.g.dart';

@HiveType(typeId: 10)
class MultiLanguage {
  @HiveField(0)
  final String? en;
  @HiveField(1)
  final String? ne;
  MultiLanguage({
    required this.en,
    required this.ne,
  });

  MultiLanguage copyWith({
    String? en,
    String? ne,
  }) {
    return MultiLanguage(
      en: en ?? this.en,
      ne: ne ?? this.ne,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'en': en,
      'ne': ne,
    };
  }

  factory MultiLanguage.fromJson(Map<String, dynamic> json) {
    return MultiLanguage(
      en: json['en'] ?? "",
      ne: json['ne'] ?? "",
    );
  }

  factory MultiLanguage.initial() {
    return MultiLanguage(en: "", ne: "");
  }

  factory MultiLanguage.dummy() {
    return MultiLanguage(en: "Nameenglish", ne: "nepali");
  }
}
