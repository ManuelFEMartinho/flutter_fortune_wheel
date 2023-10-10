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

    // fill slice area
    canvas.drawPath(
      path,
      Paint()
        ..color = softColor
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

      final offset = Offset(size.height / 1.5, size.width / 4);
      canvas.save();
      final pivot = textPainter.size.center(offset);
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(rotateAngle(angle, diffToSelected, itemCount));
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

double rotateAngle(double angle, int positionIndex, int positionCount) {
  final anglePerPosition = 2 * _math.pi / positionCount;
  final positionAngle =
      anglePerPosition * positionIndex - (anglePerPosition / 2) - _math.pi / 2;

  return -positionAngle;
}

double rotateAngleText(double angle, int positionIndex, int positionCount) {
  final anglePerPosition = 2 * _math.pi / positionCount;

  if (positionIndex > positionCount / 2) {
    return anglePerPosition - anglePerPosition / 2 + _math.pi;
  }
  return anglePerPosition - anglePerPosition / 2;
}

Offset positionText({
  required int positionIndex,
  required int positionCount,
  required Size size,
  required TextPainter textPainter,
  bool twoLines = false,
}) {
  if (positionIndex > positionCount / 2) {
    final offset = Offset(
        size.width / 4, size.height / 2 - (textPainter.size.height * 2.8));

    return textPainter.size.center(offset);
  }
  final offset = Offset(size.width / 2, textPainter.size.height * .8);

  return textPainter.size.center(offset);
}
