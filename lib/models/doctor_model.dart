class Doctor {
  int id;
  String email;
  String firstName;
  String phoneNumber;

  // {
  //     "id": 1,
  //     "email": "mraggitt0@washingtonpost.com",
  //     "fistName": "Maye",
  //     "phoneNumber": "+55 (799) 806-4034",
  //     "role": null,
  //     "userData": {}
  // }

  Doctor({
    required this.id,
    required this.email,
    required this.firstName,
    required this.phoneNumber,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["id"],
      email: json["email"],
      firstName: json["firstName"],
      phoneNumber: json["phoneNumber"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
    };
  }
}
