class PhoneBookModel {
  String id;

  String title;
  String createdAt;
  PhoneBookModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'createdAt': createdAt,
    };
  }

  factory PhoneBookModel.fromMap(Map<String, dynamic> map) {
    return PhoneBookModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      createdAt: map['createdAt'] ?? "",
    );
  }

  PhoneBookModel copyWith({
    String? id,
    String? title,
    String? createdAt,
  }) {
    return PhoneBookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'PhoneBookModel(id: $id, title: $title, createdAt: $createdAt)';

  @override
  bool operator ==(covariant PhoneBookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ createdAt.hashCode;
}
