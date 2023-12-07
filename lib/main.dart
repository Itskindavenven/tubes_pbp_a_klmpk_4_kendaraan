import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/View/login/login.dart';
import 'package:pbp_widget_a_klmpk4/theme.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pbp_widget_a_klmpk4/view/onboarding.dart';
import 'package:pbp_widget_a_klmpk4/pdf/pdf_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      Device.orientation == Orientation.portrait
          ? Container(
              width: 100.w,
              height: 20.5.h,
            )
          : Container(
              width: 100.w,
              height: 12.5.h,
            );

      Device.screenType == ScreenType.tablet
          ? Container(
              width: 100.w,
              height: 20.5.h,
            )
          : Container(
              width: 100.w,
              height: 12.5.h,
            );
      return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      );
    });
  }
}

void resetNavigator() {
  navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
    builder: (context) => const LoginView(),
  ));
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onbording()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Icon(
          Icons.car_rental_outlined,
          size: 200,
          color: Colors.white,
        ),
        // Text(
        //   'CAR RENT',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 28.0,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
    );
  }
}
