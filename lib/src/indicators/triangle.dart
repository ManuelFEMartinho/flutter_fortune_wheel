part of 'indicators.dart';

class _TrianglePainter extends CustomPainter {
  final Color fillColor;
  final Color? softColor, lightColor;
  final double strokeWidth;
  final double elevation;
  final double? angle;
  final int value;
  final int count;
  final String text;

  const _TrianglePainter({
    required this.fillColor,
    required this.count,
    this.softColor,
    this.lightColor,
    this.strokeWidth = 1,
    this.elevation = 0,
    this.angle,
    this.value = 7,
    required this.text,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gap = 10.0;
    late var startingFillPosition = (size.width * 1.8) / gap;
    var startAngle = _math.pi / 2.6;
    final selectedValue = value;

    final alpha = _math.pi * 2 / (count);
    final beta = (_math.pi - alpha) / 2;
    startAngle = beta;
    final endAngle = alpha;

    final bgColor = value != 0 ? lightColor : softColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, gap),
        width: (startingFillPosition) * (gap - 0),
        height: ((startingFillPosition) * (gap - 0)),
      ),
      startAngle,
      endAngle,
      true,
      Paint()
        ..color = bgColor!
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.6,
    );

    /// Paint filling of each slice
    for (var j = 0; j < 11; j++) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, gap),
          width: (startingFillPosition) * (gap - j),
          height: ((startingFillPosition) * (gap - j)),
        ),
        startAngle,
        endAngle,
        true,
        Paint()
          ..color = j >= (gap - selectedValue) ? fillColor : Colors.white
          ..style = j >= (gap - selectedValue)
              ? PaintingStyle.fill
              : PaintingStyle.stroke
          ..strokeWidth = 0.4,
      );
    }
    for (var j = 0; j < 11; j++) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, gap),
          width: (startingFillPosition) * (gap - j),
          height: ((startingFillPosition) * (gap - j)),
        ),
        startAngle,
        endAngle,
        true,
        Paint()
          ..color = j == (gap - selectedValue) ? fillColor : Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.4,
      );
    }

    /// Paint outside slice
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, gap),
        width: (startingFillPosition) * (gap - 0),
        height: ((startingFillPosition) * (gap - 0)),
      ),
      startAngle,
      endAngle,
      true,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.6,
    );

    final valueStr = selectedValue != 0 ? '$selectedValue' : text;
    final textHasTwoOrMoreLines = valueStr.contains('\n');

    final isText = valueStr == text;
    final fontSize = isText
        ? textHasTwoOrMoreLines
            ? 13.5
            : 16.0
        : 20.0;
    final fontweight = isText
        ? textHasTwoOrMoreLines
            ? FontWeight.w800
            : FontWeight.bold
        : FontWeight.bold;
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$valueStr',
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
          fontWeight: fontweight,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    canvas.save();

    final rotateAngle = isText ? _math.pi / 2 : -_math.pi;
    final centerHeight = isText ? size.height / 1.5 : size.height;
    final centerW =
        isText ? size.width / 2 + textPainter.size.height / 2 : size.width / 2;
    canvas.translate(centerW, centerHeight);
    canvas.rotate(rotateAngle);

    textPainter.paint(canvas, Offset(-textPainter.width / 2, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return fillColor != oldDelegate.fillColor ||
        elevation != oldDelegate.elevation ||
        strokeWidth != oldDelegate.strokeWidth ||
        softColor != oldDelegate.softColor;
  }
}

class _Triangle extends StatelessWidget {
  final Color color;
  final Color? softColor, lightColor;
  final double borderWidth;
  final double elevation;
  final double? angle;
  final int value;
  final int count;
  final String valueText;

  const _Triangle({
    required this.color,
    this.softColor,
    this.lightColor,
    this.borderWidth = 1,
    this.elevation = 0,
    this.angle,
    this.value = 0,
    this.count = 6,
    this.valueText = '',
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(
        fillColor: color,
        softColor: softColor,
        lightColor: lightColor,
        strokeWidth: borderWidth,
        elevation: elevation,
        angle: angle,
        value: value,
        count: count,
        text: valueText,
      ),
    );
  }
}
