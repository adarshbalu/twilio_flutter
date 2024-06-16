import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Twilio_Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TwilioFlutter twilioFlutter;
  late TwilioMessagingService twilioMessagingService;

  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: "", authToken: "", twilioNumber: "");
    twilioMessagingService = TwilioMessagingService(
        accountSid: "", authToken: "", messagingServiceSid: "");
    super.initState();
  }

  void sendSms() async {
    TwilioResponse twilioResponse =
        await twilioFlutter.sendSMS(toNumber: '', messageBody: 'hello world');
  }

  Future<void> sendWhatsApp() async {
    TwilioResponse twilioResponse = await twilioFlutter.sendWhatsApp(
        toNumber: '', messageBody: 'hello world');
  }

  void getSms() async {
    TwilioResponse twilioResponse = await twilioFlutter.getSmsList();

    await twilioFlutter.getSMS('');
  }

  void sendScheduledSms() async {
    await twilioMessagingService.sendScheduledSms(
        toNumber: '',
        messageBody: 'hello world',
        sendAt: '2024-03-18T16:18:55Z');
  }

  void cancelScheduledSMS() async {
    TwilioResponse twilioResponse =
        await twilioMessagingService.cancelScheduledSms(messageSid: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Click the button to send SMS.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}
