import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';

/// Branded loading screen shown while the initial session is resolved from
/// secure storage. The router redirects away from here once auth state settles.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: MulearnGradients.trusty),
        alignment: Alignment.center,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'μLearn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
