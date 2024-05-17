
class UserModal{
  String userName;
  String email;
  String password;
  bool hasResume;
  String profilePic;
  String uid;
  String userType;
  bool isRecruiter;

  UserModal({required this.userName, required this.email, required this.password,required this.hasResume, required this.profilePic,required this.uid,required this.isRecruiter,required this.userType});

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'email': this.email,
      'password': this.password,
      'hasResume': this.hasResume,
      'profilePic': this.profilePic,
      'uid': this.uid,
      'userType': this.userType,
      'isRecruiter': this.isRecruiter,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      hasResume: map['hasResume'] as bool,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
      userType: map['userType'] as String,
      isRecruiter: map['isRecruiter'] as bool,
    );
  }
}