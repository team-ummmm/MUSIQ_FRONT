// import 'package:flutter/material.dart';
// import 'package:flutter_cube/flutter_cube.dart';

// class CubePainter extends StatefulWidget {
//   const CubePainter({super.key});

//   @override
//   _CubePainterState createState() => _CubePainterState();
// }

// class _CubePainterState extends State<CubePainter> {
//   late Object cube;

//   @override
//   void initState() {
//     super.initState();
//     cube = Object(
//       scale: Vector3.all(6),
//       fileName: 'assets/cube/8.obj', // .obj 파일 경로
//       lighting: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: (details) {
//         setState(() {
//           cube.rotation.y -= details.delta.dx * 0.01;
//           cube.rotation.x -= details.delta.dy * 0.01;
//         });
//       },
//       child: Cube(
//         onSceneCreated: (Scene scene) {
//           scene.world.add(cube);
//           scene.light.diffuse;
//         },
//       ),
//     );
//   }
// }
