import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/home/presentation/view/home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key , this.appBar});
  final PreferredSizeWidget? appBar; 

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    // CalendarScreen(),
    // FocusScreen(),
    // ProfileScreen(),
    Container(color: Colors.red),  
    Container(color: Colors.green), 
    Container(color: Colors.blue),  
  ];

  Widget _buildIcon(String assetPath, bool isSelected) {
    return SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.secondColor : AppColors.whiteColor,  
        BlendMode.srcIn,  
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: widget.appBar,
      body: _screens[_currentIndex],
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: AppColors.secondColor,
          child: Icon(Icons.add, color: AppColors.whiteColor, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomAppBar(
        color: AppColors.mediumGrey,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(Assets.assetsIconsHome, _currentIndex == 0),
                    Text(
                      AppStrings.home, style: AppTextStyles.regular16.copyWith(
                        color: _currentIndex == 0
                          ? AppColors.secondColor
                          : AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(Assets.assetsIconsCalendar, _currentIndex == 1),
                    Text(
                      AppStrings.calendar, style: AppTextStyles.regular16.copyWith(
                        color: _currentIndex == 1
                        ? AppColors.secondColor
                        : AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 64),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(Assets.assetsIconsClock, _currentIndex == 2),
                    Text(
                      AppStrings.focus, style: AppTextStyles.regular16.copyWith(
                        color: _currentIndex == 2
                        ? AppColors.secondColor
                        : AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(Assets.assetsIconsUser, _currentIndex == 3),
                    Text(
                      AppStrings.profile, style: AppTextStyles.regular16.copyWith(
                        color: _currentIndex == 3
                        ? AppColors.secondColor
                        : AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}