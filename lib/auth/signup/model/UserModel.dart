class userModel {
  static const String Collection_Name='users';
  String name, emailAddress, phoneNumber, address, uId;
  userModel(
      {required this.name,
      required this.emailAddress,
      required this.phoneNumber,
      required this.address,
      required this.uId});

  userModel.fromJson(Map<String, Object?> json)
  :this(
    name : json['name']! as String,
    emailAddress : json['emailAddress']!as String,
    phoneNumber : json['PhoneNumber']!as String,
    address : json['address']!as String,
    uId : json['uId']!as String,
  );


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'address': address,
      'uId': uId,
    };
  }
}
