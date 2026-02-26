import 'package:firebase_core/firebase_core.dart';
import 'package:farmer_app/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// SCREEN IMPORTS
import 'package:farmer_app/Login/entry_screen.dart';
import 'package:farmer_app/Login/login_screen.dart';
import 'package:farmer_app/Login/signup_screen.dart';
import 'package:farmer_app/screen/home_screen.dart';
import 'package:farmer_app/screen/home/appbar/profile/profile.dart';
import 'package:farmer_app/screen/home/appbar/profile/profile_edit.dart';
import 'package:farmer_app/screen/home/appbar/notification.dart';
import 'package:farmer_app/screen/home/appbar/location.dart';
import 'package:farmer_app/screen/home/appbar/language.dart';
import 'package:farmer_app/screen/home/weather/weather.dart';
import 'package:farmer_app/screen/home/crop/add_crop.dart';
import 'package:farmer_app/screen/home/crop/add_new_crop.dart';
import 'package:farmer_app/screen/home/crop/timeline.dart';
import 'package:farmer_app/screen/home/crop/financial.dart';
import 'package:farmer_app/screen/home/crop/pest.dart';
import 'package:farmer_app/screen/home/irrigation/irrigation_page.dart';
import 'package:farmer_app/screen/home/equipment/my_equipment.dart';
import 'package:farmer_app/screen/home/equipment/equipment_needed.dart';
import 'package:farmer_app/screen/home/equipment/add_equipment.dart';
import 'package:farmer_app/screen/home/settings/settings_page.dart';
import 'package:farmer_app/screen/home/settings/help_page.dart';
import 'package:farmer_app/screen/home/settings/terms_page.dart';
import 'package:farmer_app/screen/home/settings/privacy_page.dart';
import 'package:farmer_app/screen/home/appbar/profile/notification/all_notification.dart';
import 'package:farmer_app/screen/home/equipment/tractor_screen.dart';
import 'package:farmer_app/screen/home/equipment/sprayer_screen.dart';
import 'package:farmer_app/screen/home/equipment/seedrill_screen.dart';
import 'package:farmer_app/screen/home/equipment/rotavator_screen.dart';
import 'package:farmer_app/screen/home/equipment/watertank_screen.dart';
import 'package:farmer_app/screen/home/equipment/history_screen.dart';
import 'package:farmer_app/screen/home/equipment/equipment_booking.dart';
import 'package:farmer_app/screen/home/community/community.dart';
import 'package:farmer_app/screen/home/my_land/my_land.dart';

import 'package:farmer_app/screen/home/my_land/gps_tracker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF2E7D32),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmer App',
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ta'),
        Locale('hi'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen1(),
      routes: {
        '/entry': (context) => const FarmerScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/profile_edit': (context) => const ProfileEditScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/notification_detail': (context) => const NotificationPage(),
        '/my_land': (context) => const MyLandPage(),
        '/gps_tracker': (context) => const GPSTrackerPage(),
        '/location': (context) => const LocationPage(),
        '/language': (context) => const LanguagePage(),
        '/weather': (context) => const WeatherPage(),
        '/add_crop': (context) => const AddCropPage(),
        '/add_new_crop': (context) => const AddNewCropPage(),
        '/timeline': (context) => const TimelinePage(),
        '/financial': (context) => const FinancialPage(),
        '/pest': (context) => const PestPage(),
        '/irrigation': (context) => const IrrigationPage(),
        '/equipment': (context) => const MyEquipmentPage(),
        '/equipment_needed': (context) => const EquipmentNeededPage(),
        '/add_equipment': (context) => const AddEquipmentPage(),
        '/tractor': (context) => const TractorScreen(),
        '/sprayer': (context) => const SprayerScreen(),
        '/seedrill': (context) => const SeedDrillScreen(),
        '/rotavator': (context) => const RotavatorScreen(),
        '/watertank': (context) => const WaterTankScreen(),
        '/history': (context) => const HistoryScreen(),
        '/booking': (context) => const EquipmentBookingPage(),
        '/settings': (context) => const Settings(),
        '/all_notification': (context) => const NotificationScreen(),
        '/community': (context) => const CommunityPage(),
        '/help': (context) => const HelpCenter(),
        '/terms': (context) => const Terms(),
        '/privacy': (context) => const Privacy(),
      },
    );
  }
}
