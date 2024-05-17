import 'package:flutter/material.dart';

class FiltersBottomSheet extends StatefulWidget {
  @override
  _FiltersBottomSheetState createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  List<String> _selectedJobTypes = [];
  List<String> _selectedIndustries = [];
  List<String> _selectedJobFunctions = [];
  List<String> _selectedWorkplaceTypes = [];
  List<String> _selectedLocations = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Filters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildFilterGroup('Job Type', _selectedJobTypes, [
              "Full-Time",
              "Part-Time",
              "Contract",
              "Temporary",
              "Temporary-to-Hire",
              "Internship",
              "Volunteer"
            ]),
            _buildFilterGroup('Industry', _selectedIndustries, [
              "Advertising / Marketing",
              "Agricultural",
              "Airline/Aerospace/Aviation",
              "Apparel/Textiles",
              // Add more industry options...
              "Transportation / Shipping"
            ]),
            _buildFilterGroup('Job Function', _selectedJobFunctions, [
              "Other",
              "Accounting/Finance",
              "Administrative Support",
              // Add more job function options...
              "Transportation"
            ]),
            _buildFilterGroup('Workplace Type', _selectedWorkplaceTypes, [
              "On-Site",
              "Hybrid",
              "Remote",
            ]),
            _buildFilterGroup('Location', _selectedLocations, [
              "London",
              "Manchester",
              "Birmingham",
              "Leeds",
              "Liverpool"
            ]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Apply filters
                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterGroup(
      String title, List<String> selectedOptions, List<String> options) {
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
            return FilterChip(
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
}