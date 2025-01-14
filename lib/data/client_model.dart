import 'package:client_contact_manager/data/contact_model.dart';

class Client {
  final String name;
  final DateTime lastUpdated;
  final Contact contact1;
  final Contact contact2;
  final Contact contact3;

  const Client(
      {required this.name,
      required this.lastUpdated,
      required this.contact1,
      required this.contact2,
      required this.contact3});

  factory Client.fromJson(Map<String, dynamic> contactInfo) {
    return Client(
      name: contactInfo['name'],
      lastUpdated:DateTime.parse( contactInfo['lastUpdated']),
      contact1: Contact.fromJson({
        'name': contactInfo['name1'],
        'email': contactInfo['email1'],
        'phnNum': contactInfo['phnNum1'],
      }),
      contact2: Contact.fromJson({
        'name': contactInfo['name2'],
        'email': contactInfo['email2'],
        'phnNum': contactInfo['phnNum2'],
      }),
      contact3: Contact.fromJson({
        'name': contactInfo['name3'],
        'email': contactInfo['email3'],
        'phnNum': contactInfo['phnNum3'],
      }),
    );
  }
}
