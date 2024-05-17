import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../theme/styles.dart';
import '../../../utils/strings/icon_strings.dart';

class MyJobs extends ConsumerStatefulWidget {
  const MyJobs({super.key});

  @override
  ConsumerState<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends ConsumerState<MyJobs> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Jobs',style: Styles.mediumBoldText(context, ref),),
      ),
      body:firebaseAuth.currentUser != null? Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StreamBuilder(


            stream: FirebaseFirestore.instance.collection('jobs').where('applicants_uid', arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.data!.docs.isEmpty){
                return Center(child: Text("You Havent Applied For Any Jobs Yet",style: Styles.mediumBoldText(context, ref),));
              }
              List<DocumentSnapshot> jobs = snapshot.data!.docs;
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Gap(15);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: jobs.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> job = jobs[index].data() as Map<String, dynamic>;
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Styles.whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    job['company_logo'],
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job['job_name'],
                                        style: Styles.mediumBoldText(context,ref),
                                      ),
                                      Text(
                                        job['company_name'],
                                        style: Styles.mediumText(context,ref).copyWith(
                                            height: 1,
                                            color:
                                            Styles.blackColor.withOpacity(0.3)),
                                      ),
                                    ],
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () {
                                //     isSaved = !isSaved;
                                //     setState(() {});
                                //   },
                                //   icon: Image.asset(
                                //     IconStrings.save,
                                //     height: 20,
                                //     color: isSaved
                                //         ? Styles.blackColor
                                //         : Styles.blackColor.withOpacity(0.2),
                                //   ),
                                // )
                              ],
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(IconStrings.location2,
                                        height: 15,
                                        color: Styles.blackColor.withOpacity(0.5)),
                                    const Gap(5),
                                    Text(
                                      job['location'],
                                      style: Styles.smallText(context,ref).copyWith(
                                          color:
                                          Styles.blackColor.withOpacity(0.5)),
                                    )
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       '₹20,000',
                                //       style: Styles.mediumBoldText(context,ref)
                                //           .copyWith(
                                //           color:
                                //           Styles.blackColor.withOpacity(1)),
                                //     ),
                                //     const Gap(5),
                                //     Text(
                                //       '/Month',
                                //       style: Styles.smallText(context,ref).copyWith(
                                //           color:
                                //           Styles.blackColor.withOpacity(0.5)),
                                //     )
                                //   ],
                                // ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              );
            }
        ),
      ) : const Center(
        child: Text(
          'Please Login To See Your Saved Jobs'
        ),
      )
      ,
    );
  }
}
