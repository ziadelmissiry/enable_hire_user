import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enable_hire_user/features/recruiter/features/list_of_jobs/view/applicant_list_screen.dart';
import 'package:enable_hire_user/features/recruiter/view/create_job.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class RecruiterJobsListScreen extends ConsumerStatefulWidget {
  const RecruiterJobsListScreen({Key? key}) : super(key: key);

  @override
  _RecruiterJobsListScreenState createState() =>
      _RecruiterJobsListScreenState();
}

class _RecruiterJobsListScreenState
    extends ConsumerState<RecruiterJobsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Posted Jobs')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('uploader_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty){
            return Center(child: Text("You don't have any jobs created",style: Styles.mediumBoldText(context, ref),));
          }
          List<DocumentSnapshot> jobs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> job = jobs[index].data() as Map<String, dynamic>;
              return _buildJobCard(context, job, jobs[index].id);
            },
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          backgroundColor: Styles.primary,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreateJobScreen();
            }));
          },
          label: Text(
            'Create Job',
            style: Styles.mediumBoldText(context, ref).copyWith(color: Colors.white),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, Map<String, dynamic> job, String jobId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: job['company_logo'],
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['company_name'],
                      style: Styles.mediumBoldText(context,ref),
                    ),
                    const Gap(5),
                    Text(
                      job['job_name'],
                      style: Styles.mediumBoldText(context,ref),
                    ),
                    const Gap(5),
                    Text(
                      job['job_type'].toString(),
                      style: Styles.smallText(context,ref),
                    ),
                    const Gap(5),
                    Text(
                      job['location'],
                      style: Styles.smallText(context,ref),
                    ),
                    const Gap(5),
                    Text(
                      'Applicants: ${job['applicants_uid'].length} Applied',
                      style: Styles.smallText(context,ref),
                    ),
                    Gap(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return JobApplicantsScreen(applicantUids: job['applicants_uid'],);
                        }));
                        // Handle onTap
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Styles.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'View Applicants',
                          style: Styles.smallBoldText(context,ref)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:enable_hire_user/features/recruiter/view/create_job.dart';
// import 'package:enable_hire_user/theme/styles.dart';
// import 'package:enable_hire_user/utils/strings/icon_strings.dart';
// import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:shimmer/shimmer.dart';
//
// class RecruiterJobsListScreen extends ConsumerStatefulWidget {
//   const RecruiterJobsListScreen({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _RecruiterJobsListScreenState();
// }
//
// class _RecruiterJobsListScreenState
//     extends ConsumerState<RecruiterJobsListScreen> {
//   List<Map<String, dynamic>> _jobs = [
//     {
//       'company': 'Robolaxy',
//       'position': 'Flutter Developer',
//       'type': 'Full-Time',
//       'location': 'Chandigarh, India',
//       'applicants': '+14 Applied',
//       'image': 'https://randomuser.me/api/portraits/men/3.jpg',
//     },
//     {
//       'company': 'Robolaxy',
//       'position': 'UI/UX Designer',
//       'type': 'Part-Time',
//       'location': 'Bangalore, India',
//       'applicants': '+8 Applied',
//       'image': 'https://randomuser.me/api/portraits/women/4.jpg',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Styles.backColor,
//         title: Text('My Posted Jobs',
//           style: Styles.mediumBoldText(context, ref),
//
//       )),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Gap(20),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _jobs.length,
//               itemBuilder: (context, index) {
//                 return _buildJobCard(context, _jobs[index]);
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Align(
//         alignment: Alignment.bottomCenter,
//         child: FloatingActionButton.extended(
//           backgroundColor: Styles.primary,
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context){
//               return CreateJobScreen();
//             }));
//             // Handle "Create Job" action
//           },
//           label:  Text('Create Job',style: Styles.mediumBoldText(context, ref).copyWith(color: Colors.white),),
//           icon: const Icon(Icons.add,color: Colors.white,),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildJobCard(BuildContext context, Map<String, dynamic> job) {
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
//                   imageUrl: job['image'],
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
//                       job['company'],
//                       style: Styles.mediumBoldText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       job['position'],
//                       style: Styles.mediumBoldText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       job['type'],
//                       style: Styles.smallText(context, ref),
//                     ),
//                     const Gap(5),
//                     Text(
//                       job['location'],
//                       style: Styles.smallText(context, ref),
//                     ),
//                     const Gap(10),
//                     Row(
//                       children: [
//                         Text(
//                           job['applicants'],
//                           style: Styles.smallText(context, ref),
//                         ),
//                         const Spacer(),
//                         GestureDetector(
//                           onTap: () {
//                             // Handle onTap
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: Styles.primary,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Text(
//                               'View Applicants',
//                               style: Styles.smallBoldText(context, ref)
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
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
// }
