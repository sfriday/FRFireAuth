import 'dart:convert';

class FRFireUser {
  final String uid;
  final String? displayName;
  final String? avatarURL;
  final String? phoneNumber;
  final String? email;

  FRFireUser({
    required this.uid,
    this.displayName,
    this.avatarURL,
    this.phoneNumber,
    this.email,
  });

  FRFireUser copyWith({
    String? uid,
    String? displayName,
    String? avatarURL,
    String? phoneNumber,
    String? email,
  }) {
    return FRFireUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      avatarURL: avatarURL ?? this.avatarURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'avatarURL': avatarURL,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory FRFireUser.fromMap(Map<String, dynamic> map) {
    return FRFireUser(
      uid: map['uid'] as String,
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
      avatarURL: map['avatarURL'] != null ? map['avatarURL'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FRFireUser.fromJson(String source) => FRFireUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireUser(uid: $uid, displayName: $displayName, avatarURL: $avatarURL, phoneNumber: $phoneNumber, email: $email)';
  }

  @override
  bool operator ==(covariant FRFireUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.displayName == displayName &&
      other.avatarURL == avatarURL &&
      other.phoneNumber == phoneNumber &&
      other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      displayName.hashCode ^
      avatarURL.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode;
  }
}
