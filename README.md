# Twilio Flutter

A Dart package for all platforms which helps developers with Twilio API services.
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
* Twilio verification supporting multiple channels
* Send Messenger Texts

## Getting Started

Check out our comprehensive [Example](https://github.com/adarshbalu/twilio_flutter/blob/master/example/lib/main.dart)
provided with this plugin.

To use this package :

- add the dependency to your pubspec.yaml file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  twilio_flutter:
```

## How to use

Please find the following values from [Twilio Console](https://console.twilio.com/):

- Account SID
- Twilio Number
- Auth Token
- Messaging Service SID (Optional, required for features like scheduled messages)
- Veridication service SID (Optional, required for Twilio verify feature)


## Features and service list

| Service                | Feature                           | Feature info                                  |
|------------------------|-----------------------------------|-----------------------------------------------|
| **TwilioFlutter**          | Send SMS                          | Send SMS to mobile number using Twilio number                     |
| **TwilioFlutter**          | Send WhatsApp message             | Send whatsApp message to any number  from assigned Twilio number          |
| **TwilioFlutter**          | Get SMS list                      | Get all SMS from the account                  |
| **TwilioFlutter**          | Get SMS details                   | Get all data related to a single SMS resource |
| **TwilioMessagingService** | Send scheduled SMS                | Send SMS messages according to a time set, message will be sent from the service pool or send from custom number    |
| **TwilioMessagingService** | Cancel scheduled SMS              | Cancel scheduled SMS message                  |
| **TwilioMessagingService** | Send scheduled whatsapp message   | Send WhatsApp message according to a time set, message will be sent from the service pool  or send from custom number|
| **TwilioMessagingService** | Cancel scheduled whatsapp message | Cancel a scheduled whatsapp message           |
| **TwilioMessagingService** | Send SMS                | Send SMS message using messaging service, message will be sent from the service pool or send from custom number    |
| **TwilioMessagingService** | Send whatsapp message   | Send WhatsApp message, message will be sent from the service pool or send from custom number |
| **TwilioMessenger** | Send FB messenger message   | Send FB messenger message |

---

## TwilioFlutter features

Create a new **TwilioFlutter** object and initialize with required values
```dart

final TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid: '', // replace with Account SID
    authToken: '', // replace with Auth Token
    twilioNumber: '' // replace with Twilio Number(With country code)
);
```
### SMS
The following are the SMS related features in **TwilioFlutter**.

#### Send SMS

`twilioFlutter.sendSMS()` can be used to send SMS with required message body to any mobile number by providing the number and proper country code.

| parameter   | type   | mandatory | remarks                                                                                     |
| ----------- | ------ | --------- | ------------------------------------------------------------------------------------------- |
| toNumber    | String | Yes       | The number to which the message has to sent to, should be a mobile number with country code |
| messageBody | String | Yes       | The body of the SMS message                                                                 |
| fromNumber  | String | No        | A custom fromNumber other than the one configured with TwilioFlutter object.                |


- Use sendSMS with the recipient number and message body using the default `twilioNumber`.


```dart
TwilioResponse response = await twilioFlutter.sendSMS(
toNumber : '',
messageBody : 'hello world');
```

- Use sendSMS with the recipient number and message body using custom `twilioNumber`.

```dart
TwilioResponse response = await twilioFlutter.sendSMS(
toNumber : '',
messageBody : 'hello world',
fromNumber:''
);
```

### WhatsApp
The following are the WhatsApp related features in **TwilioFlutter**.
#### Send WhatsApp Message
`twilioFlutter.sendWhatsApp()` can be used to send WhatsApp message with required message body to any mobile number by providing the number and proper country code.


```dart
TwilioResponse response = await twilioFlutter.sendWhatsApp(toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```

| parameter   | type   | mandatory | remarks                                                                                     |
| ----------- | ------ | --------- | ------------------------------------------------------------------------------------------- |
| toNumber    | String | Yes       | The number to which the message has to sent to, should be a mobile number with country code |
| messageBody | String | Yes       | The body of the message                                                                 |
| fromNumber  | String | No        | A custom fromNumber other than the one configured with TwilioFlutter object. Should be mobile number with country code.                |

### Twilio Verification
The following are the Twilio verify related features in **TwilioFlutter**.

#### Create verification service

Verification service has to be created in order to access all the features. This can be done either through the Twilio console or by using the following by providing a service name:

```dart
TwilioResponse response = await twilioFlutter.createVerificationService(serviceName:'service name');
```
This method returns `TwilioResponse` and `metadata` from TwilioResponse will have the verification service ID in the key: "**sid**". This sid should be used for the verification.

#### Send verification code

This method is used to send the verification code to the desired channel.

```dart
TwilioResponse response = await twilioFlutter.sendVerificationCode(verificationServiceId:'sid',
recipient: '',
verificationChannel: VerificationChannel.SMS
);
```
Currently supported channels are:
- SMS
- WHATSAPP
- CALL

Recipient: can be mobile number, email etc depending on channel.

#### Verify code

To verify a code use the `verify_code()` method by passing the code input.

```dart
TwilioResponse response = await twilioFlutter.verifyCode(verificationServiceId:'sid',
recipient: '',
code: ''
);
```
This method returns `TwilioResponse` and `metadata` from TwilioResponse has a
`status` key, if it is "**approved**" then the verification is successful.


### Common
The following are the common services provided by TwilioFlutter.
#### View Messages List

The `twilioFlutter.getSmsList()` can be used to view all the SMS messages that was sent using the twilio account, an optional `pageSize` parameter can be passed which defaults to 20.

```dart
final TwilioResponse response = await twilioFlutter.getSmsList({String pageSize}); //pageSize defaults to 20
```

#### View Single Message

The `twilioFlutter.getSMS()` can be used to view the details of a single SMS message resource using the SID of the message. The SID can be found using the `twilioFlutter.getSmsList()`.

```dart

final TwilioResponse response = await twilioFlutter.getSMS(String messageSID); //Use message sid from the individual messages.
```

#### Change Twilio Number
The `twilioFlutter.changeDefaultTwilioNumber()` can be used to update the default Twilio number that was used to initialize the `TwilioFlutter` object.

```dart
twilioFlutter.changeDefaultTwilioNumber(''); // To change the twilio number(With country code)
```

---

## TwilioMessagingService features
Create a new **TwilioMessagingService** object and initialize with required values
```dart

final TwilioMessagingService twilioMessagingService = TwilioMessagingService(
    accountSid: '', // replace with Account SID
    authToken: '', // replace with Auth Token
    messagingServiceSid: '' // replace with messaging service sid from twilio console
);
```

### SMS
The following are the SMS related features in **TwilioMessagingService**.

#### Send SMS using Messaging service

`twilioMessagingService.sendSMS()` can be used to send SMS with required message body to any mobile number by providing the number and proper country code. There is two ways to use the function:

- Use sendSMS with the recipient number and message body using the default `twilioNumber`.

```dart
TwilioResponse response = await twilioMessagingService.sendSMS(
toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```

- Use sendSMS with the recipient number and message body using custom `fromNumber`.

```dart
TwilioResponse response = await twilioMessagingService.sendSMS(
toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world',
fromNumber:''// replace with Mobile Number(With country code)
);
```

#### Send Scheduled SMS Message

Scheduled messages can be sent using `twilioMessagingService.sendScheduledSms()` if the `sendAt` is at least 15 after the current time.

```dart
TwilioResponse response = await twilioMessagingService.sendScheduledSms(
toNumber : '',
messageBody : 'hello world',
sendAt:'2024-02-18T16:18:55Z'
// Datetime has to be in the same format
);
```

### Cancel Scheduled SMS

Scheduled SMS can be cancelled using the messageSid with `twilioMessagingService.cancelScheduledSms()`.

```dart
TwilioResponse response = await twilioMessagingService.cancelScheduledSms(messageSID:''// replace with message SID);
```


### WhatsApp
The following are the WhatsApp related features in **TwilioMessagingService**.

#### Send WhatsApp Message
`twilioMessagingService.sendWhatsAppMessage()` can be used to send WhatsApp message with required message body to any mobile number by providing the number and proper country code.
```dart
TwilioResponse response = await twilioMessagingService.sendWhatsAppMessage(toNumber : '',// replace with Mobile Number(With country code)
messageBody : 'hello world');
```


#### Send Scheduled WhatsApp Message

Scheduled messages can be sent using `twilioMessagingService.sendScheduledWhatsAppMessage()` if the `sendAt` is at least 15 after the current time.

```dart
TwilioResponse response = await twilioMessagingService.sendScheduledWhatsAppMessage(
toNumber : '',
messageBody : 'hello world',
sendAt:'2024-02-18T16:18:55Z'
// Datetime has to be in the same format
);
```

#### Cancel Scheduled WhatsApp Message

Scheduled whatsapp messages can be cancelled using the messageSid with `twilioMessagingService.cancelScheduledWhatsAppMessage()`.

```dart
TwilioResponse response = await twilioMessagingService.cancelScheduledWhatsAppMessage(messageSID:''// replace with message SID
);
```
----

## TwilioMessenger features (Experimental)
Create a new **TwilioMessenger** object and initialize with required values
```dart

final TwilioMessenger twilioMessenger = TwilioMessenger(
    accountSid: '', // replace with Account SID
    authToken: '', // replace with Auth Token
    messengerId: '' // replace with FB page ID
);
```

### Send Messenger text

Send Messenger text message using the `send_messenger()` method.

```dart
TwilioResponse response = await twilioMessenger.sendMessenger(recipient:'',
messageBody: ''
);
```


----

## TwilioResponse

All the function calls from all the services will return a `TwilioResponse` Object.

`TwilioResponse` wraps the response of all the APIs. The fields in TwilioResponse:
- `responseCode`: give the response code of the requests. Possible values: 200,400 etc.
- `responseState`: shows if the request fails or completes properly. Possible values: __ResponseState.SUCCESS__ or __ResponseState.FAILED__
- `errorData` : Holds the `ErrorData` object in case of any failures/exceptions.
- `metadata` : Holds all the info from the response of the API as json.

**ErrorData** object has the details about the errors. The fields are:
- code
- status
- message
- more_info


----

## Future Features

- [x] Cancel Scheduled Messages
- [x] Send message through Facebook Messenger
- [x] Twilio verification
- [ ] Email Sending Support
- [ ] Update a Message resource
- [ ] Delete a Message resource
- [ ] Alphanumeric Sender IDs in Messaging Services
- [ ] More Support for Messaging Service


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
feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/adarshbalu/twilio_flutter/pulls).


## Author

This Twilio Flutter plugin for Flutter is developed by [Adarsh Balachandran](https://github.com/adarshbalu).