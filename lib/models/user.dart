class UserData {
  String uid;
  String name;
  String occupation;

  UserData({
    required this.name,
    required this.uid,
    required this.occupation,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'] as String,
          uid: json['uid'] as String,
          occupation: json['occupation'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'uid': uid,
      'occupation': occupation,
    };
  }
}
