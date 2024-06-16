import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/email/repositories/twilio_email_repository.dart';
import 'package:twilio_flutter/src/email/repositories/twilio_email_repository_impl.dart';
import 'package:twilio_flutter/src/messenger/repository/twilio_messenger_repository.dart';
import 'package:twilio_flutter/src/messenger/repository/twilio_messenger_repository_impl.dart';
import 'package:twilio_flutter/src/messenger/services/twilio_messenger_service.dart';
import 'package:twilio_flutter/src/messenger/services/twilio_messenger_service_impl.dart';
import 'package:twilio_flutter/src/sms/repository/twilio_sms_repository_impl.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service_impl.dart';
import 'package:twilio_flutter/src/verify/repository/twilio_verify_repository.dart';
import 'package:twilio_flutter/src/verify/repository/twilio_verify_repository_impl.dart';
import 'package:twilio_flutter/src/verify/services/twilio_verify_service.dart';
import 'package:twilio_flutter/src/verify/services/twilio_verify_service_impl.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';

import '../../sms/repository/twilio_sms_repository.dart';
import '../../whatsapp/repositories/twilio_whatsapp_repository.dart';
import '../../whatsapp/repositories/twilio_whatsapp_repository_impl.dart';
import '../../whatsapp/services/twilio_whatsapp_service_impl.dart';

final GetIt locator = GetIt.instance;

void registerServices() {
  // HTTP client
  if (!locator.isRegistered<http.Client>(instanceName: "http.client")) {
    locator.registerSingleton<http.Client>(http.Client(),
        instanceName: "http.client");
  }
  // Twilio SMS
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
  // Twilio WhatsApp
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
  // Twilio Email
  if (!locator.isRegistered<TwilioEmailRepository>(
      instanceName: "TwilioEmailRepositoryImpl")) {
    locator.registerSingleton<TwilioEmailRepository>(
        TwilioEmailRepositoryImpl(),
        instanceName: "TwilioEmailRepositoryImpl");
  }
  // Twilio Messenger
  if (!locator.isRegistered<TwilioMessengerRepository>(
      instanceName: "TwilioMessengerRepositoryImpl")) {
    locator.registerSingleton<TwilioMessengerRepository>(
        TwilioMessengerRepositoryImpl(),
        instanceName: "TwilioMessengerRepositoryImpl");
  }
  if (!locator.isRegistered<TwilioMessengerService>(
      instanceName: "TwilioMessengerServiceImpl")) {
    locator.registerSingleton<TwilioMessengerService>(
        TwilioMessengerServiceImpl(),
        instanceName: "TwilioMessengerServiceImpl");
  }
  // Twilio verify
  if (!locator.isRegistered<TwilioVerifyRepository>(
      instanceName: "TwilioVerifyRepositoryImpl")) {
    locator.registerSingleton<TwilioVerifyRepository>(
        TwilioVerifyRepositoryImpl(),
        instanceName: "TwilioVerifyRepositoryImpl");
  }
  if (!locator.isRegistered<TwilioVerifyService>(
      instanceName: "TwilioVerifyServiceImpl")) {
    locator.registerSingleton<TwilioVerifyService>(TwilioVerifyServiceImpl(),
        instanceName: "TwilioVerifyServiceImpl");
  }
}
