
class DrenchSchedule {
  DateTime currentDate;
  DateTime lastDrenchDate;
  int effectivePeriodDays;
  int fecalEggCount;
  String weatherConditions;

  DrenchSchedule({
    required this.currentDate,
    required this.lastDrenchDate,
    required this.effectivePeriodDays,
    required this.fecalEggCount,
    required this.weatherConditions,
  });


  DateTime determineNextDrenchDate() {
    final daysSinceLastDrench = currentDate.difference(lastDrenchDate).inDays;

    final reInfectionRisk = ( (weatherConditions == 'warm_humid') && (fecalEggCount > 0) ) ? 'high' : 'low';

    // double check units of measurement for fecalEggThreshold
    const fecalEggThreshold = 200;

    final nextDrenchNeeded = fecalEggCount > fecalEggThreshold;

    final drenchEffective = (daysSinceLastDrench <= effectivePeriodDays);

    if (nextDrenchNeeded || !drenchEffective || reInfectionRisk == 'high') {
      return currentDate;
    } else {
      return lastDrenchDate.add(Duration(days: effectivePeriodDays));
    }
  }
}