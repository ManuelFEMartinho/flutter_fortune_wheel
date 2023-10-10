// ignore_for_file: curly_braces_in_flow_control_structures

part of 'wheel.dart';

class _CircleSlicePainterWithValue extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;
  final double strokeWidth;
  final double angle;
  final int? value;
  final Color softColor;
  final Color lightColor;
  final double radius;
  final int itemIndex;
  final int itemCount;
  final int selectedItemIndex;
  final String valueText;

  const _CircleSlicePainterWithValue({
    required this.fillColor,
    this.strokeColor,
    this.strokeWidth = 1,
    this.angle = _math.pi / 2,
    this.value,
    required this.itemIndex,
    required this.selectedItemIndex,
    required this.itemCount,
    required this.radius,
    required this.valueText,
    this.lightColor = Colors.transparent,
    this.softColor = Colors.transparent,
  }) : assert(angle > 0 && angle < 2 * _math.pi);

  @override
  void paint(Canvas canvas, Size size) {
    //fill slice area
    // final radius = _math.min(size.width, size.height);
    final path = CircleSlice.buildSlicePath(radius, angle);
    final bgColor =
        value != null && value != 0 && itemIndex != selectedItemIndex
            ? lightColor
            : softColor;
    // fill slice area
    canvas.drawPath(
      path,
      Paint()
        ..color = bgColor
        ..style = PaintingStyle.fill,
    );

    // draw slice border
    if (strokeWidth > 0) {
      canvas.drawPath(
        path,
        Paint()
          ..color = strokeColor!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
      canvas.drawPath(
        Path()
          ..arcTo(
              Rect.fromCircle(
                center: Offset(0, 0),
                radius: radius,
              ),
              0,
              angle,
              false),
        Paint()
          ..color = strokeColor!
          ..strokeWidth = strokeWidth * 2
          ..style = PaintingStyle.stroke,
      );

      if (itemIndex != selectedItemIndex) {
        for (var i = 0; i <= 10; i++) {
          var previousRadius = 0.0;

          canvas.drawPath(
            CircleSlice.buildSlicePathPrevious(
                previousRadius, radius * (i / 10.0), angle),
            Paint()
              ..color = i <= (value ?? 0) ? fillColor : Colors.white
              ..strokeWidth = .5
              ..style =
                  i <= (value ?? 0) ? PaintingStyle.fill : PaintingStyle.stroke,
          );
          previousRadius = radius * (i / 10.0);
        }
        for (var i = 11; i > 0; i--) {
          var previousRadius = 0.0;

          canvas.drawPath(
            CircleSlice.buildSlicePathPrevious(
                previousRadius, radius * (i / 10.0), angle),
            Paint()
              ..color = i == (10.0 - (value ?? 0)) ? Colors.white : Colors.white
              ..strokeWidth = .5
              ..style = PaintingStyle.stroke,
          );
          previousRadius = radius * (i / 10.0);
        }
      }
    }

    // textPainter.paint(canvas, offset);
    // final diffToSelected = itemCount - (itemCount - itemIndex);
    if (value != null && value != 0 && itemIndex != selectedItemIndex) {
      final diffToSelected =
          (itemIndex - selectedItemIndex + itemCount) % itemCount;

      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
      final textSpan = TextSpan(
        text: '$value',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final center = Offset(0, 0);
      final angleToMove = angle / 2;
      final distance = radius * 0.8;
      final offset = center.translate(
        distance * _math.cos(angleToMove),
        distance * _math.sin(angleToMove),
      );

      canvas.save();
      final pivot = textPainter.size.center(offset);
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(rotateAngle(diffToSelected, itemCount));
      canvas.translate(-pivot.dx, -pivot.dy);
      textPainter.paint(canvas, offset);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_CircleSlicePainterWithValue oldDelegate) {
    return angle != oldDelegate.angle ||
        fillColor != oldDelegate.fillColor ||
        strokeColor != oldDelegate.strokeColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}

double rotateAngle(int positionIndex, int positionCount) {
  final anglePerPosition = 2 * _math.pi / positionCount;
  final positionAngle =
      anglePerPosition * positionIndex - (anglePerPosition / 2) - _math.pi / 2;

  return -positionAngle;
}
