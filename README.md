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

### TwilioFlutter features

Create a new TwilioFlutter object and initialize with required values
```dart

final TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid: '', // replace with Account SID
    authToken: '', // replace with Auth Token
    twilioNumber: '' // replace with Twilio Number(With country code)
);
```

#### Send SMS

`twilioFlutter.sendSMS()` can be used to send SMS with required message body to any mobile number by providing the number and proper country code. There is two ways to use the function:

- Use sendSMS with the recipient number and message body using the default `twilioNumber`.

```dart
await twilioFlutter.sendSMS(
toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```

- Use sendSMS with the recipient number and message body using custom `twilioNumber`.

```dart
await twilioFlutter.sendSMS(
toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world',
from:''// replace with Mobile Number(With country code)
);
```

#### View SMS List

The `twilioFlutter.getSmsList()` can be used to view all the SMS messages that was sent using the twilio account, an optional `pageSize` parameter can be passed which defaults to 20.

```dart
final data = await twilioFlutter.getSmsList({String pageSize}); //pageSize defaults to 20
```

#### View Single SMS

The `twilioFlutter.getSMS()` can be used to view the details of a single SMS message resource using the SID of the message. The SID can be found using the `twilioFlutter.getSmsList()`.

```dart

final data = await twilioFlutter.getSMS(String messageSID); //Use message sid from the individual messages.
```

#### Change Twilio Number
The `twilioFlutter.changeDefaultTwilioNumber()` can be used to update the default Twilio number that was used to initialize the `TwilioFlutter` object.

```dart
twilioFlutter.changeDefaultTwilioNumber(''); // To change the twilio number(With country code)
```

#### Send WhatsApp Message
`twilioFlutter.sendWhatsApp()` can be used to send WhatsApp message with required message body to any mobile number by providing the number and proper country code.
```dart
await twilioFlutter.sendWhatsApp(toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```

### TwilioMessagingService features
Create a new TwilioMessagingService object and initialize with required values
```dart

final TwilioMessagingService twilioMessagingService = TwilioMessagingService(
    accountSid: '', // replace with Account SID
    authToken: '', // replace with Auth Token
    messagingServiceSid: '' // replace with messaging service sid from twilio console
);
```
#### Send Scheduled SMS Message

Scheduled messages can be sent if the `sendAt` is at least 15 after the current time.

```dart
await twilioMessagingService.sendScheduledSms(
toNumber : '',
messageBody : 'hello world',
sendAt:'2024-02-18T16:18:55Z'
// Datetime has to be in the same format
);
```

### Cancel Scheduled SMS

Scheduled SMS can be cancelled using the messageSid.

```dart
await twilioMessagingService.cancelScheduledSms(messageSID:''// replace with message SID);
```

#### Send Scheduled WhatsApp Message

Scheduled messages can be sent if the `sendAt` is at least 15 after the current time.

```dart
await twilioMessagingService.sendScheduledWhatsAppMessage(
toNumber : '',
messageBody : 'hello world',
sendAt:'2024-02-18T16:18:55Z'
// Datetime has to be in the same format
);
```

#### Cancel Scheduled WhatsApp Message

Scheduled whatsapp messages can be cancelled using the messageSid.

```dart
await twilioMessagingService.cancelScheduledWhatsAppMessage(messageSID:''// replace with message SID
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