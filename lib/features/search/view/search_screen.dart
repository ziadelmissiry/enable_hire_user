import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:enable_hire_user/utils/widgets/my_textfield.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../job/view/job_detail_screen.dart';
import 'filters.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  String searchquery= '';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<String> jobList = [
    "All",
    "Accounting/Finance",
    "Administrative Support",
    "Administrative Services",
    "Business Analytics & Consulting",
    "Business Development & Strategy",
    "Clinical",
    "Compliance",
    "Consultant",
    "Customer Service",
    "Art & Design",
    "Education/Training",
    "Engineering",
    "Executive/Management",
    "Facilities",
    "Finance",
    "General Business",
    "Global Comms & Corp Marketing",
    "Health Econ, Policy & Reimbursement",
    "Healthcare",
    "Human Resources",
    "Information Technology",
    "Intern",
    "Inventory",
    "Legal",
    "Manufacturing",
    "Marketing",
    "Medical",
    "Office Support",
    "Studio Operations",
    "Professional Services",
    "Sourcing & Procurement",
    "Quality Assurance",
    "Regulatory Affairs",
    "Research",
    "Safety",
    "Sales",
    "Science",
    "Shipping",
    "Skilled Labor",
    "Strategy/Planning",
    "Supply Chain",
    "Technicians",
    "Public Relations",
    "Digital & Interactive Media",
    "Data & Analytics",
    "Security",
    "Hospitality",
    "Retail",
    "Production (entertainment/media)",
    "Editorial",
    "Culinary/Food Service",
    "Communications & Public Relations",
    "Animation",
    "Theme Park Operations",
    "Crew",
    "Director",
    "Producer",
    "Writer",
    "Cyber Security",
    "Construction",
    "Transportation",
  ];
  int selectedJobIndex = 0;
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(MediaQuery.of(context).padding.top),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Flexible(
                      child: MyTextField(
                        onChanged: (value){
                          setState(() {
                            searchquery=value;

                          });
                        },
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          hasPrefix: true,
                          prefixIconData: Padding(
                            padding: const EdgeInsets.all(
                              2.0,
                            ),
                            child: Image.asset(
                              IconStrings.search,
                              color: Styles.blackColor.withOpacity(0.5),
                            ),
                          ),
                          hintText: "Search Job"),
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FiltersBottomSheet();
                          },
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Styles.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          width: 55,
                          height: 55,
                          child: Icon(
                            Icons.tune,
                            color: Styles.primary,
                          )),
                    ),
                  ],
                ),
              ),
             SizedBox(
                    width: 100.w,
                    height: 50,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: jobList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const Gap(10);
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedJobIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selectedJobIndex == index
                                    ? Styles.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              jobList[index],
                              style: Styles.mediumText(context,ref).copyWith(
                                  color: selectedJobIndex == index
                                      ? Colors.white
                                      : Styles.blackColor.withOpacity(0.6)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Job Opportunities',
                  style: Styles.smallText(context,ref)
                      .copyWith(color: Styles.blackColor.withOpacity(0.4)),
                ),
              ),
              const Gap(10),
              StreamBuilder(


                  stream: FirebaseFirestore.instance.collection('jobs').where('job_name', isGreaterThanOrEqualTo: searchquery).snapshots(),

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
                  return Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Gap(15);
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: jobs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> job = jobs[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return JobDetailScreen(jobId: snapshot.data!.docs[index].id, companyLogo: snapshot.data!.docs[index]['company_logo'], companyName: snapshot.data!.docs[index]['company_name'], jobName: snapshot.data!.docs[index]['job_name'], jobRole: snapshot.data!.docs[index]['job_name'], jobType: snapshot.data!.docs[0]['job_type'].toString(), totalApplication: snapshot.data!.docs[index]['applicants_uid'], jobDescription: snapshot.data!.docs[index]['company_description'], accessibilityOptions: snapshot.data!.docs[index]['accessibility_measures'], requirementsOptions: snapshot.data!.docs[index]['job_requirements'], cultureOptions: snapshot.data!.docs[index]['job_requirements'], flexibilityOptions: snapshot.data!.docs[index]['flexibility_and_support'], feedbackOptions: snapshot.data!.docs[index]['feedback_and_improvement'], selectedIndustry: snapshot.data!.docs[index]['industry'], selectedLocation: snapshot.data!.docs[index]['location'], uids: snapshot.data!.docs[index]['applicants_uid'],);
                              }));
                            },
                            child: Container(
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
                                      //               color:
                                      //                   Styles.blackColor.withOpacity(1)),
                                      //     ),
                                      //     const Gap(5),
                                      //     Text(
                                      //       '/Month',
                                      //       style: Styles.smallText(context,ref).copyWith(
                                      //           color:
                                      //               Styles.blackColor.withOpacity(0.5)),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              )
            ],
          )

      );
  }
}
