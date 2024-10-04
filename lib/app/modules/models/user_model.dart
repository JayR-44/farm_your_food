class UserModel {
  String? userId;
  String? userName;
  String? email;
  String? password;
  String? photoUrl;
  String? accountType;
  String? phoneNo;

  UserModel({
    this.userId,
    this.userName,
    this.email,
    this.password,
    this.photoUrl,
    this.accountType,
    this.phoneNo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? "",
      userName: json['userName'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      photoUrl: json['photoUrl'] ?? "",
      accountType: json['accountType'] ?? "",
      phoneNo: json['phoneNo'] ?? "",

    );
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId ?? "",
      'userName': userName ?? "",
      'email': email ?? "",
      'password': password ?? "",
      "photoUrl":photoUrl ?? "",
      "accountType":accountType ?? "",
      "phoneNo":phoneNo ?? "",

    };
  }

  Map<String, dynamic> toJsonForRegistration() {
    return {
      'userName': userName ?? "",
      'email': email ?? "",
      'password': password ?? "",
      "accountType":accountType ?? "",
      "phoneNo":phoneNo ?? "",
    };
  }



}


