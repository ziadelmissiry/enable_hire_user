class Resume {
  final String name;
  final String desiredPosition;
  final String contactNumber;
  final String email;
  final List<Map<String,dynamic>> companies;
  final List<String> hobbies;
  final List<String> skills;
  final String experience;
  final List<Map<String, dynamic>> educationList;
  final String profilePic;

  Resume({
    required this.name,
    required this.desiredPosition,
    required this.contactNumber,
    required this.email,
    required this.companies,
    required this.hobbies,
    required this.skills,
    required this.experience,
    required this.educationList,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'desiredPosition': this.desiredPosition,
      'contactNumber': this.contactNumber,
      'email': this.email,
      'companies': this.companies,
      'hobbies': this.hobbies,
      'skills': this.skills,
      'experience': this.experience,
      'educationList': this.educationList,
      'profilePic': this.profilePic,
    };
  }

  factory Resume.fromMap(Map<String, dynamic> map) {
    return Resume(
      name: map['name'] as String,
      desiredPosition: map['desiredPosition'] as String,
      contactNumber: map['contactNumber'] as String,
      email: map['email'] as String,
      companies: map['companies'] ,
      hobbies: map['hobbies'] as List<String>,
      skills: map['skills'] as List<String>,
      experience: map['experience'] as String,
      educationList: map['educationList'] as List<Map<String, dynamic>>,
      profilePic: map['profilePic'] as String,
    );
  }
}