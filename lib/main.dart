import 'package:airbnb_cybersoft/screens/explore/explore_screen.dart';
import 'package:airbnb_cybersoft/screens/profile/profile_screen.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const AirbnbApp());
}

class AirbnbApp extends StatefulWidget {
  const AirbnbApp({super.key});

  @override
  State<AirbnbApp> createState() => _AirbnbAppState();
}

class _AirbnbAppState extends State<AirbnbApp> {
  int _navIndex = 0;

  final pageRoutes = const [
    ExploreScreen(),
    null,
    null,
    null,
    ProfileScreen(maNguoiDung: 73395),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
      ),
      home: Scaffold(
        body: pageRoutes[_navIndex],
        bottomNavigationBar: _navigationBar(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _navigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedItemColor: primaryColor,
      selectedFontSize: 12,
      currentIndex: _navIndex,
      items: List.generate(navBarItems.length, (index) {
        final navItem = navBarItems[index];
        return BottomNavigationBarItem(
          label: navItem['label'],
          icon: stateSvgIcon(assetName: navItem['icon'], active: false),
          activeIcon: stateSvgIcon(
            assetName: navItem['icon'],
            active: true,
            activeColor: primaryColor,
          ),
        );
      }),
      onTap: (int index) {
        setState(() {
          _navIndex = index;
        });
      },
    );
  }
}
