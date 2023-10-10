part of 'indicators.dart';

class TriangleIndicator extends StatelessWidget {
  final Color? color, softColor, lightColor;
  final double? width, height, angle;
  final int value, itemCount;
  final String valueText;

  const TriangleIndicator({
    Key? key,
    this.color,
    this.height,
    this.width,
    this.angle,
    this.lightColor,
    this.softColor,
    this.value = 0,
    this.itemCount = 6,
    this.valueText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Transform.rotate(
      angle: _math.pi,
      child: Transform.translate(
        offset: Offset(0, 0),
        child: SizedBox(
          width: width ?? MediaQuery.of(context).size.width / 2 - 60,
          height: height ?? MediaQuery.of(context).size.width / 2 - 60,
          child: _Triangle(
            color: color ?? theme.colorScheme.secondary,
            softColor: softColor ?? theme.colorScheme.secondary,
            lightColor: lightColor ?? theme.colorScheme.secondary,
            elevation: 2,
            angle: angle,
            value: value,
            count: itemCount,
            valueText: valueText,
          ),
        ),
      ),
    );
  }
}
