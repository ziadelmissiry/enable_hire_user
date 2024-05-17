import 'package:enable_hire_user/utils/strings/firebase_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompanyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseStrings.usersCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(FirebaseStrings.companiesCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var companyData = snapshot.data!.data() as Map<String, dynamic>;
          String companyName = companyData['companyName'];
          String companyDescription = companyData['companyDescription'];
          String companyLogoUrl = companyData['companyLogo'];

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(companyLogoUrl),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Company Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Company Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  companyDescription,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
