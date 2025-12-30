import 'package:flutter/material.dart';
import 'package:flutter_tapsell_mediation_example/ad/tapsell_mediation_keys.dart';
import 'package:tapsell_mediation/tapsell.dart';
import 'package:tapsell_mediation_legacy/tapsell_mediation_legacy.dart';

class Native extends StatefulWidget {
  const Native({super.key});

  @override
  State<Native> createState() => _NativeState();
}

class _NativeState extends State<Native> {
  String _log = '';
  String _adId = '';

  NativeAdDispatch adData = NativeAdDispatch();

  @override
  void initState() {
    super.initState();
    TapsellLegacyAdapter.initialize();
  }

  void addLog(String message) {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _log = '$message\n$_log';
    });
  }

  void requestNativeAd() {
    Tapsell.requestNativeAd(TapsellMediationKeys.native).then((adId) {
      _adId = adId!;
      addLog('onSuccess: $adId');
    }).catchError((error) {
      addLog('onError: $error');
    });
  }

  void showNativeAd() {
    Tapsell.showNativeAd(_adId, adData, onAdImpression: () {
      addLog('onAdImpression');
    }, onAdClicked: () {
      addLog('onAdClicked');
    }, onAdFailed: (String message) {
      addLog('onAdFailed: $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Ad'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: requestNativeAd,
              child: const Text('Request Ad'),
            ),
            ElevatedButton(
              onPressed: showNativeAd,
              child: const Text('Show Ad'),
            ),
            adData.isValid()
                ? NativeAdWidget(
                    adId: _adId,
                    title: adData.title,
                    description: adData.description,
                    logo: adData.logo,
                    callToActionText: adData.callToActionText,
                    bannerImageUrl: adData.bannerImageUrl,
                  )
                : const SizedBox(),
            Text(_log, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Tapsell.destroyNativeAd(_adId);
  }
}

class NativeAdWidget extends StatelessWidget {
  const NativeAdWidget(
      {super.key,
      required this.adId,
      required this.title,
      required this.description,
      required this.logo,
      required this.bannerImageUrl,
      required this.callToActionText});

  final String adId;
  final String? title;
  final String? description;
  final String? logo;
  final String? bannerImageUrl;
  final String? callToActionText;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title ?? "Tapsell Title",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Image.network(logo ?? "", width: 56, height: 56),
            ],
          ),
          Text(description ?? "Tapsell Description",
              style: const TextStyle(fontSize: 16)),
          Image.network(bannerImageUrl ?? "", fit: BoxFit.cover),
          const SizedBox(height: 8),
          TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.only(left: 32.0, right: 32.0),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
              ),
              onPressed: () => {
                    Tapsell.clickNativeAd(adId),
                  },
              child: Text(callToActionText ?? "Tapsell CTA",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ],
      ),
    );
  }
}
