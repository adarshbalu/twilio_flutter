# Twilio Flutter 

A Flutter package for both android and iOS which helps developers with Twilio API services.

## Features

* Send SMS programmatically;
* Get all SMS related to a Twilio account;
* Get more info on each SMS sent from a Twilio account;
* Send WhatsApp messages programmatically;


## Getting Started

Check out our comprehensive [Example](https://github.com/adarshbalu/twilio_flutter/blob/master/example/lib/main.dart) provided with this plugin.

To use this package :

- add the dependency to your pubspec.yaml file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  twilio_flutter: ^0.0.9
```

### How to use


#### Create a new Object
```dart
TwilioFlutter twilioFlutter; 
```

#### Initialize with values
```dart
twilioFlutter = TwilioFlutter(
    accountSid : '*************************', // replace *** with Account SID
    authToken : 'xxxxxxxxxxxxxxxxxx',  // replace xxx with Auth Token
    twilioNumber : '+...............'  // replace .... with Twilio Number
    );
```
#### Send SMS
```dart
twilioFlutter.sendSMS(
   toNumber : '+................', 
   messageBody : 'hello world'); 
   //Use sendSMS with the recipient number and message body.
```

#### View SMS List
```dart
SentSmsData data= await twilioFlutter.getSmsList({String pageSize}); //Returns list of SMS , pageSize defaults to 20
```

#### View Single SMS
```dart
Message data= await twilioFlutter.getSMS(String messageSID); //Use message sid from the individual messages.
```

#### Change Twilio Number
```dart
twilioFlutter.changeTwilioNumber('+.........'); // To change the twilio number
```

##### Send WhatsApp Message (Experimental)
```dart
twilioFlutter.sendWhatsApp(toNumber : '+................',
 messageBody : 'hello world');
```

## Supported Platforms

* Android
* iOS
* Web
* MacOs
* Windows
* Linux


## Useful articles

- [https://medium.com/flutterdevs/sms-using-twilio-in-flutter-f7240c94039a](https://medium.com/flutterdevs/sms-using-twilio-in-flutter-f7240c94039a)

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/adarshbalu/twilio_flutter/issues) page. Commercial support is available, you can contact us at <adarshlp98@gmail.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/adarshbalu/twilio_flutter/pulls).

## Author

This Twilio Flutter plugin for Flutter is developed by [Adarsh Balachandran](https://github.com/adarshbalu).