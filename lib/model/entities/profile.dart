import 'package:uuid/uuid.dart';

class Profile{
  Uuid id;
  String fcmToken;

  Profile({required this.id, required this.fcmToken});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    fcmToken: json["fcm_token"],
  );
}