import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String userId;
  final String image;
  final String username;
  final String password;
  final String city;
  final String address;
  final String latitude;
  final String longitude;

  const UserModel(
      {required this.email,
      required this.userId,
      required this.image,
      required this.username,
      required this.password,
      required this.city,
      required this.address,
      required this.latitude,
      required this.longitude,
      });

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final snapshot = document.data()!;

    return UserModel(
      email: snapshot["email"],
      userId: snapshot["userId"],
      image: snapshot["image"],
      username: snapshot["username"],
      password: snapshot["password"],
      city: snapshot["city"],
      address: snapshot["address"],
      longitude: snapshot["longitude"],
      latitude: snapshot["latitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'userId': userId,
        'image': image,
        'username': username,
        'password': password,
        'city': city,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
