import 'package:enable_hire_user/features/auth/repositry/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/widgets/my_custom_button.dart';

class CreateResumeScreen extends ConsumerStatefulWidget {
  const CreateResumeScreen({Key? key}) : super(key: key);

  @override
  _CreateResumeScreenState createState() => _CreateResumeScreenState();
}

class _CreateResumeScreenState extends ConsumerState<CreateResumeScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _skillController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyRoleController = TextEditingController();
  List<String> _companies = [];
  List<String> _hobbies = [];
  List<String> _skills = [];
  List<Map<String, String>> companies = [{}];
  List<Map<String, dynamic>> _educationList = [{}];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController.text = FirebaseAuth.instance.currentUser?.displayName ?? '';
    _emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Resume'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            TextFormField(
              controller: _positionController,
              decoration: const InputDecoration(
                labelText: 'Desired Position',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            TextFormField(
              controller: _contactController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            _buildMultipleInput(
              title: 'Companies Worked At',
              controller: _companyNameController,
              roleController: _companyRoleController,
              items: _companies,
              onChanged: (value) {
                setState(() {
                  if(_companyNameController.text!='' && _companyRoleController.text!=''){
                    _companies.add(value);
                    companies.add({
                      'companyName': _companyNameController.text,
                      'companyRole': _companyRoleController.text,
                    });
                    _companyNameController.clear();
                    _companyRoleController.clear();
                  }

                });
              },
            ),
            const Gap(20),
            _buildMultipleInput(
              title: 'Hobbies',
              controller: TextEditingController(),
              items: _hobbies,
              onChanged: (value) {
                setState(() {
                  _hobbies.add(value);
                });
              }, roleController: TextEditingController(),
            ),
            const Gap(20),
            _buildSkillList(),
            const Gap(20),
            TextFormField(
              controller: _experienceController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Experience',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            _buildEducationList(),
            const Gap(20),
            TextFormField(
              controller: _experienceController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'About Yourself',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                child: MyCustomButton(
                  label: 'Save Resume',
                  onPressed: () {
                    AuthRepo().saveResumeToFireStore(name: _nameController.text, desiredPosition: _positionController.text, contactNumber: _contactController.text, email: _emailController.text, companies: companies, hobbies: _hobbies, skills: _skills, experience: _experienceController.text, educationList: _educationList, context: context, ref: ref);
                    // Handle save resume action
                  },
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleInput({
    required String title,
    required TextEditingController controller,
    required TextEditingController roleController,
    required List<String> items,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.mediumBoldText(context,ref),
        ),
        const Gap(10),
        Wrap(
          spacing: 10,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () {
                setState(() {
                  items.remove(item);
                });
              },
            );
          }).toList(),
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: TextFormField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Job Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onChanged(controller.text);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Styles.mediumBoldText(context,ref),
        ),
        const Gap(10),
        Wrap(
          spacing: 10,
          children: _skills.map((skill) {
            return Chip(
              label: Text(skill),
              onDeleted: () {
                setState(() {
                  _skills.remove(skill);
                });
              },
            );
          }).toList(),
        ),
        const Gap(10),
        // DropdownButtonFormField<String>(
        //   decoration: const InputDecoration(
        //     labelText: 'Select Skill',
        //     border: OutlineInputBorder(),
        //   ),
        //   value: null,
        //   onChanged: (String? value) {
        //     if (value != null && value.isNotEmpty) {
        //       setState(() {
        //         _skills.add(value);
        //       });
        //     }
        //   },
        //   items: [
        //     'Flutter',
        //     'Dart',
        //     'Firebase',
        //     'UI/UX Design',
        //     'Responsive Design',
        //     'Git',
        //   ].map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList()
        //     ..add(
        //       const DropdownMenuItem<String>(
        //         value: 'Other',
        //         child: Text('Other'),
        //       ),
        //     ),
        // ),
        // const Gap(10),
        TextFormField(
          controller: _skillController,
          decoration: InputDecoration(
            labelText: 'Add Skill',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(onPressed: () {
              if (_skillController.text.isNotEmpty) {
                setState(() {
                  _skills.add(_skillController.text);
                  _skillController.clear();
                });
              }
            }, icon: const Icon(Icons.add)),
          ),
        ),
      ],
    );
  }

  Widget _buildEducationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: Styles.mediumBoldText(context,ref),
        ),
        const Gap(10),
        Column(
          children: _educationList.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> education = entry.value;
            TextEditingController schoolController = TextEditingController();
            TextEditingController degreeController = TextEditingController();
            TextEditingController startDateController = TextEditingController();
            TextEditingController endDateController = TextEditingController();

            schoolController.text = education['school'] ?? '';
            degreeController.text = education['degree'] ?? '';
            startDateController.text = education['startDate'] ?? '';
            endDateController.text = education['endDate'] ?? '';

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: schoolController,
                      decoration: const InputDecoration(
                        labelText: 'School/College',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _educationList[index]['school'] = value;
                        });
                      },
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: degreeController,
                      decoration: const InputDecoration(
                        labelText: 'Degree',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _educationList[index]['degree'] = value;
                        });
                      },
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: startDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      startDateController.text = selectedDate.toString();
                                      _educationList[index]['startDate'] = selectedDate.toString();
                                    });
                                  }
                                },
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: endDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'End Date',
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      endDateController.text = selectedDate.toString();
                                      _educationList[index]['endDate'] = selectedDate.toString();
                                    });
                                  }
                                },
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const Gap(10),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _educationList.add({});
              });
            },
          ),
        ),
      ],
    );
  }
}
