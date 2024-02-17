import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:twilio_flutter/src/calls/repositories/twilio_calls_repository.dart';
import 'package:twilio_flutter/src/sms/repository/twilio_sms_repository_impl.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service_impl.dart';
import 'package:http/http.dart' as http;

import '../../sms/repository/twilio_sms_repository.dart';

final GetIt locator = GetIt.instance;

void registerServices() {
  if (!locator.isRegistered<http.Client>(instanceName: "http.client")) {
    locator.registerSingleton<http.Client>(http.Client(),
        instanceName: "http.client");
  }
  if (!locator.isRegistered<TwilioSmsRepository>(
      instanceName: "TwilioSMSRepositoryImpl")) {
    locator.registerSingleton<TwilioSmsRepository>(TwilioSMSRepositoryImpl(),
        instanceName: "TwilioSMSRepositoryImpl");
  }
  if (!locator.isRegistered<TwilioSMSService>(
      instanceName: "TwilioSMSServiceImpl")) {
    locator.registerSingleton<TwilioSMSService>(TwilioSMSServiceImpl(),
        instanceName: "TwilioSMSServiceImpl");
  }
}
