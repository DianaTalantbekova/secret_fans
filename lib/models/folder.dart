import 'package:flutter_contacts/contact.dart';

class Folder {
  final String name;
  final List<Contact> contacts;

  const Folder({
    required this.name,
    required this.contacts,
  });

  Folder copyWith({
    String? name,
    List<Contact>? contacts,
  }) {
    return Folder(
      name: name ?? this.name,
      contacts: contacts ?? this.contacts,
    );
  }
}