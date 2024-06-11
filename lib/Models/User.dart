class User {
  String firstName;
  String lastName;
  String userName;
  String password;
  String gender;
  User(
    this.firstName,
    this.lastName,
    this.userName,
    this.password,
    this.gender,
  );
  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'user_name	': userName,
        'password	': password,
        'gender': gender,
      };
}
