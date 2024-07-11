import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:drenchmate_2024/data/advanced_notice_repo.dart';
import 'package:drenchmate_2024/business_logic/models/weather_data.dart';

part 'advanced_notice_state.dart';

class AdvancedNoticeCubit extends Cubit<AdvancedNoticeState> {
  final AdvancedNoticeRepository repository;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AdvancedNoticeCubit(this.repository, this.flutterLocalNotificationsPlugin) : super(AdvancedNoticeInitial());

  void calculateNextDrenchDate() async {
    try {
      final lastDrenchDate = await repository.getLastDrenchDate();
      final eggCount = await repository.getEggCount();
      final weatherData = await repository.getWeatherData();

      print('Debug: Last Drench Date: $lastDrenchDate');
      print('Debug: Egg Count: $eggCount');
      print('Debug: Weather Data: $weatherData');

      final nextDrenchDate = _calculateNextDrenchDate(
        lastDrenchDate: lastDrenchDate,
        eggCount: eggCount,
        weatherData: weatherData,
      );

      emit(NextDrenchDateCalculated(nextDrenchDate));
      _sendNotification(nextDrenchDate);
    } catch (e) {
      print('Error: Failed to calculate next drench date - $e');
      emit(AdvancedNoticeError('Failed to calculate next drench date'));
    }
  }

  DateTime _calculateNextDrenchDate({
    required DateTime lastDrenchDate,
    required int eggCount,
    required WeatherData weatherData,
  }) {
    // Add algorithm logic to compute next drench date
    DateTime nextDrenchDate = lastDrenchDate.add(Duration(days: 21)); // Placeholder logic
    return nextDrenchDate;
  }

  void _sendNotification(DateTime nextDrenchDate) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Next Drench Date',
      'Your next drench date is ${nextDrenchDate.toString()}',
      platformChannelSpecifics,
      payload: 'item x',
    );

    print('Debug: Notification sent for next drench date: $nextDrenchDate');
  }
}
