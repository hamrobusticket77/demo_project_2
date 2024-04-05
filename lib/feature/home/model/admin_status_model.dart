class AdminStatusModel {
  final String status;
  final String scheduleStatus;
  AdminStatusModel({
    required this.status,
    required this.scheduleStatus,
  });

  AdminStatusModel copyWith({
    String? status,
    String? scheduleStatus,
  }) {
    return AdminStatusModel(
      status: status ?? this.status,
      scheduleStatus: scheduleStatus ?? this.scheduleStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'scheduleStatus': scheduleStatus,
    };
  }

  factory AdminStatusModel.fromMap(Map<String, dynamic> map) {
    return AdminStatusModel(
      status: map['status'] ?? "",
      scheduleStatus: map['scheduleStatus'] ?? "",
    );
  }
}
