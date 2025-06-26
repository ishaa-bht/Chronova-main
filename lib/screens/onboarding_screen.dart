// // import 'package:flutter/material.dart';
// // import '../utils/colors.dart';
// // import '../utils/styles.dart';
// // import 'main_screen.dart';
// //
// // class OnboardingScreen extends StatefulWidget {
// //   @override
// //   _OnboardingScreenState createState() => _OnboardingScreenState();
// // }
// //
// // class _OnboardingScreenState extends State<OnboardingScreen> {
// //   PageController _pageController = PageController();
// //   int _currentPage = 0;
// //
// //   final List<OnboardingData> _pages = [
// //     OnboardingData(
// //       title: "Explore History",
// //       description: "Discover ancient temples, monuments, and historical sites around you with detailed information and stories.",
// //       icon: Icons.explore,
// //       color: AppColors.primaryBrown,
// //     ),
// //     OnboardingData(
// //       title: "AR Experience",
// //       description: "Use augmented reality to see historical sites come alive with interactive 3D models and animations.",
// //       icon: Icons.camera_alt,
// //       color: AppColors.goldAccent,
// //     ),
// //     OnboardingData(
// //       title: "Save Favorites",
// //       description: "Mark your favorite places, create collections, and plan your historical exploration journey.",
// //       icon: Icons.favorite,
// //       color: AppColors.lightBrown,
// //     ),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: PageView.builder(
// //                 controller: _pageController,
// //                 onPageChanged: (int page) {
// //                   setState(() {
// //                     _currentPage = page;
// //                   });
// //                 },
// //                 itemCount: _pages.length,
// //                 itemBuilder: (context, index) {
// //                   return Padding(
// //                     padding: EdgeInsets.all(40.0),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Container(
// //                           width: 200,
// //                           height: 200,
// //                           decoration: BoxDecoration(
// //                             color: _pages[index].color.withOpacity(0.1),
// //                             shape: BoxShape.circle,
// //                           ),
// //                           child: Icon(
// //                             _pages[index].icon,
// //                             size: 80,
// //                             color: _pages[index].color,
// //                           ),
// //                         ),
// //                         SizedBox(height: 50),
// //                         Text(
// //                           _pages[index].title,
// //                           style: AppStyles.headingLarge.copyWith(
// //                             color: _pages[index].color,
// //                           ),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                         SizedBox(height: 20),
// //                         Text(
// //                           _pages[index].description,
// //                           style: AppStyles.bodyText,
// //                           textAlign: TextAlign.center,
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(20),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: List.generate(
// //                       _pages.length,
// //                           (index) => Container(
// //                         margin: EdgeInsets.symmetric(horizontal: 4),
// //                         width: _currentPage == index ? 30 : 8,
// //                         height: 8,
// //                         decoration: BoxDecoration(
// //                           color: _currentPage == index
// //                               ? AppColors.primaryBrown
// //                               : Colors.grey.withOpacity(0.3),
// //                           borderRadius: BorderRadius.circular(4),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 30),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       TextButton(
// //                         onPressed: _currentPage == 0 ? null : () {
// //                           _pageController.previousPage(
// //                             duration: Duration(milliseconds: 300),
// //                             curve: Curves.easeInOut,
// //                           );
// //                         },
// //                         child: Text(
// //                           'Back',
// //                           style: TextStyle(
// //                             color: _currentPage == 0
// //                                 ? Colors.transparent
// //                                 : AppColors.primaryBrown,
// //                             fontSize: 16,
// //                           ),
// //                         ),
// //                       ),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           if (_currentPage == _pages.length - 1) {
// //                             Navigator.pushReplacement(
// //                               context,
// //                               MaterialPageRoute(builder: (context) => MainScreen()),
// //                             );
// //                           } else {
// //                             _pageController.nextPage(
// //                               duration: Duration(milliseconds: 300),
// //                               curve: Curves.easeInOut,
// //                             );
// //                           }
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.primaryBrown,
// //                           foregroundColor: Colors.white,
// //                           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(25),
// //                           ),
// //                           elevation: 5,
// //                         ),
// //                         child: Text(
// //                           _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
// //                           style: AppStyles.buttonText,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class OnboardingData {
// //   final String title;
// //   final String description;
// //   final IconData icon;
// //   final Color color;
// //
// //   OnboardingData({
// //     required this.title,
// //     required this.description,
// //     required this.icon,
// //     required this.color,
// //   });
// // }
//
// // Add this new file or extend your existing OnboardingScreen with animated splash ideas
//
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import '../utils/colors.dart';
// import '../utils/styles.dart';
// import 'main_screen.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen>
//     with SingleTickerProviderStateMixin {
//   PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   late AnimationController _animationController;
//   late Animation<double> _rippleAnimation;
//
//   final List<OnboardingData> _pages = [
//     OnboardingData(
//       title: "Your Virtual Tour Guide",
//       description:
//       "Navigate and discover the world like never before — guided by Chronova.",
//       widget: TimeRippleWidget(),
//     ),
//     OnboardingData(
//       title: "Reach the Unknown Spot",
//       description:
//       "Zoom into hidden gems with AR — see the invisible, go the unreachable.",
//       widget: ARLensWidget(),
//     ),
//     OnboardingData(
//       title: "Explore Places with Chronova",
//       description:
//       "Follow stories and places across time — unlock history one place at a time.",
//       widget: StoryMapWidget(),
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 4),
//     )..repeat(reverse: true);
//     _rippleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (int page) {
//                   setState(() {
//                     _currentPage = page;
//                   });
//                 },
//                 itemCount: _pages.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.all(30.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AnimatedBuilder(
//                           animation: _rippleAnimation,
//                           builder: (context, child) => Transform.scale(
//                             scale: _rippleAnimation.value,
//                             child: _pages[index].widget,
//                           ),
//                         ),
//                         SizedBox(height: 50),
//                         Shimmer.fromColors(
//                           baseColor: Colors.black87,
//                           highlightColor: Colors.grey.shade400,
//                           child: Text(
//                             _pages[index].title,
//                             style: AppStyles.headingLarge,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           _pages[index].description,
//                           style: AppStyles.bodyText,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       _pages.length,
//                           (index) => Container(
//                         margin: EdgeInsets.symmetric(horizontal: 4),
//                         width: _currentPage == index ? 30 : 8,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: _currentPage == index
//                               ? AppColors.primaryBrown
//                               : Colors.grey.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: _currentPage == 0
//                             ? null
//                             : () => _pageController.previousPage(
//                           duration: Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         ),
//                         child: Text(
//                           'Back',
//                           style: TextStyle(
//                             color: _currentPage == 0
//                                 ? Colors.transparent
//                                 : AppColors.primaryBrown,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_currentPage == _pages.length - 1) {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => MainScreen()),
//                             );
//                           } else {
//                             _pageController.nextPage(
//                               duration: Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryBrown,
//                           foregroundColor: Colors.white,
//                           padding:
//                           EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           elevation: 5,
//                         ),
//                         child: Text(
//                           _currentPage == _pages.length - 1
//                               ? 'Get Started'
//                               : 'Next',
//                           style: AppStyles.buttonText,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OnboardingData {
//   final String title;
//   final String description;
//   final Widget widget;
//
//   OnboardingData({
//     required this.title,
//     required this.description,
//     required this.widget,
//   });
// }
//
// // === Splash Widgets ===
//
// class TimeRippleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 90,
//       backgroundColor: AppColors.primaryBrown.withOpacity(0.1),
//       child: Icon(Icons.access_time, size: 60, color: AppColors.primaryBrown),
//     );
//   }
// }
//
// class ARLensWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 90,
//       backgroundColor: AppColors.goldAccent.withOpacity(0.1),
//       child: Icon(Icons.travel_explore,
//           size: 60, color: AppColors.goldAccent),
//     );
//   }
// }
//
// class StoryMapWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 90,
//       backgroundColor: AppColors.lightBrown.withOpacity(0.1),
//       child: Icon(Icons.map, size: 60, color: AppColors.lightBrown),
//     );
//   }
// }

// Add this new file or extend your existing OnboardingScreen with animated splash ideas

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _animationController;
  late Animation<double> _rippleAnimation;
  bool _shimmerPlayed = false;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Your Virtual Tour Guide",
      description:
      "Navigate and discover the world like never before — guided by Chronova.",
      imagePath: 'assets/images/1.png',
    ),
    OnboardingData(
      title: "Reach the Unknown Spot",
      description:
      "Zoom into hidden gems with AR — see the invisible, go the unreachable.",
      imagePath: 'assets/images/2.png',
    ),
    OnboardingData(
      title: "Explore Places with Chronova",
      description:
      "Follow stories and places across time — unlock history one place at a time.",
      imagePath: 'assets/images/3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rippleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward().whenComplete(() {
      setState(() {
        _shimmerPlayed = true;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _rippleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: _rippleAnimation.value,
                            child: Image.asset(
                              _pages[index].imagePath,
                              height: 280,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        _shimmerPlayed
                            ? Text(
                          _pages[index].title,
                          style: AppStyles.headingLarge,
                          textAlign: TextAlign.center,
                        )
                            : Shimmer.fromColors(
                          baseColor: Colors.black87,
                          highlightColor: Colors.grey.shade400,
                          child: Text(
                            _pages[index].title,
                            style: AppStyles.headingLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _pages[index].description,
                          style: AppStyles.bodyText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 30 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primaryBrown
                              : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _currentPage == 0
                            ? null
                            : () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: _currentPage == 0
                                ? Colors.transparent
                                : AppColors.primaryBrown,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _pages.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBrown,
                          foregroundColor: Colors.white,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: AppStyles.buttonText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
