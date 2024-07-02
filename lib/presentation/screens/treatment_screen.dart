// import 'package:flutter/material.dart';
// import 'treatment_log_screen.dart';
// import 'add_treatment_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class TreatmentScreen extends StatelessWidget {
//   const TreatmentScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'DrenchMate 2024',
//           style: GoogleFonts.dangrek(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue.shade900,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.lightBlueAccent),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.lightBlueAccent),
//             tooltip: 'Notifications',
//             onPressed: () {
//               // Add functionality here
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage('assets/icon/icon.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Menu',
//                     style: GoogleFonts.lato(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: Text('Home', style: GoogleFonts.lato()),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.book),
//               title: Text('Treatment Log', style: GoogleFonts.lato()),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const TreatmentLogScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.add),
//               title: Text('Add Treatment', style: GoogleFonts.lato()),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const AddTreatmentScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//               stops: [
//                 0.2, 0.5, 0.8, 0.7
//               ],
//               colors: [
//                 Color(0xFFE3F2FD), // Colors.blue[50]
//                 Color(0xFFBBDEFB), // Colors.blue[100]
//                 Color(0xFF90CAF9), // Colors.blue[200]
//                 Color(0xFF64B5F6), // Colors.blue[300]
//               ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Welcome to DrenchMate 2024',
//                 style: GoogleFonts.lobster(
//                   fontSize: 26,
//                   color: const Color(0xFF00008B),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15.0),
//                 child: Image.asset(
//                   'assets/images/drench.png',
//                   width: 160,
//                   height: 160,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.library_books, color: Color(0xFF00008B)),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const TreatmentLogScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     side: const BorderSide(color: Colors.blue),
//                   ),
//                   textStyle: GoogleFonts.roboto(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 label: const Text('View Treatment Log', style: TextStyle(color: Color(0xFF00008B)),),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.medication, color: Color(0xFF00008B)),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const AddTreatmentScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     side: const BorderSide(color: Colors.blue),
//                   ),
//                   textStyle: GoogleFonts.roboto(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 label: const Text('Add New Treatment', style: TextStyle(color: Color(0xFF00008B))),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
