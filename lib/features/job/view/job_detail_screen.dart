import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/firebase_strings.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';







import 'package:enable_hire_user/features/recruiter/features/list_of_jobs/view/edit_job_screen.dart';
import 'package:flutter/material.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/strings/strings.dart';


class JobDetailScreen extends ConsumerStatefulWidget {
  JobDetailScreen({
    super.key,
    required this.jobId,
    required this.companyLogo,
    required this.companyName,
    required this.jobName,
    required this.jobRole,
    required this.jobType,
    required this.totalApplication,
    required this.jobDescription,
    required this.accessibilityOptions,
    required this.requirementsOptions,
    required this.cultureOptions,
    required this.flexibilityOptions,
    required this.feedbackOptions,
    required this.selectedIndustry,
    required this.selectedLocation,
    required this.uids
  });

  final String jobName;
  final String jobId;
  final String companyName;
  final String companyLogo;
  final String jobRole;
  final List totalApplication;
  final String jobType;
  final String jobDescription;
  final List<dynamic> accessibilityOptions;
  final List<dynamic> requirementsOptions;
  final List<dynamic> cultureOptions;
  final List<dynamic> flexibilityOptions;
  final List<dynamic> feedbackOptions;
  final List uids;
  final String? selectedIndustry;
  final String? selectedLocation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
  List<String> texts = ['Requirement'];
  bool isSaved = false;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: widget.companyName, action: [
        // IconButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context){
        //       return EditJobScreen(jobId: widget.jobId);
        //     }));
        //   },
        //   icon: Icon(Icons.edit),
        // )
      ]),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 30,
                  spreadRadius: 10,
                  color: Styles.primary.withOpacity(0.06))
            ],
            color: Styles.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        widget.companyLogo,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.jobName,
                          style: Styles.mediumBoldText(context, ref),
                        ),
                        Text(
                          widget.companyName,
                          style: Styles.smallText(context, ref).copyWith(
                              fontWeight: FontWeight.w400,
                              color: Styles.blackColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '12LPA',
                          style: Styles.mediumBoldText(context, ref),
                        ),
                        Text(
                          'Salary',
                          style: Styles.smallText(context, ref).copyWith(
                              color: Styles.blackColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.totalApplication.length.toString(),
                          style: Styles.mediumBoldText(context, ref),
                        ),
                        Text(
                          'Applications',
                          style: Styles.smallText(context, ref).copyWith(
                              color: Styles.blackColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.jobType,
                          style: Styles.mediumBoldText(context, ref),
                        ),
                        Text(
                          'Job Type',
                          style: Styles.smallText(context, ref).copyWith(
                              color: Styles.blackColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: texts
                      .map(
                        (text) => InkWell(
                      onTap: () {
                        selectedTabIndex = texts.indexOf(text);
                        setState(() {});
                      },
                      child: Container(
                        width: 27.w,
                        height: 40,
                        decoration: BoxDecoration(
                            color: selectedTabIndex == texts.indexOf(text)
                                ? Styles.orangeColor
                                : Styles.blackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6)),
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          style: Styles.smallText(context, ref).copyWith(
                            color: selectedTabIndex == texts.indexOf(text)
                                ? Styles.whiteColor
                                : Styles.blackColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
                const Gap(10),
                Text(
                  'About The Role',
                  style: Styles.mediumBoldText(context, ref).copyWith(fontSize: 14),
                ),
                ReadMoreText(
                  widget.jobDescription,
                  trimMode: TrimMode.Line,
                  trimLines: 4,
                  colorClickableText: Styles.orangeColor,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  lessStyle: Styles.smallText(context, ref).copyWith(
                    color: Styles.orangeColor,
                  ),
                  style: Styles.smallText(context, ref)
                      .copyWith(color: Styles.blackColor.withOpacity(0.5)),
                  moreStyle: Styles.smallText(context, ref).copyWith(
                    color: Styles.blackColor,
                  ),
                ),

                const Gap(10),
                // Display the chips for accessibility options
                _buildChips('Accessibility Options:', widget.accessibilityOptions),
                // Display the chips for requirements options
                _buildChips('Requirements Options:', widget.requirementsOptions),
                // Display the chips for culture options
                _buildChips('Culture Options:', widget.cultureOptions ),
                // Display the chips for flexibility options
                _buildChips('Flexibility Options:', widget.flexibilityOptions),
                // Display the chips for feedback options
                _buildChips('Feedback Options:', widget.feedbackOptions),

                Gap(100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FirebaseAuth.instance.currentUser != null ? MyCustomButton(onPressed: ()async {

          // var applicantsIds = await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).get();
          //
          // List<String> applicantsList = applicantsIds.data()?['applicants_uid'] ?? [];

          if(widget.totalApplication.contains(FirebaseAuth.instance.currentUser!.uid ?? '')){

            return;

          }
          else{
            setState(() {
              widget.totalApplication.add(FirebaseAuth.instance.currentUser!.uid);
            });
            await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).update(
                {
                  'applicants_uid': widget.totalApplication,
                }


            );


            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Applied for job Successfully')));

          }




        } , label: widget.totalApplication.contains(FirebaseAuth.instance.currentUser!.uid) ? "Already Applied for this job": 'Apply Now') : MyCustomButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return LoginScreen(userType: Strings.userTypeUser);
          }));
        }, label: 'Apply Now'),
      ),

    );
  }

  Widget _buildChips(String label, List<dynamic> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options
              .map(
                (option) => Chip(label: Text(option)),
          )
              .toList(),
        ),
      ],
    );
  }
}









// class JobDetailScreen extends ConsumerStatefulWidget {
//   JobDetailScreen({super.key,required this.jobId, required this.companyLogo, required this.companyName, required this.jobName, required this.jobRole, required this.jobType, required this.totalApplication, required this.jobDescription});
//   String jobName;
//   String jobId;
//   String companyName;
//   String companyLogo;
//   String jobRole;
//   List totalApplication;
//   String jobType;
//   String jobDescription;
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _JobDetailScreenState();
// }
//
// class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
//   List<String> texts = ['Requirement', 'Company',];
//   bool isSaved = false;
//   int selectedTabIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar(context: context, title: widget.companyName, action: [
//         IconButton(
//           onPressed: () {
//             isSaved = !isSaved;
//             setState(() {});
//           },
//           icon: Image.asset(
//             IconStrings.save,
//             height: 20,
//             color: isSaved
//                 ? Styles.blackColor
//                 : Styles.blackColor.withOpacity(0.2),
//           ),
//         )
//       ]),
//       body: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 30,
//                 spreadRadius: 10,
//                 color: Styles.primary.withOpacity(0.06))
//           ],
//           color: Styles.whiteColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.network(
//                       widget.companyLogo,
//                       height: 60,
//                       width: 60,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const Gap(10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.jobName,
//                         style: Styles.mediumBoldText(context,ref),
//                       ),
//                       Text(
//                         widget.companyName,
//                         style: Styles.smallText(context,ref).copyWith(
//                             fontWeight: FontWeight.w400,
//                             color: Styles.blackColor.withOpacity(0.5)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Gap(20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         '12LPA',
//                         style: Styles.mediumBoldText(context,ref),
//                       ),
//                       Text(
//                         'Salary',
//                         style: Styles.smallText(context,ref).copyWith(
//                             color: Styles.blackColor.withOpacity(0.5)),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         widget.totalApplication.length.toString(),
//                         style: Styles.mediumBoldText(context,ref),
//                       ),
//                       Text(
//                         'Applications',
//                         style: Styles.smallText(context,ref).copyWith(
//                             color: Styles.blackColor.withOpacity(0.5)),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         widget.jobType,
//                         style: Styles.mediumBoldText(context,ref),
//                       ),
//                       Text(
//                         'Job Type',
//                         style: Styles.smallText(context,ref).copyWith(
//                             color: Styles.blackColor.withOpacity(0.5)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Gap(10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: texts
//                     .map(
//                       (text) => InkWell(
//                         onTap: () {
//                           selectedTabIndex = texts.indexOf(text);
//                           setState(() {});
//                         },
//                         child: Container(
//                           width: 27.w,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               color: selectedTabIndex == texts.indexOf(text)
//                                   ? Styles.orangeColor
//                                   : Styles.blackColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(6)),
//                           alignment: Alignment.center,
//                           child: Text(
//                             text,
//                             style: Styles.smallText(context,ref).copyWith(
//                               color: selectedTabIndex == texts.indexOf(text)
//                                   ? Styles.whiteColor
//                                   : Styles.blackColor.withOpacity(0.7),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//               const Gap(10),
//               Text(
//                 'About The Role',
//                 style: Styles.mediumBoldText(context,ref).copyWith(fontSize: 14),
//               ),
//               ReadMoreText(
//                 widget.jobDescription,
//                 trimMode: TrimMode.Line,
//                 trimLines: 4,
//                 colorClickableText: Styles.orangeColor,
//                 trimCollapsedText: 'Show more',
//                 trimExpandedText: 'Show less',
//                 lessStyle: Styles.smallText(context,ref).copyWith(
//                   color: Styles.orangeColor,
//                 ),
//                 style: Styles.smallText(context,ref)
//                     .copyWith(color: Styles.blackColor.withOpacity(0.5)),
//                 moreStyle: Styles.smallText(context,ref).copyWith(
//                   color: Styles.blackColor,
//                 ),
//               ),
//               const Gap(10),
//               Text(
//                 'What You Will Do',
//                 style: Styles.mediumBoldText(context,ref).copyWith(fontSize: 14),
//               ),
//               const Gap(10),
//               Row(
//                 children: [
//                   CircleAvatar(
//                       radius: 9,
//                       backgroundColor: Styles.greenColor.withOpacity(0.3),
//                       child: Icon(
//                         Icons.done,
//                         size: 10,
//                         color: Styles.greenColor,
//                       )),
//                   const Gap(10),
//                   Text(
//                     lorem(words: 4, paragraphs: 1),
//                     maxLines: 1,
//                     style: Styles.smallText(context,ref)
//                         .copyWith(color: Styles.blackColor.withOpacity(0.5)),
//                   ),
//                 ],
//               ),
//               const Gap(10),
//               Row(
//                 children: [
//                   CircleAvatar(
//                       radius: 9,
//                       backgroundColor: Styles.greenColor.withOpacity(0.3),
//                       child: Icon(
//                         Icons.done,
//                         size: 10,
//                         color: Styles.greenColor,
//                       )),
//                   const Gap(10),
//                   Text(
//                     lorem(words: 4, paragraphs: 1),
//                     maxLines: 1,
//                     style: Styles.smallText(context,ref)
//                         .copyWith(color: Styles.blackColor.withOpacity(0.5)),
//                   ),
//                 ],
//               ),
//               const Gap(10),
//               Row(
//                 children: [
//                   CircleAvatar(
//                       radius: 9,
//                       backgroundColor: Styles.greenColor.withOpacity(0.3),
//                       child: Icon(
//                         Icons.done,
//                         size: 10,
//                         color: Styles.greenColor,
//                       )),
//                   const Gap(10),
//                   Text(
//                     lorem(words: 4, paragraphs: 1),
//                     maxLines: 1,
//                     style: Styles.smallText(context,ref)
//                         .copyWith(color: Styles.blackColor.withOpacity(0.5)),
//                   ),
//                 ],
//               ),
//               const Gap(10),
//               Row(
//                 children: [
//                   CircleAvatar(
//                       radius: 9,
//                       backgroundColor: Styles.greenColor.withOpacity(0.3),
//                       child: Icon(
//                         Icons.done,
//                         size: 10,
//                         color: Styles.greenColor,
//                       )),
//                   const Gap(10),
//                   Text(
//                     lorem(words: 4, paragraphs: 1),
//                     maxLines: 1,
//                     style: Styles.smallText(context,ref)
//                         .copyWith(color: Styles.blackColor.withOpacity(0.5)),
//                   ),
//                 ],
//               ),
//               const Gap(10),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: FirebaseAuth.instance.currentUser != null ? MyCustomButton(onPressed: ()async {
//
//           // var applicantsIds = await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).get();
//           //
//           // List<String> applicantsList = applicantsIds.data()?['applicants_uid'] ?? [];
//
//           if(widget.totalApplication.contains(FirebaseAuth.instance.currentUser!.uid ?? '')){
//
//             return;
//
//           }
//           else{
//             setState(() {
//               widget.totalApplication.add(FirebaseAuth.instance.currentUser!.uid);
//             });
//             await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).update(
//                 {
//                   'applicants_uid': widget.totalApplication,
//                 }
//
//
//             );
//
//
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Applied for job Successfully')));
//
//           }
//
//
//
//
//         } , label: widget.totalApplication.contains(FirebaseAuth.instance.currentUser!.uid) ? "Already Applied for this job": 'Apply Now') : MyCustomButton(onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context){
//             return LoginScreen(userType: Strings.userTypeUser);
//           }));
//         }, label: 'Apply Now'),
//       ),
//     );
//   }
// }
