class Mob {
  late int mobId;
  late int propertyId;
  late String propertyAddress;
  late int paddockId;
  late String mobName;

  late DateTime createdAt;
  late String? deductionReason;
  late DateTime? deductionDate;

  Mob({
    required this.mobId,
    required this.propertyId,
    required this.propertyAddress,
    required this.paddockId,
    required this.mobName,

    required this.createdAt,
    required this.deductionReason,
    required this.deductionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'mobId': mobId,
      'propertyId': propertyId,
      'propertyAddress': propertyAddress,
      'paddockId': paddockId,
      'mobName': mobName,

      'createdAt': createdAt.toIso8601String(),
      'deductionReason': deductionReason,
      'deductionDate': deductionDate?.toIso8601String(),

    };
  }

  factory Mob.fromMap(Map<String, dynamic> map) {
    return Mob(
      mobId: map['mobId'],
      propertyId: map['propertyId'],
      propertyAddress: map['propertyAddress'],
      paddockId: map['paddockId'],
      mobName: map['mobName'],

      createdAt: DateTime.parse(map['createdAt']), // Parse ISO string to DateTime
      deductionReason: map['deductionReason'],
      deductionDate: map['deductionDate'] != null ? DateTime.parse(map['deductionDate']) : null, // Parse ISO string to DateTime
    );
  }

  @override
  String toString() {
    return 'Mob{mobId: $mobId, propertyId: $propertyId, '
        'propertyAddress: $propertyAddress, paddockId: $paddockId, '
        'mobName: $mobName, '
        'createdAt: $createdAt, deductionReason: $deductionReason, '
        'deductionDate: $deductionDate}';
  }

}