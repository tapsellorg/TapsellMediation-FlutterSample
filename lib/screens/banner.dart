import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tapsell_mediation_example/ad/tapsell_mediation_keys.dart';
import 'package:tapsell_mediation/tapsell.dart';

class Banner extends StatefulWidget {
  const Banner({super.key});

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  String _log = '';
  String _adId = '';

  void addLog(String message) {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _log = '$message\n$_log';
    });
  }

  Future<void> requestBannerAd() async {
    try {
      _adId = await Tapsell.requestBannerAd(TapsellMediationKeys.banner,
              bannerSize: BannerSize.banner_320_90) ??
          'Unknown ad id';
    } on PlatformException catch (e) {
      _adId = 'Failed to request ad. Error: ${e.message}';
    }
    addLog(_adId);
  }

  Future<void> showBannerAd() async {
    Tapsell.showBannerAd(_adId, bannerPosition: BannerPosition.bottom,
        onAdImpression: () {
      addLog('onAdImpression');
    }, onAdClicked: () {
      addLog('onAdClicked');
    }, onAdFailed: (String message) {
      addLog('onAdFailed: $message');
    });
  }

  Future<void> destroyBannerAd() async {
    Tapsell.destroyBannerAd(_adId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner Ad'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: requestBannerAd,
              child: const Text('Request Ad'),
            ),
            ElevatedButton(
              onPressed: showBannerAd,
              child: const Text('Show Ad'),
            ),
            Text(_log),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    destroyBannerAd();
  }
}
