# Twilio_Flutter

A Flutter package for both android and iOS which helps developers with Twilio API services.

## Usage

[Example](https://github.com/adarshbalu/twilio_flutter/blob/master/example/lib/main.dart)

To use this package :

- add the dependency to your [pubspec.yaml](https://github.com/adarshbalu/twilio_flutter/blob/master/pubspec.yaml) file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  twilio_flutter:
```

### How to use

```dart

//  Create a new Object
TwilioFlutter twilioFlutter; 

// Initialize with values
    twilioFlutter = TwilioFlutter(
        accountSid: '*************************', // replace *** with Account SID
        authToken: 'xxxxxxxxxxxxxxxxxx',  // replace xxx with Auth Token
        twilioNumber: '+...............'  // replace .... with Twilio Number
        );

//Send SMS

  twilioFlutter.sendSMS(
        toNumber: '+................', messageBody : 'hello world'); //Use sendSMS with the recipient number and message body.

//Change Twilio Number
    twilioFlutter.changeTwilioNumber('+.........'); // To change the twilio number

//Send WhatsApp Message (Experimental)

    twilioFlutter.sendWhatsApp(toNumber: '+................', messageBody : 'hello world');

```

# Features

- [x] Sms
- [ ] Call
- [ ] WhatsApp - Experimental feature


More features will get added soon. Contributions are also welcome.

# Pull Requests

Pull requests and contributions highly encouraged .Here are some basic rules to follow to ensure timely addition of your request:

1.  Match coding style (braces, spacing, etc.) This is best achieved using `Reformat Code` feature of Android Studio `CMD`+`Option`+`L` on Mac and `CTRL` + `ALT` + `L` on Linux + Windows .
2.  If its a feature, bugfix, or anything please only change code to what you specify.
3.  Please keep PR titles easy to read and descriptive of changes, this will make them easier to merge :)
4.  Pull requests _must_ be made against `develop` branch. Any other branch (unless specified by the maintainers) will get rejected.
5.  Check for existing [issues](https://github.com/adarshbalu/twilio_flutter/issues) first, before filing an issue.
6.  Make sure you follow the set standard as all other projects in this repo do
7.  Have fun!

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
