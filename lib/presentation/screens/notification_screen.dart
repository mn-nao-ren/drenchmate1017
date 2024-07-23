import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/services/advanced_notice_logic.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:drenchmate_2024/presentation/components/username.dart';
import '../../business_logic/models/advanced_notice.dart';
import '../../business_logic/state/navbar_state.dart';
import 'dashboard_view.dart';

class NotificationScreen extends StatefulWidget {
  static String id = 'notification_screen';

  const NotificationScreen({super.key});
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notices = [];


  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index != 1) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        Provider.of<NavbarState>(context, listen: false).setIndex(0);
        Navigator.pushReplacementNamed(context, DashboardScreen.id);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Welcome back 👋',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Center(child: UserProfile()),
            ],
          ),
          titleTextStyle: GoogleFonts.epilogue(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.blueGrey.shade300,
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
              Expanded(child: Consumer<NoticeHandler>(
                  builder: (context, noticeHandler, child) {
                return ListView.builder(
                    itemCount: noticeHandler.notices.length,
                    itemBuilder: (context, index) {
                      return AdvancedNotice(
                        mobName: noticeHandler.notices[index]['mobName'],
                        paddockId: noticeHandler.notices[index]['paddockId'],
                        mobNumber: noticeHandler.notices[index]['mobNumber'],
                        timestamp: noticeHandler.notices[index]['timestamp'],
                        onAcknowledge: () {
                          noticeHandler.acknowledgeNotice(index);
                        }
                      );
                    });
              })),
            ],
          ),
        ),
        bottomNavigationBar: const MyNavigationBar(),
      ),
    );
  }


}

