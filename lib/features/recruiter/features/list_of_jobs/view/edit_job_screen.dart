import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditJobScreen extends StatefulWidget {
  final String jobId;

  const EditJobScreen({Key? key, required this.jobId}) : super(key: key);

  @override
  _EditJobScreenState createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  List<String> accessibilityOptions = [];
  List<String> requirementsOptions = [];
  List<String> cultureOptions = [];
  List<String> flexibilityOptions = [];
  List<String> feedbackOptions = [];
  List<String> jobTypeOptions = [];
  String? selectedIndustry;
  String? selectedLocation;

  late TextEditingController jobNameController;
  late TextEditingController jobDescriptionController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchJobData();
  }

  Future<void> _fetchJobData() async {
    setState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot jobSnapshot = await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).get();

      jobNameController = TextEditingController(text: jobSnapshot.get('job_name'));
      jobDescriptionController = TextEditingController(text: jobSnapshot.get('company_description'));
      accessibilityOptions = List<String>.from(jobSnapshot.get('accessibility_measures'));
      requirementsOptions = List<String>.from(jobSnapshot.get('job_requirements'));
      cultureOptions = List<String>.from(jobSnapshot.get('company_culture_and_diversity'));
      flexibilityOptions = List<String>.from(jobSnapshot.get('flexibility_and_support'));
      feedbackOptions = List<String>.from(jobSnapshot.get('feedback_and_improvement'));
      jobTypeOptions = List<String>.from(jobSnapshot.get('job_type'));
      selectedIndustry = jobSnapshot.get('industry');
      selectedLocation = jobSnapshot.get('location');

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching job data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Job'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildTextField('Job Name', Icons.work, jobNameController),
              const SizedBox(height: 10),
              _buildTextField('Job Description', Icons.description, jobDescriptionController, maxLines: 5),
              _buildQuestion('Accessibility Measures', [
                "Accessible Facilities",
                "Accommodations Provided",
                "Willing to Accommodate",
                "Not Sure"
              ], accessibilityOptions),
              _buildQuestion('Job Requirements', [
                "Physical Demands Specified",
                "Accommodations Needed",
                "No Specific Demands",
                "Not Sure"
              ], requirementsOptions),
              _buildQuestion('Company Culture and Diversity', [
                "Inclusive Environment",
                "Disability Awareness Training",
                "Not Sure"
              ], cultureOptions),
              _buildQuestion('Flexibility and Support', [
                "Flexible Hours",
                "Remote Work Options",
                "Career Development Support",
                "Not Sure"
              ], flexibilityOptions),
              _buildQuestion('Feedback and Improvement', [
                "Open to Feedback",
                "Continuous Improvement",
                "Not Sure"
              ], feedbackOptions),
              SizedBox(height: 20),
              _buildFilter('Job Type', [
                "Full-Time",
                "Part-Time",
                "Contract",
                "Temporary",
                "Temporary-to-Hire",
                "Internship",
                "Volunteer"
              ], jobTypeOptions),
              _buildIndustryFilter(),
              _buildLocationFilter(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateJobData();
                },
                child: Text('Update Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateJobData() async {
    setState(() {
      isLoading = true;
    });

    var firebaseFirestore = FirebaseFirestore.instance;

    try {
      await firebaseFirestore.collection('jobs').doc(widget.jobId).update(
        {
          'job_name': jobNameController.text,
          'company_description': jobDescriptionController.text,
          // Update other job data fields similarly
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Job updated successfully')));
      setState(() {
        isLoading = false;
      });
      // Navigate back to previous screen or perform other actions
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error updating job data: $e');
    }
  }

  Widget _buildQuestion(String question, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedOptions.contains(option),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedOptions.add(option);
                  } else {
                    selectedOptions.remove(option);
                  }
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFilter(String title, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedOptions.contains(option),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedOptions.add(option);
                  } else {
                    selectedOptions.remove(option);
                  }
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField(String labelText, IconData icon, TextEditingController controller, {int? maxLines}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: labelText,
          icon: icon != null ? Icon(icon, color: Colors.blue) : null,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildIndustryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Industry',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (var option in [
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
            ])
              ChoiceChip(
                label: Text(option),
                selected: selectedIndustry == option,
                onSelected: (selected) {
                  setState(() {
                    selectedIndustry = selected ? option : null;
                  });
                },
              ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLocationFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Location',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              label: Text('London'),
              selected: selectedLocation == 'London',
              onSelected: (selected) {
                setState(() {
                  selectedLocation = selected ? 'London' : null;
                });
              },
            ),
            ChoiceChip(
              label: Text('Manchester'),
              selected: selectedLocation == 'Manchester',
              onSelected: (selected) {
                setState(() {
                  selectedLocation = selected ? 'Manchester' : null;
                });
              },
            ),
            ChoiceChip(
              label: Text('Birmingham'),
              selected: selectedLocation == 'Birmingham',
              onSelected: (selected) {
                setState(() {
                  selectedLocation = selected ? 'Birmingham' : null;
                });
              },
            ),
            ChoiceChip(
              label: Text('Leeds'),
              selected: selectedLocation == 'Leeds',
              onSelected: (selected) {
                setState(() {
                  selectedLocation = selected ? 'Leeds' : null;
                });
              },
            ),
            // Add more location options here
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
