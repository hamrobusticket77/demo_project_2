import 'package:timeago/timeago.dart' as timeago;

class OldMessage {
  final String createdAt;
  final String id;
  final bool isFarmer;
  final String updateAt;
  final String message;
  OldMessage({
    required this.createdAt,
    required this.id,
    required this.isFarmer,
    required this.updateAt,
    required this.message,
  });

  OldMessage copyWith({
    String? createdAt,
    String? id,
    bool? isFarmer,
    String? updateAt,
    String? message,
  }) {
    return OldMessage(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      isFarmer: isFarmer ?? this.isFarmer,
      updateAt: updateAt ?? this.updateAt,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'id': id,
      'isFarmer': isFarmer,
      'updateAt': updateAt,
      'message': message,
    };
  }

  factory OldMessage.fromMap(Map<String, dynamic> map) {
    return OldMessage(
      createdAt: map['createdAt'] ?? "",
      id: map['id'] ?? "",
      isFarmer: map['isFarmer'] ?? false,
      updateAt: map['updateAt'] ?? "",
      message: map['message'] ?? "",
    );
  }

  @override
  bool operator ==(covariant OldMessage other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.id == id &&
        other.isFarmer == isFarmer &&
        other.updateAt == updateAt &&
        other.message == message;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        id.hashCode ^
        isFarmer.hashCode ^
        updateAt.hashCode ^
        message.hashCode;
  }

  String get getTime {
    return timeago.format(DateTime.tryParse(createdAt) ?? DateTime.now());
  }
}
