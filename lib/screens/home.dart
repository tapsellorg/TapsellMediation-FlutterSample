import 'package:flutter/material.dart';
import 'package:flutter_tapsell_mediation_example/navigation/routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tapsell Mediation Flutter Sample"),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Rewarded"),
              onPressed: () => Navigator.pushNamed(context, NavRoutes.rewarded),
            ),
            ElevatedButton(
              child: const Text("Interstitial"),
              onPressed: () {
                Navigator.pushNamed(context, NavRoutes.interstitial);
              },
            ),
            ElevatedButton(
              child: const Text("Banner"),
              onPressed: () {
                Navigator.pushNamed(context, NavRoutes.banner);
              },
            ),
            ElevatedButton(
              child: const Text("Native"),
              onPressed: () {
                Navigator.pushNamed(context, NavRoutes.native);
              },
            )
          ],
        ),
      ),
    );
  }
}
