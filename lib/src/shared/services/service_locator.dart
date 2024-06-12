import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/email/repositories/twilio_email_repository.dart';
import 'package:twilio_flutter/src/email/repositories/twilio_email_repository_impl.dart';
import 'package:twilio_flutter/src/sms/repository/twilio_sms_repository_impl.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service_impl.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';

import '../../sms/repository/twilio_sms_repository.dart';
import '../../whatsapp/repositories/twilio_whatsapp_repository.dart';
import '../../whatsapp/repositories/twilio_whatsapp_repository_impl.dart';
import '../../whatsapp/services/twilio_whatsapp_service_impl.dart';

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
  if (!locator.isRegistered<TwilioWhatsAppRepository>(
      instanceName: "TwilioWhatsAppRepositoryImpl")) {
    locator.registerSingleton<TwilioWhatsAppRepository>(
        TwilioWhatsAppRepositoryImpl(),
        instanceName: "TwilioWhatsAppRepositoryImpl");
  }
  if (!locator.isRegistered<TwilioWhatsAppService>(
      instanceName: "TwilioWhatsAppServiceImpl")) {
    locator.registerSingleton<TwilioWhatsAppService>(
        TwilioWhatsAppServiceImpl(),
        instanceName: "TwilioWhatsAppServiceImpl");
  }
  if (!locator.isRegistered<TwilioEmailRepository>(
      instanceName: "TwilioEmailRepositoryImpl")) {
    locator.registerSingleton<TwilioEmailRepository>(
        TwilioEmailRepositoryImpl(),
        instanceName: "TwilioEmailRepositoryImpl");
  }
}
