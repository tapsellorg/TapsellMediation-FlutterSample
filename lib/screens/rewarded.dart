import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tapsell_mediation_example/ad/tapsell_mediation_keys.dart';
import 'package:tapsell_mediation/tapsell.dart';

class Rewarded extends StatefulWidget {
  const Rewarded({super.key});

  @override
  State<Rewarded> createState() => _RewardedState();
}

class _RewardedState extends State<Rewarded> {
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

  Future<void> requestRewardedAd() async {
    try {
      _adId = await Tapsell.requestRewardedAd(TapsellMediationKeys.rewarded) ??
          'Unknown ad id';
    } on PlatformException catch (e) {
      _adId = 'Failed to request ad. Error: ${e.message}';
    }

    addLog(_adId);
  }

  Future<void> showRewardedAd() async {
    Tapsell.showRewardedAd(_adId, onAdImpression: () {
      addLog('onAdImpression');
    }, onAdClicked: () {
      addLog('onAdClicked');
    }, onAdRewarded: () {
      addLog('onAdRewarded');
    }, onAdClosed: (ShowCompletionState completionState) {
      addLog('onAdClosed: $completionState');
    }, onAdFailed: (String message) {
      addLog('onAdFailed: $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewarded Ad'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: requestRewardedAd,
              child: const Text('Request Ad'),
            ),
            ElevatedButton(
              onPressed: showRewardedAd,
              child: const Text('Show Ad'),
            ),
            Text(_log),
          ],
        ),
      ),
    );
  }
}
