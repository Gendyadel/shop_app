class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;
  int points;
  int credit;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.token,
      this.points,
      this.credit});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    points = json['points'];
    credit = json['credit'];
  }
}
