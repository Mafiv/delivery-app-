class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String gender;
  final String phoneNumber;
  final String image;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.gender,
    required this.phoneNumber,
    required this.image,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      userName: json['UserName'],
      gender: json['Gender'],
      phoneNumber: json['PhoneNumber'],
      image: json['image'],
    );
  }
}
