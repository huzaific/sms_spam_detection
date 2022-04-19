import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sms_spam_detection/utils/Apicalls.dart';
import 'package:sms_spam_detection/utils/SharedPrefrences.dart';
import 'package:sms_spam_detection/utils/deviceInfo.dart';

getUserContacts() async {
  if (await FlutterContacts.requestPermission()) {
    var contacts = await FlutterContacts.getContacts(withProperties: true);
    return contacts;
  } else {
    return null;
  }
}

syncContacts() async {
  var user = await SharedPref.getUser();
  var deviceId = await getDeviceId();
  var contacts = await getUserContacts();
  if (contacts != null) {
    var mappedContacts = contacts
        .map((contact) => {
              'firstName': contact.name.first.isNotEmpty
                  ? contact.name.first
                  : contact.displayName,
              'lastName': contact.name.last.isNotEmpty
                  ? contact.name.last
                  : contact.displayName,
              'email':
                  contact.emails.length > 0 ? contact.emails[0].address : '',
              'phone': contact.phones.length > 0 ? contact.phones[0].number : ''
            })
        .toList();

    await saveContactsToDB({
      "device": '${user["email"]}+$deviceId',
      "contacts": mappedContacts
    }).catchError((err) {
      print(err);
    });
  }
}
