part of 'wheel.dart';

class CircleSlice extends StatelessWidget {
  static Path buildSlicePath(double radius, double angle) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(radius, 0)
      ..arcTo(
          Rect.fromCircle(
            center: Offset(0, 0),
            radius: radius,
          ),
          0,
          angle,
          false)
      ..close();
  }

  static Path buildSlicePathPrevious(
      double previuosRadius, double radius, double angle) {
    return Path()
      ..moveTo(previuosRadius, previuosRadius)
      ..lineTo(radius, 0)
      ..arcTo(
          Rect.fromCircle(
            center: Offset(0, 0),
            radius: radius,
          ),
          0,
          angle,
          false)
      ..close();
  }

  static Path buildValuePathPrevious(double radius, double angle) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(radius * 9, 0)
      ..arcTo(
          Rect.fromCircle(
            center: Offset(0, 0),
            radius: radius,
          ),
          0,
          angle,
          false)
      ..close();
  }

  static Path buildSlicePathOffset(double radius, double angle, Offset offset) {
    return Path()
      ..arcTo(
          Rect.fromCircle(
            center: offset,
            radius: radius,
          ),
          0,
          angle,
          false)
      ..close();
  }

  final double radius;
  final double angle;
  final Color fillColor;
  final Color softColor;
  final Color lightColor;
  final Color strokeColor;
  final double strokeWidth;
  final int value;
  final int itemIndex;
  final int itemCount;
  final int selectedItemIndex;
  final String valueText;

  const CircleSlice({
    Key? key,
    required this.radius,
    required this.fillColor,
    required this.strokeColor,
    this.softColor = Colors.transparent,
    this.lightColor = Colors.transparent,
    this.strokeWidth = 1,
    required this.angle,
    required this.itemIndex,
    required this.itemCount,
    required this.selectedItemIndex,
    this.value = 0,
    this.valueText = '',
  })  : assert(radius > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
          painter: _CircleSlicePainterWithValue(
        fillColor: fillColor,
        softColor: softColor,
        angle: angle,
        value: value,
        lightColor: lightColor,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        radius: radius,
        itemIndex: itemIndex,
        itemCount: itemCount,
        selectedItemIndex: selectedItemIndex,
        valueText: valueText,
      )),
    );
  }
}

class _CircleSliceLayout extends StatelessWidget {
  final Widget? child;
  final CircleSlice slice;
  final GestureHandler? handler;

  const _CircleSliceLayout({
    Key? key,
    required this.slice,
    this.child,
    this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: slice.radius,
      height: slice.radius,
      child: GestureDetector(
        onTap: handler?.onTap,
        onTapCancel: handler?.onTapCancel,
        onTapDown: handler?.onTapDown,
        onTapUp: handler?.onTapUp,
        onDoubleTap: handler?.onDoubleTap,
        onDoubleTapCancel: handler?.onDoubleTapCancel,
        onDoubleTapDown: handler?.onDoubleTapDown,
        onForcePressEnd: handler?.onForcePressEnd,
        onForcePressPeak: handler?.onForcePressPeak,
        onForcePressStart: handler?.onForcePressStart,
        onForcePressUpdate: handler?.onForcePressUpdate,
        onLongPress: handler?.onLongPress,
        onLongPressEnd: handler?.onLongPressEnd,
        onLongPressMoveUpdate: handler?.onLongPressMoveUpdate,
        onLongPressStart: handler?.onLongPressStart,
        onLongPressUp: handler?.onLongPressUp,
        onPanCancel: handler?.onPanCancel,
        onPanDown: handler?.onPanDown,
        onPanEnd: handler?.onPanEnd,
        onPanStart: handler?.onPanStart,
        onPanUpdate: handler?.onPanUpdate,
        onScaleEnd: handler?.onScaleEnd,
        onScaleStart: handler?.onScaleStart,
        onScaleUpdate: handler?.onScaleUpdate,
        onSecondaryLongPress: handler?.onSecondaryLongPress,
        onSecondaryLongPressMoveUpdate: handler?.onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressStart: handler?.onSecondaryLongPressStart,
        onSecondaryLongPressEnd: handler?.onSecondaryLongPressEnd,
        onSecondaryLongPressUp: handler?.onSecondaryLongPressUp,
        onHorizontalDragCancel: handler?.onHorizontalDragCancel,
        onHorizontalDragDown: handler?.onHorizontalDragDown,
        onHorizontalDragEnd: handler?.onHorizontalDragEnd,
        onHorizontalDragStart: handler?.onHorizontalDragStart,
        onHorizontalDragUpdate: handler?.onHorizontalDragUpdate,
        onVerticalDragCancel: handler?.onVerticalDragCancel,
        onVerticalDragDown: handler?.onVerticalDragDown,
        onVerticalDragEnd: handler?.onVerticalDragEnd,
        onVerticalDragStart: handler?.onVerticalDragStart,
        onVerticalDragUpdate: handler?.onVerticalDragUpdate,
        onSecondaryTap: handler?.onSecondaryTap,
        onSecondaryTapCancel: handler?.onSecondaryTapCancel,
        onSecondaryTapDown: handler?.onSecondaryTapDown,
        onSecondaryTapUp: handler?.onSecondaryTapUp,
        onTertiaryTapCancel: handler?.onTertiaryTapCancel,
        onTertiaryTapDown: handler?.onTertiaryTapDown,
        onTertiaryTapUp: handler?.onTertiaryTapUp,
        child: ClipPath(
          clipper: _CircleSliceClipper(slice.angle),
          child: CustomMultiChildLayout(
            delegate: _CircleSliceLayoutDelegate(slice.angle),
            children: [
              LayoutId(
                id: _SliceSlot.slice,
                child: slice,
              ),
              if (child != null)
                LayoutId(
                  id: _SliceSlot.child,
                  child: Transform.rotate(
                    angle: slice.angle,
                    child: child,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
