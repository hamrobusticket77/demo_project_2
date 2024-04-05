class ApplyDemandParam {
  final String id;
  final int? appliedQuantity;
  ApplyDemandParam({
    required this.id,
    this.appliedQuantity,
  });

  ApplyDemandParam copyWith({
    String? id,
    int? appliedQuantity,
  }) {
    return ApplyDemandParam(
      id: id ?? this.id,
      appliedQuantity: appliedQuantity ?? this.appliedQuantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'appliedQuantity': appliedQuantity,
    };
  }

  factory ApplyDemandParam.fromMap(Map<String, dynamic> map) {
    return ApplyDemandParam(
      id: map['id'] ?? "",
      appliedQuantity: map['appliedQuantity'],
    );
  }

  @override
  bool operator ==(covariant ApplyDemandParam other) {
    if (identical(this, other)) return true;

    return other.id == id && other.appliedQuantity == appliedQuantity;
  }

  @override
  int get hashCode => id.hashCode ^ appliedQuantity.hashCode;
}
