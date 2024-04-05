class DepartementModel {
  final String id;
  final String createdAt;
  final String title;
  DepartementModel({
    required this.id,
    required this.createdAt,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
    };
  }

  factory DepartementModel.fromMap(Map<String, dynamic> map) {
    return DepartementModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
    );
  }

  DepartementModel copyWith({
    String? id,
    String? createdAt,
    String? title,
  }) {
    return DepartementModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
    );
  }

  @override
  String toString() =>
      'DepartementModel(id: $id, createdAt: $createdAt, title: $title)';

  @override
  bool operator ==(covariant DepartementModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ title.hashCode;
}
