part of 'wheel.dart';

typedef SliceBuider = CircleSlice Function(
    BuildContext context, int index, _WheelData wheelData, double totalAngle);
typedef IndicatorBuider = PieIndicator Function(
    BuildContext context, int index, _WheelData wheelData);

class _TransformedCircleSlice extends StatelessWidget {
  final TransformedPieItem item;
  final StyleStrategy styleStrategy;
  final _WheelData wheelData;
  final int index;
  final SliceBuider? sliceBuider;
  final int itemCount;
  final int selectedItemIndex;

  const _TransformedCircleSlice({
    Key? key,
    required this.item,
    required this.styleStrategy,
    required this.index,
    required this.wheelData,
    required this.itemCount,
    required this.selectedItemIndex,
    this.sliceBuider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = item.style ??
        styleStrategy.getItemStyle(theme, index, wheelData.itemCount);

    return _CircleSliceLayout(
      handler: item,
      child: DefaultTextStyle(
        textAlign: style.textAlign,
        style: style.textStyle,
        child: item.child,
      ),
      slice: sliceBuider?.call(context, index, wheelData, item.totalAngle) ??
          CircleSlice(
            radius: wheelData.radius,
            angle: wheelData.itemAngle,
            fillColor: style.color,
            strokeColor: style.borderColor,
            strokeWidth: style.borderWidth,
            itemIndex: 0,
            itemCount: itemCount,
            selectedItemIndex: selectedItemIndex,
          ),
    );
  }
}

class _CircleSlices extends StatelessWidget {
  final List<TransformedPieItem> items;
  final StyleStrategy styleStrategy;
  final _WheelData wheelData;
  final SliceBuider? sliceBuider;
  final int selectedItemIndex;

  const _CircleSlices({
    Key? key,
    required this.items,
    required this.styleStrategy,
    required this.wheelData,
    this.sliceBuider,
    required this.selectedItemIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slices = [
      for (var i = 0; i < items.length; i++)
        Transform.translate(
          offset: items[i].offset,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: items[i].angle,
            child: _TransformedCircleSlice(
              item: items[i],
              styleStrategy: styleStrategy,
              index: i,
              wheelData: wheelData,
              sliceBuider: sliceBuider,
              itemCount: items.length,
              selectedItemIndex: selectedItemIndex,
            ),
          ),
        ),
    ];

    return Stack(
      children: slices,
    );
  }
}
