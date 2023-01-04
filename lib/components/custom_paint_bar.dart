import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonNotch extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dotPoint = Offset(size.width / 2,2);

    var paint_1 = Paint()
      ..color = dashboardBackground
      ..style = PaintingStyle.fill;
    var paint_2 = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(7.5, 0, 12, 5);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width - 12, 5);
    path.quadraticBezierTo(size.width - 7.5, 0, size.width, 0);
    path.close();
    canvas.drawPath(path, paint_1);
    canvas.drawCircle(dotPoint, 8, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TopNotch extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dotPoint = Offset(size.width, 2);

    var paint_1 = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill;
    var paint_2 = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(7.5, 0, 12, 5);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width - 12, 5);
    path.quadraticBezierTo(size.width - 7.5, 0, size.width, 0);
    path.close();
    canvas.drawPath(path, paint_1);
    canvas.drawCircle(dotPoint, 6, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6588005, size.height * 0.7325395);
    path_0.cubicTo(
        size.width * 0.6575252,
        size.height * 0.7325395,
        size.width * 0.6563830,
        size.height * 0.7324700,
        size.width * 0.6553601,
        size.height * 0.7323310);
    path_0.lineTo(size.width * 0.06880734, size.height * 0.7323310);
    path_0.arcToPoint(Offset(0, size.height * 0.6165004),
        radius:
            Radius.elliptical(size.width * 0.06880734, size.height * 0.1158306),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.7323310);
    path_0.lineTo(size.width, size.height * 0.7323310);
    path_0.cubicTo(
        size.width * 0.8591628,
        size.height * 0.7324700,
        size.width * 0.8582271,
        size.height * 0.7325395,
        size.width * 0.8571789,
        size.height * 0.7325395);
    path_0.cubicTo(
        size.width * 0.8198326,
        size.height * 0.7325395,
        size.width * 0.8024977,
        size.height * 0.8223970,
        size.width * 0.7630734,
        size.height * 0.8223970);
    path_0.cubicTo(
        size.width * 0.7236491,
        size.height * 0.8223970,
        size.width * 0.7042202,
        size.height * 0.7325395,
        size.width * 0.6588005,
        size.height * 0.7325395);
    path_0.close();
/*
    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.002293578;
    paint_0_stroke.color = Colors.blue.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_stroke);*/

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff009ade).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    /* Path path_1 = Path();
    path_1.moveTo(size.width * 0.03551835, size.height * 0.08301190);
    path_1.arcToPoint(Offset(size.width * 0.03384404, size.height * 0.08199646),
        radius: Radius.elliptical(
            size.width * 0.002614679, size.height * 0.004401561),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.01814220, size.height * 0.05992687);
    path_1.arcToPoint(Offset(size.width * 0.02149083, size.height * 0.05313534),
        radius: Radius.elliptical(
            size.width * 0.002621560, size.height * 0.004413144),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.03551606, size.height * 0.07289217);
    path_1.lineTo(size.width * 0.04954128, size.height * 0.05384191);
    path_1.arcToPoint(Offset(size.width * 0.05286468, size.height * 0.06094232),
        radius: Radius.elliptical(
            size.width * 0.002685780, size.height * 0.004521253),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path_1.lineTo(size.width * 0.03715596, size.height * 0.08223970);
    path_1.arcToPoint(Offset(size.width * 0.03551835, size.height * 0.08301190),
        radius: Radius.elliptical(
            size.width * 0.002614679, size.height * 0.004401561),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.close();*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
