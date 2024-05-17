import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:enable_hire_user/features/auth/view/login_screen.dart';
import 'package:enable_hire_user/features/job/view/job_detail_screen.dart';
import 'package:enable_hire_user/features/profile/view/profile_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/utils/strings/route_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
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

import '../../../utils/utils.dart';
import '../../recruiter/features/list_of_jobs/view/job_details_screen_recruiter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  List<String> images = [
    "https://img.freepik.com/free-photo/we-are-hiring-digital-collage_23-2149667063.jpg",
    "https://belmac.in/wp-content/uploads/2023/07/Careers-1.png",
    "https://c1b6c098.flyingcdn.com/wp-content/uploads/2023/08/international-job-search.png?width=800",
  ];
  List<String> industry = [
    "All",
    "Advertising / Marketing",
    "Agricultural",
    "Airline/Aerospace/Aviation",
    "Apparel/Textiles",
    "Architecture / Design",
    "Art/Photography",
    "Automotive-vehicles/parts/service",
    "Banking / Accounting / Financial",
    "Biotechnology",
    "Broadcasting/Radio/TV",
    "Building Materials",
    "Computer Hardware",
    "Computer Software",
    "Construction",
    "Consulting",
    "Consumer Products",
    "Education / Teaching / Administration",
    "Electronics",
    "Energy/Utilities/Gas/Oil/Electric",
    "Entertainment",
    "Sports",
    "Environmental",
    "Food/Beverages",
    "General",
    "Government/Civil Service",
    "Healthcare / Health Services",
    "Hospitality / Tourism",
    "Human Resources/Staffing",
    "HVAC",
    "Industrial/Materials",
    "Insurance",
    "Internet / E-Commerce",
    "Law Enforcement / Security",
    "Legal",
    "Manufacturing",
    "Merchandising",
    "Military",
    "Non-Profit / Charity",
    "Office Equipment",
    "Other",
    "Packaging",
    "Pharmaceutical",
    "Printing / Publishing",
    "Public / Community Relations",
    "Real Estate/Property Management",
    "Recreation",
    "Restaurants / Food Service",
    "Retail",
    "Semiconductor",
    "Telecommunications",
    "Training/Training Products",
    "Transportation / Shipping"
  ];
  int selectedJobIndex = 0;
  @override
  Widget build(BuildContext context) {
    double textSize =   ref.watch(fontScaling);

    bool colorsDisabledBool = ref.watch(colorsInversion);

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(10), child: AppBar(elevation: 0,
        backgroundColor: Styles.primary,
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Gap(30),
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  const Gap(kTextTabBarHeight-20),
        
             if(FirebaseAuth.instance.currentUser==null)     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Are You A Recruiter?',
                        style: Styles.largeBoldText(context,ref)
                            .copyWith(color: Styles.primary),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return LoginScreen(userType: Strings.userTypeRecruiter);
                          }));
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Styles.orangeColor,
                                borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'Post A Job',
                              style: Styles.largeBoldText(context,ref)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            'Hey,',
                            style: Styles.mediumBoldText(context,ref),
                          ),
                          Text(
                          FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser!.displayName.toString() :  'Guest',
                            style: Styles.largeBoldText(context,ref),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return FirebaseAuth.instance.currentUser==null ? LoginScreen(userType: Strings.userTypeUser) : ProfileScreen();
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 4)),
                          child: ClipOval(
                            child: Image.asset(
                              IconStrings.profile,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if(!kIsWeb)  CarouselSlider.builder(
                    itemCount: images
                        .length, // Adjust the count based on how many items you want to show.
                    itemBuilder: (context, index, realIndex) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: images[index],
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 100.w,
                                  height: 18.h,
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error), // Add an error widget
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
            SizedBox(
              width: 100.w,
              height: 50,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: industry.length,
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
                        industry[index],
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
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
              builder: (context, snapshot) {
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
                              return JobDetailScreen(jobId: snapshot.data!.docs[index].id, companyLogo: snapshot.data!.docs[index]['company_logo'], companyName: snapshot.data!.docs[index]['company_name'], jobName: snapshot.data!.docs[index]['job_name'], jobRole: snapshot.data!.docs[index]['job_name'], jobType: snapshot.data!.docs[0]['job_type'].toString(), totalApplication: snapshot.data!.docs[index]['applicants_uid'], jobDescription: snapshot.data!.docs[index]['company_description'], accessibilityOptions: snapshot.data!.docs[index]['accessibility_measures'], requirementsOptions: snapshot.data!.docs[index]['job_requirements'], cultureOptions: snapshot.data!.docs[index]['job_requirements'], flexibilityOptions: snapshot.data!.docs[index]['flexibility_and_support'], feedbackOptions: snapshot.data!.docs[index]['feedback_and_improvement'], selectedIndustry: snapshot.data!.docs[index]['industry'], selectedLocation: snapshot.data!.docs[index]['location'], uids: snapshot.data!.docs[index]['applicants_uid'],);
                            }));

                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color:colorsDisabledBool? Colors.black : Styles.primary,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Popular Jobs',
                style: Styles.mediumBoldText(context,ref),
              ),
            ),
            const Gap(10),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('jobs').orderBy('applicants_uid',descending: true).snapshots(),
              builder: (context, snapshot) {
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return JobDetailScreen(jobId: snapshot.data!.docs[index].id, companyLogo: snapshot.data!.docs[index]['company_logo'], companyName: snapshot.data!.docs[index]['company_name'], jobName: snapshot.data!.docs[index]['job_name'], jobRole: snapshot.data!.docs[index]['job_name'], jobType: snapshot.data!.docs[0]['job_type'].toString(), totalApplication: snapshot.data!.docs[index]['applicants_uid'], jobDescription: snapshot.data!.docs[index]['company_description'], accessibilityOptions: snapshot.data!.docs[index]['accessibility_measures'], requirementsOptions: snapshot.data!.docs[index]['job_requirements'], cultureOptions: snapshot.data!.docs[index]['job_requirements'], flexibilityOptions: snapshot.data!.docs[index]['flexibility_and_support'], feedbackOptions: snapshot.data!.docs[index]['feedback_and_improvement'], selectedIndustry: snapshot.data!.docs[index]['industry'], selectedLocation: snapshot.data!.docs[index]['location'], uids: snapshot.data!.docs[index]['applicants_uid'],);

                            }));
                            // context.go('/${Routes.bottomNav}/${Routes.jobDetail}');
                          },
                          child: Container(
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
                                      return JobDetailScreen(jobId: snapshot.data!.docs[index].id, companyLogo: snapshot.data!.docs[index]['company_logo'], companyName: snapshot.data!.docs[index]['company_name'], jobName: snapshot.data!.docs[index]['job_name'], jobRole: snapshot.data!.docs[index]['job_name'], jobType: snapshot.data!.docs[0]['job_type'].toString(), totalApplication: snapshot.data!.docs[index]['applicants_uid'], jobDescription: snapshot.data!.docs[index]['company_description'], accessibilityOptions: snapshot.data!.docs[index]['accessibility_measures'], requirementsOptions: snapshot.data!.docs[index]['job_requirements'], cultureOptions: snapshot.data!.docs[index]['job_requirements'], flexibilityOptions: snapshot.data!.docs[index]['flexibility_and_support'], feedbackOptions: snapshot.data!.docs[index]['feedback_and_improvement'], selectedIndustry: snapshot.data!.docs[index]['industry'], selectedLocation: snapshot.data!.docs[index]['location'], uids: snapshot.data!.docs[index]['applicants_uid'],);

                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Styles.orangeColor,
                                        borderRadius: BorderRadius.circular(6)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      'Apply This Job',
                                      style: Styles.smallBoldText(context,ref)
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
