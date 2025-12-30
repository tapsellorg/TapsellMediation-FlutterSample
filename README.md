## Getting Started

[![badge](https://img.shields.io/pub/v/tapsell_mediation.svg)](https://pub.dev/packages/tapsell_mediation)

Within the android folder of of your Flutter project, open the `app/build.gradle` file and add
the following Tapsell key with the ID from the Tapsell console:

```groovy
manifestPlaceholders = [
        TapsellMediationAppKey   : "xxxxxxxxxxxxxxxxxxxxxxxx"
]
```

## Admob

Within the android folder of of your Flutter project, open the `app/build.gradle` file and add
the following Admob key with the ID from the Tapsell console:

```groovy
manifestPlaceholders = [
        TapsellMediationAdmobAdapterSignature: "ca-app-pub-xxxxxxxx~xxxxxxxx"
]
```
