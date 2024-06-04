import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_talk/presentation/constants/firebase_constants.dart';

class AppUser {
  final String uid;
  final String displayImage;
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String email;
  final List<AppUser> friends;

  AppUser({
    this.uid = "",
    this.displayImage = "",
    this.fullName = "",
    this.dateOfBirth = "",
    this.gender = "",
    this.email = "",
    this.friends = const [],
  });

  copyWith({
    String? uid,
    String? displayImage,
    String? fullName,
    String? dateOfBirth,
    String? gender,
    String? email,
    List<AppUser>? friends,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      displayImage: displayImage ?? this.displayImage,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      friends: friends ?? this.friends,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid.isNotEmpty) UserCollectionConstant.id: uid,
      if (displayImage.isNotEmpty)
        UserCollectionConstant.displayImage: displayImage,
      if (fullName.isNotEmpty) UserCollectionConstant.fullName: fullName,
      if (dateOfBirth.isNotEmpty)
        UserCollectionConstant.dateOfBirth: dateOfBirth,
      if (gender.isNotEmpty) UserCollectionConstant.gender: gender,
      if (email.isNotEmpty) UserCollectionConstant.email: email,
      if (friends.isNotEmpty)
        UserCollectionConstant.friends:
        friends.map((e) => e.toFirestore()).toList(),
    };
  }

  factory AppUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,) {
    final data = snapshot.data();
    return AppUser(
      uid: data?[UserCollectionConstant.id] ?? "Unknown id",
      displayImage: data?[UserCollectionConstant.displayImage] ?? "",
      fullName: data?[UserCollectionConstant.fullName] ?? "",
      dateOfBirth: data?[UserCollectionConstant.dateOfBirth] ?? "",
      gender: data?[UserCollectionConstant.gender] ?? "",
      email: data?[UserCollectionConstant.email] ?? "",
      friends: (data?[UserCollectionConstant.friends] as List?)
          ?.map((e) => AppUser.fromMap(e))
          .toList() ?? [],
    );
  }
  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      uid: data[UserCollectionConstant.id] as String? ?? "Unknown id",
      displayImage: data[UserCollectionConstant.displayImage] as String? ?? "",
      fullName: data[UserCollectionConstant.fullName] as String? ?? "",
      dateOfBirth: data[UserCollectionConstant.dateOfBirth] as String? ?? "",
      gender: data[UserCollectionConstant.gender] as String? ?? "",
      email: data[UserCollectionConstant.email] as String? ?? "",
      friends: (data[UserCollectionConstant.friends] as List?)
          ?.map((e) => AppUser.fromMap(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}
