class CustomDate {
  final DateTime? ad;
  final String? bs;
  CustomDate({
    this.ad,
    this.bs,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'AD': ad?.toIso8601String(),
      'BS': bs,
    };
  }

  factory CustomDate.fromJson(Map<String, dynamic> json) {
    return CustomDate(
      ad: json['AD'] != null ? DateTime.tryParse(json['AD']) : null,
      bs: json['BS'],
    );
  }
}
