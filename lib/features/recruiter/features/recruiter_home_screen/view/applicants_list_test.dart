// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:enable_hire_user/features/recruiter/features/recruiter_home_screen/view/applicant_details_screen.dart';
// import 'package:enable_hire_user/theme/styles.dart';
// import 'package:enable_hire_user/utils/strings/firebase_strings.dart';
// import 'package:enable_hire_user/utils/strings/icon_strings.dart';
// import 'package:enable_hire_user/utils/strings/strings.dart';
// import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:shimmer/shimmer.dart';
//
// class JobApplicantsScreen extends ConsumerStatefulWidget {
//   JobApplicantsScreen({super.key,required this.applicantUids});
//   List<dynamic> applicantUids;
//
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _JobApplicantsScreenState();
// }
//
// class _JobApplicantsScreenState extends ConsumerState<JobApplicantsScreen> {
//
//
//   List<Map<String, dynamic>> _applicants = [
//     {
//       'name': 'John Doe',
//       'position': 'Flutter Developer',
//       'contact': '+1234567890',
//       'skills': ['Flutter', 'Dart', 'Firebase'],
//       'experience': '3 years of experience in mobile app development',
//       'education': 'Bachelor\'s degree in Computer Science',
//       'image':
//       'https://randomuser.me/api/portraits/men/1.jpg', // Sample image URL
//     },
//     {
//       'name': 'Jane Doe',
//       'position': 'UI/UX Designer',
//       'contact': '+9876543210',
//       'skills': ['UI/UX Design', 'Adobe XD', 'Figma'],
//       'experience': '5 years of experience in UI/UX design',
//       'education': 'Bachelor\'s degree in Design',
//       'image':
//       'https://randomuser.me/api/portraits/women/2.jpg', // Sample image URL
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Job Applicants'),
//       ),
//       body:widget.applicantUids.length==0 ? Center(child: Text('No Applicants Yet',style: Styles.mediumBoldText(context, ref),))  : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // mainAxisAlignment: widget.applicantUids.length==0? MainAxisAlignment.center : MainAxisAlignment.start,
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _applicants.length,
//               itemBuilder: (context, index) {
//                 return InkWell(onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context){
//                     return ApplicantDetailsScreen(resumeId: FirebaseAuth.instance.currentUser!.uid,);
//                   }));
//                 },child: StreamBuilder(
//                     stream: FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(widget.applicantUids[index]).collection(FirebaseStrings.resumeCollection).doc(widget.applicantUids[index]).snapshots(),
//                     builder: (context, snapshot) {
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       }
//                       if (snapshot.data!.data()!.isEmpty){
//                         return Center(child: Text("You don't have any jobs created",style: Styles.mediumBoldText(context, ref),));
//                       }
//
//
//                       return _buildApplicantCard(context, snapshot.data!.data()!);
//                     }
//                 ));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildApplicantCard(BuildContext context, Map<String, dynamic> applicant) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Card(
//         elevation: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipOval(
//                 child: CachedNetworkImage(
//                   imageUrl: applicant['image'],
//                   placeholder: (context, url) => Shimmer.fromColors(
//                     baseColor: Colors.grey[300]!,
//                     highlightColor: Colors.grey[100]!,
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       color: Colors.white,
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                   fit: BoxFit.cover,
//                   width: 60,
//                   height: 60,
//                 ),
//               ),
//               const Gap(20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       applicant['name'],
//                       style: Styles.mediumBoldText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       'Applied for ${applicant['position']}',
//                       style: Styles.smallText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       'Contact: ${applicant['contact']}',
//                       style: Styles.smallText(context, ref),
//                     ),
//                     const Gap(10),
//                     Text(
//                       'Skills:',
//                       style: Styles.mediumBoldText(context, ref),
//                     ),
//                     const Gap(5),
//                     Wrap(
//                       spacing: 5,
//                       children: [
//                         for (var skill in applicant['skills'])
//                           _buildSkillChip(context, skill),
//                       ],
//                     ),
//                     const Gap(10),
//                     Text(
//                       'Experience:',
//                       style: Styles.mediumBoldText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       applicant['experience'],
//                       style: Styles.smallText(context, ref),
//                     ),
//                     const Gap(10),
//                     Text(
//                       'Education:',
//                       style: Styles.mediumBoldText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       applicant['education'],
//                       style: Styles.smallText(context, ref),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
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
