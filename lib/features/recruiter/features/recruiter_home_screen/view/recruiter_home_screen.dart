import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:enable_hire_user/features/recruiter/features/list_of_jobs/view/applicant_list_screen.dart';
import 'package:enable_hire_user/features/recruiter/features/list_of_jobs/view/job_details_screen_recruiter.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:enable_hire_user/utils/widgets/my_appbar.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';
import 'package:enable_hire_user/utils/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/utils.dart';
import '../../../../job/view/job_detail_screen.dart';

class RecruiterHomeScreen extends ConsumerStatefulWidget {
  const RecruiterHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecruiterHomeScreenState();
}

class _RecruiterHomeScreenState extends ConsumerState<RecruiterHomeScreen> {
  List<String> images = [
    "https://img.freepik.com/free-photo/we-are-hiring-digital-collage_23-2149667063.jpg",
    "https://belmac.in/wp-content/uploads/2023/07/Careers-1.png",
    "https://c1b6c098.flyingcdn.com/wp-content/uploads/2023/08/international-job-search.png?width=800",
  ];

  @override
  Widget build(BuildContext context) {
    double textSize = ref.watch(fontScaling);

    bool colorInversion = ref.watch(colorsInversion);
    bool colorContrast = ref.watch(contrastEnabled);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: AppBar(
            elevation: 0,
            backgroundColor:colorInversion?Styles.invertedBackColor : Styles.backColor,
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(kTextTabBarHeight - 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Looking for a Job?',
                  //       style: Styles.largeBoldText(context, ref)
                  //           .copyWith(color:colorInversion?Styles.invertedPrimary : Styles.primary),
                  //     ),
                  //     Align(
                  //       alignment: Alignment.topRight,
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color:colorInversion?Styles.invertedOrangeColor :Styles.orangeColor,
                  //             borderRadius: BorderRadius.circular(6)),
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 10, vertical: 5),
                  //         child: Text(
                  //           'Apply Now',
                  //           style: Styles.largeBoldText(context, ref)
                  //               .copyWith(color:colorInversion?Styles.invertedWhiteColor : Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Gap(10),
                  Divider(),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            style: Styles.mediumBoldText(context, ref),
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser!.displayName! ?? 'Recruiter',
                            style: Styles.largeBoldText(context, ref),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color:colorInversion? Styles.invertedBlackColor : Colors.black, width: 4)),
                        child: ClipOval(
                          child: Image.asset(
                            IconStrings.profile,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
               if(!kIsWeb)   CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:colorContrast? ColorFiltered(
                              colorFilter:ColorFilter.matrix(<double>[
                              4, 0, 0, 0, 0, // Red
                              0, 4, 0, 0, 0, // Green
                              0, 0, 4, 0, 0, // Blue
                              0, 0, 0, 1, 0,
                          // Alpha
                            ]),
                              child: CachedNetworkImage(
                                imageUrl: images[index],
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor:colorInversion? Color.fromARGB(255, 204, 204, 204)  : Colors.grey[300]!,
                                  highlightColor:colorInversion?Color.fromARGB(255, 229, 229, 229) : Colors.grey[100]!,
                                  child: Container(
                                    width: 100.w,
                                    height: 18.h,
                                    color:colorInversion? Styles.invertedWhiteColor  : Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 18.h,
                              ),
                            ) : CachedNetworkImage(
                              imageUrl: images[index],
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor:colorInversion? Color.fromARGB(255, 204, 204, 204)  : Colors.grey[300]!,
                                highlightColor:colorInversion?Color.fromARGB(255, 229, 229, 229) : Colors.grey[100]!,
                                child: Container(
                                  width: 100.w,
                                  height: 18.h,
                                  color:colorInversion? Styles.invertedWhiteColor  : Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 100.w,
                              height: 18.h,
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeInOut,
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Posted Jobs',
                style: Styles.mediumBoldText(context, ref),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('jobs').where('uploader_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data!.docs!.isEmpty){
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text("You don't have any jobs created",style: Styles.mediumBoldText(context, ref),),
                    ));
                  }




                  print(snapshot.data!.docs[0]['job_name']);

                  return SizedBox(
                    height: 200,
                    child: ListView.separated(
                        padding: const EdgeInsets.all(20),
                        separatorBuilder: (context, index) {
                          return const Gap(10);
                        },
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return JobDetailScreenRecruiter(jobId: snapshot.data!.docs[index].id, companyLogo: snapshot.data!.docs[index]['company_logo'], companyName: snapshot.data!.docs[index]['company_name'], jobName: snapshot.data!.docs[index]['job_name'], jobRole: snapshot.data!.docs[index]['job_name'], jobType: snapshot.data!.docs[0]['job_type'].toString(), totalApplication: snapshot.data!.docs[index]['applicants_uid'], jobDescription: snapshot.data!.docs[index]['company_description'], accessibilityOptions: snapshot.data!.docs[index]['accessibility_measures'], requirementsOptions: snapshot.data!.docs[index]['job_requirements'], cultureOptions: snapshot.data!.docs[index]['job_requirements'], flexibilityOptions: snapshot.data!.docs[index]['flexibility_and_support'], feedbackOptions: snapshot.data!.docs[index]['feedback_and_improvement'], selectedIndustry: snapshot.data!.docs[index]['industry'], selectedLocation: snapshot.data!.docs[index]['location'], uids: snapshot.data!.docs[index]['applicants_uid'],);
                              }));

                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color:  Styles.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:NetworkImage(snapshot.data!.docs[index]['company_logo']) ,
                                      ),
                                      const Gap(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['company_name'],
                                            style: Styles.mediumBoldText(context,ref)
                                                .copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['job_type'].toString(),
                                            style: Styles.smallText(context,ref)
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const Gap(30),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: Styles.blackColor.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          snapshot.data!.docs[index]['applicants_uid'].length.toString()+ '+ Applied',
                                          style: Styles.smallBoldText(context,ref)
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Text(
                                    snapshot.data!.docs[index]['job_name'],
                                    style: Styles.mediumBoldText(context,ref)
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['location'],
                                    style: Styles.smallText(context,ref)
                                        .copyWith(color: Colors.white.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
            ),
            // SizedBox(
            //   width: 100.w,
            //   height: 180,
            //   child: ListView.separated(
            //       padding: const EdgeInsets.all(20),
            //       separatorBuilder: (context, index) {
            //         return const Gap(10);
            //       },
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: true,
            //       itemCount: 2,
            //       itemBuilder: (context, index) {
            //         return InkWell(
            //           onTap: (){
            //             Navigator.push(context, MaterialPageRoute(builder: (context){
            //               return JobApplicantsScreen(applicantUids: [],);
            //             }));
            //           },
            //           child: Container(
            //             alignment: Alignment.center,
            //             padding: const EdgeInsets.all(20),
            //             decoration: BoxDecoration(
            //                 color: colorInversion? Styles.invertedPrimary  : Styles.primary,
            //                     // index == 1 ? Styles.orangeColor : Styles.primary,
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   children: [
            //                     Image.asset(
            //                       IconStrings.apple,
            //                       color:colorInversion? Styles.invertedWhiteColor.withOpacity(0.8) : Colors.white.withOpacity(0.8),
            //                       height: 40,
            //                     ),
            //                     const Gap(10),
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           'Robolaxy',
            //                           style: Styles.mediumBoldText(context, ref)
            //                               .copyWith(color:colorInversion?Styles.invertedWhiteColor : Colors.white),
            //                         ),
            //                         Text(
            //                           'Full-Time',
            //                           style: Styles.smallText(context, ref)
            //                               .copyWith(color:colorInversion?Styles.invertedWhiteColor : Colors.white),
            //                         ),
            //                       ],
            //                     ),
            //                     const Gap(30),
            //                     Container(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 10, vertical: 3),
            //                       decoration: BoxDecoration(
            //                           color: colorInversion?Styles.invertedBlackColor.withOpacity(0.3)  : Styles.blackColor.withOpacity(0.3),
            //                           borderRadius: BorderRadius.circular(5)),
            //                       child: Text(
            //                         '+14 Applied',
            //                         style: Styles.smallBoldText(context, ref)
            //                             .copyWith(color:colorInversion? Styles.invertedWhiteColor : Colors.white),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 const Gap(10),
            //                 Text(
            //                   'Flutter Developer',
            //                   style: Styles.mediumBoldText(context, ref)
            //                       .copyWith(color: colorInversion? Styles.invertedWhiteColor : Colors.white),
            //                 ),
            //                 Text(
            //                   'Chandigarh, India',
            //                   style: Styles.smallText(context, ref)
            //                       .copyWith(color:colorInversion?Styles.invertedWhiteColor.withOpacity(0.3) : Colors.white.withOpacity(0.8)),
            //                 ),
            //                 const Gap(10),
            //                 // Row(
            //                 //   children: [
            //                 //     ElevatedButton(
            //                 //       onPressed: () {
            //                 //         // Accept applicant action
            //                 //       },
            //                 //       child: Text('Accept'),
            //                 //     ),
            //                 //     const SizedBox(width: 10),
            //                 //     ElevatedButton(
            //                 //       onPressed: () {
            //                 //         // Reject applicant action
            //                 //       },
            //                 //       child: Text('Reject'),
            //                 //     ),
            //                 //   ],
            //                 // ),
            //               ],
            //             ),
            //           ),
            //         );
            //       }),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Popular Jobs',
                style: Styles.mediumBoldText(context,ref),
              ),
            ),
            const Gap(10),
            StreamBuilder(

                stream: FirebaseFirestore.instance.collection('jobs').where('uploader_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data!.docs!.isEmpty){
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text("You don't have any jobs created",style: Styles.mediumBoldText(context, ref),),
                    ));
                  }


                  return SizedBox(
                    width: 100.w,
                    height: 180,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: snapshot.data!.docs.length,
                        separatorBuilder: (context, index) {
                          return const Gap(10);
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:NetworkImage(snapshot.data!.docs[index]['company_logo']) ,
                                ),
                                Text(
                                  snapshot.data!.docs[index]['job_name'],
                                  style: Styles.mediumText(context,ref),
                                ),
                                const Spacer(),
                                Text(
                                  snapshot.data!.docs[index]['company_name'],
                                  style: Styles.smallText(context,ref).copyWith(
                                      color: Styles.blackColor.withOpacity(0.4)),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return JobDetailScreenRecruiter(jobId: snapshot.data!.docs[index].id, companyLogo: snapshot.data!.docs[index]['company_logo'], companyName: snapshot.data!.docs[index]['company_name'], jobName: snapshot.data!.docs[index]['job_name'], jobRole: snapshot.data!.docs[index]['job_name'], jobType: snapshot.data!.docs[0]['job_type'].toString(), totalApplication: snapshot.data!.docs[index]['applicants_uid'], jobDescription: snapshot.data!.docs[index]['company_description'], accessibilityOptions: snapshot.data!.docs[index]['accessibility_measures'], requirementsOptions: snapshot.data!.docs[index]['job_requirements'], cultureOptions: snapshot.data!.docs[index]['job_requirements'], flexibilityOptions: snapshot.data!.docs[index]['flexibility_and_support'], feedbackOptions: snapshot.data!.docs[index]['feedback_and_improvement'], selectedIndustry: snapshot.data!.docs[index]['industry'], selectedLocation: snapshot.data!.docs[index]['location'], uids: snapshot.data!.docs[index]['applicants_uid'],);
                                    }));


                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Styles.orangeColor,
                                        borderRadius: BorderRadius.circular(6)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      'View Job',
                                      style: Styles.smallBoldText(context,ref)
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  );
                }
            ),
           
            Gap(50),
          ],
        ),
      ),
    );
  }
}
