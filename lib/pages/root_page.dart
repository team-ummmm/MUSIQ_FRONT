// import 'package:flutter/material.dart';
// import 'package:musiq_front/pages/answer_page.dart';
// import 'package:musiq_front/style.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage>
//     with TickerProviderStateMixin<RootPage> {
//   // BottomNavigationBar's Tabs
//   static const List<Destination> allDestinations = <Destination>[
//     Destination(0, Icons.question_answer, AppColor.color1),
//     Destination(1, Icons.person, AppColor.color1),
//     Destination(2, Icons.groups, AppColor.color1),
//     Destination(3, Icons.calendar_today, AppColor.color1),
//     Destination(4, Icons.settings, AppColor.color1),
//   ];

//   late final List<GlobalKey<NavigatorState>> navigatorKeys;
//   late final List<GlobalKey> destinationKeys;
//   late final List<AnimationController> destinationFaders;
//   late final List<Widget> destinationViews;
//   int selectedIndex = 0;

//   // 탭 간 이동 시 부드러운 애니메이션
//   AnimationController buildFaderController() {
//     final AnimationController controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 200));
//     controller.addStatusListener((AnimationStatus status) {
//       if (status == AnimationStatus.dismissed) {
//         setState(() {}); // Rebuild unselected destinations offstage.
//       }
//     });
//     return controller;
//   }

//   @override
//   void initState() {
//     super.initState();
//     // navigatorKeys 초기화
//     navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
//         allDestinations.length, (int index) => GlobalKey()).toList();

//     // destinationFaders 초기화
//     destinationFaders = List<AnimationController>.generate(
//         allDestinations.length, (int index) => buildFaderController()).toList();
//     destinationFaders[selectedIndex].value = 1.0;

//     // destinationViews 초기화
//     destinationViews = allDestinations.map((Destination destination) {
//       return FadeTransition(
//         opacity: destinationFaders[destination.index]
//             .drive(CurveTween(curve: Curves.fastOutSlowIn)),
//         child: DestinationView(
//           destination: destination,
//           navigatorKey: navigatorKeys[destination.index],
//         ),
//       );
//     }).toList();
//   }

//   @override
//   void dispose() {
//     for (final AnimationController controller in destinationFaders) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         final NavigatorState navigator =
//             navigatorKeys[selectedIndex].currentState!;
//         if (!navigator.canPop()) {
//           return true;
//         }
//         navigator.pop();
//         return false;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           top: false,
//           child: Stack(
//             fit: StackFit.expand,
//             children: allDestinations.map((Destination destination) {
//               final int index = destination.index;
//               final Widget view = destinationViews[index];
//               if (index == selectedIndex) {
//                 destinationFaders[index].forward();
//                 return Offstage(offstage: false, child: view);
//               } else {
//                 destinationFaders[index].reverse();
//                 if (destinationFaders[index].isAnimating) {
//                   return IgnorePointer(child: view);
//                 }
//                 return Offstage(child: view);
//               }
//             }).toList(),
//           ),
//         ),
//         bottomNavigationBar: NavigationBar(
//           selectedIndex: selectedIndex,
//           onDestinationSelected: (int index) {
//             setState(() {
//               selectedIndex = index;
//             });
//           },
//           destinations: allDestinations.map((Destination destination) {
//             return NavigationDestination(
//               icon: Icon(destination.icon, color: destination.color),
//               label: "",
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// class Destination {
//   const Destination(this.index, this.icon, this.color);
//   final int index;
//   final IconData icon;
//   final Color color;
// }

// class DestinationView extends StatefulWidget {
//   const DestinationView({
//     super.key,
//     required this.destination,
//     required this.navigatorKey,
//   });

//   final Destination destination;
//   final Key navigatorKey;

//   @override
//   State<DestinationView> createState() => _DestinationViewState();
// }

// class _DestinationViewState extends State<DestinationView> {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: widget.navigatorKey,
//       onGenerateRoute: (RouteSettings settings) {
//         return MaterialPageRoute<void>(
//           settings: settings,
//           builder: (BuildContext context) {
//             switch (settings.name) {
//               case '/':
//                 return AnswerPage(destination: widget.destination);
//               case '/list':
//                 return (destination: widget.destination);
//               case '/text':
//                 return TextPage(destination: widget.destination);
//             }
//             assert(false);
//             return const SizedBox();
//           },
//         );
//       },
//     );
//   }
// }
