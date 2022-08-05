class UserModel {
  String? name;
  String? email;
  String? id;

  UserModel({required id, required email, required name});

  Map<String, dynamic> toMap() {
    return{
      'name':name,
      'email':email,
      'id':id
    };
  }

  factory UserModel.fromMap(map) {
    return UserModel(name: map['name'], email: map['email'], id: map['uid']);
  }
}
