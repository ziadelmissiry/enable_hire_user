import 'package:enable_hire_user/features/home/view/home_screen.dart';
import 'package:enable_hire_user/features/job/view/my_jobs.dart';
import 'package:enable_hire_user/features/profile/view/profile_screen.dart';
import 'package:enable_hire_user/features/search/view/search_screen.dart';
import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/icon_strings.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../disability/view/disabilityui.dart';

class BottomNavScreen extends ConsumerStatefulWidget {
  const BottomNavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavScreenState();
}

class _BottomNavScreenState extends ConsumerState<BottomNavScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DisabilityFilterDialog(
              onApply: (filters) {
                // Handle applying filters here
                print(filters);
              },
            );
          },
        );
      },
        backgroundColor: Styles.primary,
        child: const Icon(Icons.wheelchair_pickup,color: Colors.white,),
        
      
      ),
      body: _buildBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 100,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        unselectedLabelStyle: Styles.mediumText(context,ref)
            .copyWith(fontSize: 14, color: Colors.black),
        selectedLabelStyle: Styles.mediumText(context,ref)
            .copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              IconStrings.home,
              height: 25,
              color: _currentIndex == 0
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconStrings.search,
              height: 25,
              color: _currentIndex == 1
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconStrings.save,
              height: 25,
              color: _currentIndex == 2
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconStrings.profile,
              height: 25,
              color: _currentIndex == 3
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return MyJobs();
      case 3:
        return  ProfileScreen();
      default:
        return Container();
    }
  }
}
