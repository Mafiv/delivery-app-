class Profile {
  final String firstName;
  final String lastName;
  final String username;
  final String gender;
  final String phoneNumber;
  final String? image;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.gender,
    required this.phoneNumber,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      username: json['UserName'],
      gender: json['Gender'],
      phoneNumber: json['PhoneNumber'],
      image: json['image'],
    );
  }
}
