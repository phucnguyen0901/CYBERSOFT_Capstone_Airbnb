import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_screen.dart';
import 'package:airbnb_cybersoft/screens/profile/profile_screen.dart';
import 'package:airbnb_cybersoft/screens/profile/register_screen.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  var authProvider = AuthProvider();
  // var userProvider = UserProvider();

  final token = await getAccessToken();
  // final user = await getUserInfo();

  if (token != null) {
    authProvider.setLogin(token);
    // userProvider.loadComplete(user);
    debugPrint('AuthProvider: Login successfully');
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: authProvider)],
      child: const AirbnbApp(),
    ),
  );
}

class AirbnbApp extends StatefulWidget {
  const AirbnbApp({super.key});

  @override
  State<AirbnbApp> createState() => _AirbnbAppState();
}

class _AirbnbAppState extends State<AirbnbApp> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final pageRoutes = [
      ExploreScreen(),
      null,
      null,
      null,
      authProvider.isLogin ? ProfileScreen() : RegisterScreen(),
    ];

    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.googleSans().fontFamily,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        appBarTheme: const AppBarThemeData(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(size: 20),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
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
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
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
