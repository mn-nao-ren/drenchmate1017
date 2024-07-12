import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:drenchmate_2024/presentation/components/today_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/username.dart';
import 'dashboard_view.dart';




class NotificationScreen extends StatefulWidget {
  static String id = 'notification_screen';

  const NotificationScreen({super.key});
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _onItemTapped(BuildContext context, int index) {
    if (index != 1) {
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) async {
        Navigator.pop(context, true);

      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
              Navigator.pushNamed(context, DashboardScreen.id);
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome back 👋',
                style: GoogleFonts.epilogue(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              const UserProfile(),
            ],
          ),

          titleTextStyle: GoogleFonts.epilogue(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: GoogleFonts.epilogue(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  /* set itemCount to accommodate flexible number of items,
                  * as many notifications as StreamBuilder will give out
                  * */
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            SizedBox(width: 8),

                            /* this date time widget needs to display the date and time
                            * at which the notification was triggered and sent out. not just today's
                            * date */
                            TodayDateWidget(),


                          ],
                        ),
                        SizedBox(height: 10),

                        /* The design of each notification is:
                        * Reasons for drenching -
                        * report days since last drenched
                        * report fecal egg count level
                        * report weather conditions: is it warm_humid or not?
                        * report re-infection risk: high or low?
                        * Last drench effective period exceeded: yes or no
                        *  */
                        Text(
                          'Average Rainfall hits limit, time to Drench.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyNavigationBar(),
      ),
    );
  }
}
