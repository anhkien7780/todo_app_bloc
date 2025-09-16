

class Profile {
  String id;
  String fcmToken;
  String? createdAt;

  Profile({required this.id, required this.fcmToken, this.createdAt});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    fcmToken: json["fcm_token"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fcm_token": fcmToken,
    "created_at": createdAt,
  };
}
