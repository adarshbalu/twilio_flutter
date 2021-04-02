import 'package:meta/meta.dart';

abstract class TwilioSmsRepository {
  Future getSmsList();
  Future sendSMS({@required String toNumber, @required String messageBody});
}

class TwilioSMSRepositoryImpl extends TwilioSmsRepository {
  @override
  Future getSmsList() {
    // TODO: implement getSmsList
    throw UnimplementedError();
  }

  @override
  Future sendSMS({@required String toNumber, @required String messageBody}) {
    // TODO: implement sendSMS
    throw UnimplementedError();
  }
}
