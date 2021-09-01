// import 'package:flutter/material.dart';
// import 'package:sats/pkg/extensions.dart';
// import 'package:sats/zold/view/reddit-page.dart';
// import 'package:sats/zold/view/settings-page.dart';
// import 'package:sats/zold/view/wallets-page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Widget> pages = [
//     HomeInfoPage(),
//     // HomeCalc(),
//     HomeWalletsPage(),
//     HomeSettingsPage(),
//   ];

//   int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext c) {
//     return Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//             unselectedItemColor: c.colours.secondary.withOpacity(0.4),
//             selectedItemColor: Color(0xFFff9500),
//             selectedLabelStyle:
//                 c.fonts.caption!.copyWith(fontWeight: FontWeight.bold),
//             unselectedLabelStyle:
//                 c.fonts.caption!.copyWith(fontWeight: FontWeight.bold),
//             currentIndex: _selectedIndex,
//             unselectedFontSize: 12,
//             backgroundColor: c.colours.background,
//             type: BottomNavigationBarType.fixed,
//             onTap: _onItemTapped,
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.campaign_outlined), label: 'Info'),
//               // BottomNavigationBarItem(
//               //     icon: Icon(Icons.swap_horiz_rounded), label: 'Rates'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.account_balance_wallet_outlined),
//                   label: 'Wallets'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.settings_outlined), label: 'Settings')
//             ]),
//         body: pages[_selectedIndex]);
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }
