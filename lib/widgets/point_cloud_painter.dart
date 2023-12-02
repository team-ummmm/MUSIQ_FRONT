// import 'package:flutter/material.dart';
// import 'package:musiq_front/style.dart';

// class PointCloudPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Draw planes for each axis
//     _drawPlane(canvas, size, Colors.blue.withOpacity(0.1), 0.25); // Danceability plane
//     _drawPlane(canvas, size, Colors.green.withOpacity(0.1), 0.75); // Energy plane
//     _drawPlane(canvas, size, Colors.red.withOpacity(0.1), 0.5); // Valence plane

//     var paint = Paint()..style = PaintingStyle.fill;

//     // Draw points
//     for (int i = 0; i < 8; i++) {
//       double danceability = (i & 4) == 0 ? 0.25 : 0.75;
//       double energy = (i & 2) == 0 ? 0.25 : 0.75;
//       double valence = (i & 1) == 0 ? 0.25 : 0.75;

//       Offset point = Offset(
//         size.width * 0.5 + (danceability - 0.5) * size.width * 0.4 + (valence - 0.5) * size.width * 0.2,
//         size.height * 0.5 + (energy - 0.5) * size.height * 0.4 - (valence - 0.5) * size.height * 0.2,
//       );
//       paint.color = AppColor.colorList[i];
//       canvas.drawCircle(point, 10, paint);
//     }

//     // Draw Axes
//     paint
//       ..color = Colors.black
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     // X axis (Danceability)
//     canvas.drawLine(
//       Offset(size.width * 0.1, size.height * 0.5),
//       Offset(size.width * 0.9, size.height * 0.5),
//       paint,
//     );
//     // Y axis (Energy)
//     canvas.drawLine(
//       Offset(size.width * 0.5, size.height * 0.1),
//       Offset(size.width * 0.5, size.height * 0.9),
//       paint,
//     );
//     // Z axis (Valence)
//     canvas.drawLine(
//       Offset(size.width * 0.5, size.height * 0.5),
//       Offset(size.width * 0.7, size.height * 0.3),
//       paint,
//     );

//     // Draw Axes labels
//     _drawText(canvas, 'Danceability', Offset(size.width * 0.9, size.height * 0.5));
//     _drawText(canvas, 'Energy', Offset(size.width * 0.5, size.height * 0.1));
//     _drawText(canvas, 'Valence', Offset(size.width * 0.7, size.height * 0.3));
//   }

//   void _drawPlane(Canvas canvas, Size size, Color color, double value) {
//     var paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     double x = size.width * 0.5 + (value - 0.5) * size.width * 0.4;
//     double y = size.height * 0.5 + (value - 0.5) * size.height * 0.4;

//     var rect = Rect.fromLTWH(x - size.width * 0.2, y - size.height * 0.2, size.width * 0.4, size.height * 0.4);
//     canvas.drawRect(rect, paint);
//   }

//   void _drawText(Canvas canvas, String text, Offset position) {
//     final textSpan = TextSpan(
//       text: text,
//       style: const TextStyle(color: Colors.black, fontSize: 12),
//     );
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout(minWidth: 0, maxWidth: double.infinity);
//     textPainter.paint(canvas, position);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
