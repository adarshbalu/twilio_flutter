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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: '', authToken: '', twilioNumber: '');

    super.initState();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(toNumber: '', messageBody: 'hello world');
  }

  void sendWhatsApp() {
    twilioFlutter.sendWhatsApp(toNumber: '', messageBody: 'hello world');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);

    await twilioFlutter.getSMS('***************************');
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
