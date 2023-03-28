import 'package:fen_ghadi/pages/home_page.dart';
import 'package:fen_ghadi/pages/preferences_page.dart';
import 'package:fen_ghadi/pages/profile_page.dart';
import 'package:fen_ghadi/utils/style.dart';
import 'package:flutter/material.dart';
import 'utils/fen_ghadi_icons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //preferences
  bool isTaxiChecked = true;
  bool isBusChecked = true;
  bool isTramChecked = true;

  // Current Page Index
  int pageIndex = 2;

  //Menu Pages
  // final List<Widget> pages = const [
  //   ProfilePage(),
  //   HomePage(),
  //   PreferencesPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: materialPrimaryColor,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Fen Ghadi"),
        ),
        body: pageIndex == 0
            ? const ProfilePage()
            : pageIndex == 1
                ? HomePage(
                    isBusChecked: isBusChecked,
                    isTaxiChecked: isTaxiChecked,
                    isTramChecked: isTramChecked,
                  )
                : PreferencesPage(
                    isBusChecked: isBusChecked,
                    isTaxiChecked: isTaxiChecked,
                    isTramChecked: isTramChecked,
                    onPreferenceChanged: (bool bus, bool taxi, bool tram) {
                      setState(() {
                        isBusChecked = bus;
                        isTaxiChecked = taxi;
                        isTramChecked = tram;
                      });
                    },
                  ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.0, top: 3.0),
                child: Icon(FenGhadiIcons.person),
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.0, top: 3.0),
                child: Icon(FenGhadiIcons.map),
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 6.0, top: 3.0),
                child: Icon(
                  FenGhadiIcons.preferences,
                ),
              ),
              label: 'Preferences',
            ),
          ],
        ),
      ),
    );
  }
}
