import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shutter_ease/features/Authetication/View/Splash%20Screen/splash_services.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();

    splashServices.checkUserStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    final mq = CustomMediaQuery(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/AppLogo.png',
                width: mq.getWidth(0.4),
              ),
              const CustomSizedBox(height: 0.1),
              const Text(
                "SES@MO",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                    fontFamily: 'Poppins'),
              ),
              const CustomSizedBox(height: 0.1),
              const SpinKitChasingDots(
                color: Colors.deepPurple,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
