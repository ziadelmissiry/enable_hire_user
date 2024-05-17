import 'package:cached_network_image/cached_network_image.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/firebase_strings.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';



import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../profile/modals/resume_modal.dart';

class ApplicantDetailsRecruiter extends ConsumerStatefulWidget {
  final String resumeId;

  const ApplicantDetailsRecruiter({Key? key, required this.resumeId}) : super(key: key);

  @override
  _ApplicantDetailsScreenState createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends ConsumerState<ApplicantDetailsRecruiter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Applicant Details'),
        backgroundColor: Styles.backColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseStrings.usersCollection)
            .doc(widget.resumeId)
            .collection(FirebaseStrings.resumeCollection)
            .doc(widget.resumeId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No data available'));
          }

          // Retrieve resume data from snapshot
          final resumeData = snapshot.data!.data() as Map<String, dynamic>;

          // Create a Resume object from the retrieved data
          final resume = Resume(
            name: resumeData['name'],
            desiredPosition: resumeData['desiredPosition'],
            contactNumber: resumeData['contactNumber'],
            email: resumeData['email'],
            companies: List<Map<String, dynamic>>.from(resumeData['companies']),
            hobbies: List<String>.from(resumeData['hobbies']),
            skills: List<String>.from(resumeData['skills']),
            experience: resumeData['experience'],
            educationList: List<Map<String, dynamic>>.from(resumeData['educationList']), profilePic: resumeData['profilePic'] ?? '',
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resume.name,
                          style: Styles.mediumBoldText(context, ref),
                        ),
                        const Gap(5),
                        Text(
                          'Applied for ${resume.desiredPosition}',
                          style: Styles.smallText(context, ref),
                        ),
                        const Gap(5),
                        Text(
                          'Contact: ${resume.contactNumber}',
                          style: Styles.smallText(context, ref),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(20),
                _buildSection('Skills:', resume.skills),
                const Gap(20),
                _buildSection('Experience:', [resume.experience]),
                const Gap(20),
                _buildEducationSection(resume.educationList),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.mediumBoldText(context, ref),
        ),
        const Gap(5),
        Wrap(
          spacing: 10,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: Styles.primary,
              labelStyle: Styles.smallText(context, ref).copyWith(color: Colors.white),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEducationSection(List<Map<String, dynamic>> educationList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education:',
          style: Styles.mediumBoldText(context, ref),
        ),
        const Gap(5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: educationList.map((education) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'School/College: ${education['school']}',
                  style: Styles.smallText(context, ref),
                ),
                const Gap(5),
                Text(
                  'Degree: ${education['degree']}',
                  style: Styles.smallText(context, ref),
                ),
                const Gap(5),
                Text(
                  'Start Date: ${education['startDate']}',
                  style: Styles.smallText(context, ref),
                ),
                const Gap(5),
                Text(
                  'End Date: ${education['endDate']}',
                  style: Styles.smallText(context, ref),
                ),
                const Gap(10),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}


//
// class ApplicantDetailsScreen extends ConsumerStatefulWidget {
//   const ApplicantDetailsScreen({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _ApplicantDetailsScreenState();
// }
//
// class _ApplicantDetailsScreenState extends ConsumerState<ApplicantDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         title: Text('Applicant Details'),
//         backgroundColor: Styles.backColor,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Gap(20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       ClipOval(
//                         child: CachedNetworkImage(
//                           imageUrl:
//                           'https://randomuser.me/api/portraits/men/1.jpg',
//                           placeholder: (context, url) => Shimmer.fromColors(
//                             baseColor: Colors.grey[300]!,
//                             highlightColor: Colors.grey[100]!,
//                             child: Container(
//                               width: 60,
//                               height: 60,
//                               color: Colors.white,
//                             ),
//                           ),
//                           errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                           fit: BoxFit.cover,
//                           width: 60,
//                           height: 60,
//                         ),
//                       ),
//                       const Gap(20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'John Doe',
//                             style: Styles.mediumBoldText(context, ref),
//                           ),
//                           const Gap(5),
//                           Text(
//                             'Applied for Flutter Developer',
//                             style: Styles.smallText(context, ref),
//                           ),
//                           const Gap(5),
//                           Text(
//                             'Contact: +1234567890',
//                             style: Styles.smallText(context, ref),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const Gap(20),
//                   Text(
//                     'Skills:',
//                     style: Styles.mediumBoldText(context, ref),
//                   ),
//                   const Gap(5),
//                   Wrap(
//                     spacing: 10,
//                     children: [
//                       _buildSkillChip(context, 'Flutter'),
//                       _buildSkillChip(context, 'Dart'),
//                       _buildSkillChip(context, 'Firebase'),
//                       _buildSkillChip(context, 'UI/UX Design'),
//                       _buildSkillChip(context, 'Responsive Design'),
//                       _buildSkillChip(context, 'Git'),
//                     ],
//                   ),
//                   const Gap(20),
//                   Text(
//                     'Experience:',
//                     style: Styles.mediumBoldText(context, ref),
//                   ),
//                   const Gap(5),
//                   Text(
//                     '3 years of experience in mobile app development',
//                     style: Styles.smallText(context, ref),
//                   ),
//                   const Gap(20),
//                   Text(
//                     'Education:',
//                     style: Styles.mediumBoldText(context, ref),
//                   ),
//                   const Gap(5),
//                   Text(
//                     'Bachelor\'s degree in Computer Science',
//                     style: Styles.smallText(context, ref),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSkillChip(BuildContext context, String skill) {
//     return Chip(
//       label: Text(
//         skill,
//         style: Styles.smallText(context, ref).copyWith(color: Colors.white),
//       ),
//       backgroundColor: Styles.primary,
//     );
//   }
// }
