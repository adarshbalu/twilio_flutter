# Twilio Flutter

A Dart package for both android and iOS which helps developers with Twilio API services.
This Dart Package can be integrated into any Flutter application to make use of Twilio API.

## Features

* Send SMS programmatically
* Get all SMS related to a Twilio account
* Get more info on each SMS sent from a Twilio account
* Send WhatsApp messages programmatically
* Send Scheduled SMS
* Cancel Scheduled SMS
* Send Scheduled WhatsApp message
* Cancel Scheduled WhatsApp Message

## Getting Started

Check out our comprehensive [Example](https://github.com/adarshbalu/twilio_flutter/blob/master/example/lib/main.dart)
provided with this plugin.

To use this package :

- add the dependency to your pubspec.yaml file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  twilio_flutter: ^0.4.0
```

## How to use

Please find the following values from [Twilio Console](https://console.twilio.com/):

- accountSid
- Twilio Number
- Auth Token
- Messaging Service Sid (Optional, required for features like scheduled messages)

### Create a new Object and Initialize with values

```dart

final TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid: '', // replace with Account SID
    authToken: '', // replace with Auth Token
    twilioNumber: '', // replace with Twilio Number(With country code)
    messagingServiceSid: '' // optional replace with messaging service sid, required for features like scheduled sms
);
```

### Send SMS

Use sendSMS with the recipient number and message body.

```dart
await
twilioFlutter.sendSMS
(
toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```

### View SMS List

```dart

final data = await
twilioFlutter.getSmsList
({String pageSize}); //Returns list of SMS , pageSize defaults to 20
```

### View Single SMS

```dart

final data = await
twilioFlutter.getSMS
(
String
messageSID
); //Use message sid from the individual messages.
```

### Change Twilio Number

```dart
twilioFlutter.changeTwilioNumber
(''
); // To change the twilio number(With country code)
```

### Send WhatsApp Message

```dart
await
twilioFlutter.sendWhatsApp
(
toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```

### Send Scheduled SMS Message

Scheduled messages can be sent if the `sendAt` is at least 15 after the current time.

```dart
await
twilioFlutter.sendScheduledSms
(
toNumber : '',
messageBody : 'hello world',
sendAt
    :
'
2024-02-18T16:18
:
55
Z
'
// Datetime has to be in the same format
);
```

### Cancel Scheduled SMS

Scheduled SMS can be cancelled using the messageSid.

```dart
await
twilioFlutter.cancelScheduledSms
(
messageSID
:
'
'
);
```

### Send Scheduled WhatsApp Message

Scheduled messages can be sent if the `sendAt` is at least 15 after the current time.

```dart
await
twilioFlutter.sendScheduledWhatsAppMessage
(
toNumber : '',
messageBody : 'hello world',
sendAt
    :
'
2024-02-18T16:18
:
55
Z
'
// Datetime has to be in the same format
);
```

### Cancel Scheduled WhatsApp Message

Scheduled whatsapp messages can be cancelled using the messageSid.

```dart
await
twilioFlutter.cancelScheduledWhatsAppMessage
(
messageSID
:
'
'
);
```

## Future Features

- [x] Cancel Scheduled Messages
- [ ] Email Sending Support
- [ ] Update a Message resource
- [ ] Delete a Message resource
- [ ] Alphanumeric Sender IDs in Messaging Services
- [ ] More Support for Messaging Service
- [ ] Send message through Facebook Messenger

## Supported Platforms

* Android
* iOS
* Web
* MacOs
* Windows
* Linux

## Useful articles

- [https://www.dhiwise.com/post/twilio-flutter-sdk-for-beginners-enhance-flutter-development](https://www.dhiwise.com/post/twilio-flutter-sdk-for-beginners-enhance-flutter-development)
- [https://levelup.gitconnected.com/twilio-text-messages-with-flutter-fe63f41eebe9https://community.flutterflow.io/c/community-custom-widgets/post/send-an-sms-with-twilio-4ihPgc6fW0FwWtC](https://levelup.gitconnected.com/twilio-text-messages-with-flutter-fe63f41eebe9https://community.flutterflow.io/c/community-custom-widgets/post/send-an-sms-with-twilio-4ihPgc6fW0FwWtC)

## Issues

Please file any issues, bugs or feature requests as an issue on
our [GitHub](https://github.com/adarshbalu/twilio_flutter/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new
feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us
your [pull request](https://github.com/adarshbalu/twilio_flutter/pulls).

## Author

This Twilio Flutter plugin for Flutter is developed by [Adarsh Balachandran](https://github.com/adarshbalu).