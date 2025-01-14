class Contact{
  final String name;
  final String email;
  final String phnNum;

  const Contact({
    required this.name, 
    required this.email, 
    required this.phnNum,
  });

  factory Contact.fromJson(Map<String, dynamic> contactInfo){

    return Contact(
      name: contactInfo['name'], 
      email: contactInfo['email'], 
      phnNum: contactInfo['phnNum'],
    );
  }
}