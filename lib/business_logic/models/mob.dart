class Mob {
  late int mobId;
  late int propertyId;
  late String propertyAddress;
  late int paddockId;
  late String mobName;
  late int numberOfSheep;
  late DateTime createdAt;
  late String deductionReason;
  late DateTime deductionDate;

  Mob({
    required this.mobId,
    required this.propertyId,
    required this.propertyAddress,
    required this.paddockId,
    required this.mobName,
    required this.numberOfSheep,
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
      'numberOfSheep': numberOfSheep,
      'createdAt': createdAt,
      'deductionReason': deductionReason,
      'deductionDate': deductionDate,

    };
  }

  factory Mob.fromMap(Map<String, dynamic> map) {
    return Mob(
      mobId: map['mobId'],
      propertyId: map['propertyId'],
      propertyAddress: map['propertyAddress'],
      paddockId: map['paddockId'],
      mobName: map['mobName'],
      numberOfSheep: map['numberOfSheep'],
      createdAt: map['createdAt'],
      deductionReason: map['deductionReason'],
      deductionDate: map['deductionDate'],
    );
  }

  @override
  String toString() {
    return 'Mob{mobId: $mobId, propertyId: $propertyId, '
        'propertyAddress: $propertyAddress, paddockId: $paddockId, '
        'mobName: $mobName, numberOfSheep: $numberOfSheep, '
        'createdAt: $createdAt, deductionReason: $deductionReason, '
        'deductionDate: $deductionDate}';
  }

}