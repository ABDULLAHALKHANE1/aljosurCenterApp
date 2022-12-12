class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? token;

  UserModel(
      {this.uId,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    token = json['token'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'token': token,
    };
  }
}
