import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/strings/firebase_strings.dart';
import '../../../utils/utils.dart';

class CreateJobScreen extends ConsumerStatefulWidget {
  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends ConsumerState<CreateJobScreen> {
  List<String> accessibilityOptions = [];
  List<String> requirementsOptions = [];
  List<String> cultureOptions = [];
  List<String> flexibilityOptions = [];
  List<String> feedbackOptions = [];
  List<String> jobTypeOptions = [];
  String? selectedIndustry;
  String? selectJobFunction;
  String? selectedLocation;

  TextEditingController jobNameController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();

  void _saveJobData() async {
    if (_validateInputs()) {
      var firebaseFirestore = FirebaseFirestore.instance;
      ref.read(isLoadingProvider.notifier).state = true;

      try {
        var companyCollection = await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection(FirebaseStrings.companiesCollection).doc(FirebaseAuth.instance.currentUser!.uid).get();
        String companyName = await companyCollection.get('companyName');
        String companyLogo = await companyCollection.get('companyLogo');

        await firebaseFirestore.collection('jobs').add({
          'job_name': jobNameController.text,
          'uploader_id': FirebaseAuth.instance.currentUser!.uid,
          'company_name': companyName,
          'company_logo': companyLogo,
          'company_description': jobDescriptionController.text,
          'accessibility_measures': accessibilityOptions,
          'job_requirements': requirementsOptions,
          'company_culture_and_diversity': cultureOptions,
          'flexibility_and_support': flexibilityOptions,
          'feedback_and_improvement': feedbackOptions,
          'job_type': jobTypeOptions,
          'industry': selectedIndustry,
          'job_function': selectJobFunction,
          'applicants_uid': [],
          'location': selectedLocation,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Job created successfully')));
        ref.read(isLoadingProvider.notifier).state = false;

        // Navigate to the next screen or perform other actions
      } catch (e) {
        ref.read(isLoadingProvider.notifier).state = false;
        print('Error saving job data: $e');
      }
    }
  }

  bool _validateInputs() {
    if (jobNameController.text.isEmpty) {
      _showErrorMessage('Please enter the Job Name');
      return false;
    }
    if (jobDescriptionController.text.isEmpty) {
      _showErrorMessage('Please enter the Job Description');
      return false;
    }
    if (selectedIndustry == null) {
      _showErrorMessage('Please select an Industry');
      return false;
    }
    if (selectJobFunction == null) {
      _showErrorMessage('Please select a Job Function');
      return false;
    }
    if (selectedLocation == null) {
      _showErrorMessage('Please select a Location');
      return false;
    }
    return true;
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: ref.watch(isLoadingProvider),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildTextField('Job Name', Icons.work, jobNameController),
              const SizedBox(height: 10),
              _buildTextField('Job Description', Icons.description, jobDescriptionController, maxLines: 5),
              const SizedBox(height: 10),
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
              _buildJobFunctionFilter(),
              _buildLocationFilter(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveJobData,
                child: Text('Save Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFilter(String title, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 20),
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
        const Text(
          'Industry',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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

  Widget _buildJobFunctionFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Job Function',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            for (var option in [
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
              "Transportation"
            ])
              ChoiceChip(
                label: Text(option),
                selected: selectJobFunction == option,
                onSelected: (selected) {
                  setState(() {
                    selectJobFunction = selected ? option : null;
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
