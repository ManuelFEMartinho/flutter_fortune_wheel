import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_pie_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../common/common.dart';
import '../widgets/widgets.dart';

class PieWheelPage extends HookWidget {
  static const kRouteName = 'PieWheelPage';

  static void go(BuildContext context) {
    context.goNamed(kRouteName);
  }

  @override
  Widget build(BuildContext context) {
    final alignment = useState(Alignment.topCenter);
    final selected = useStreamController<int>();
    final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
    // ignore: unused_local_variable
    final isAnimating = useState(false);

    final alignmentSelector = AlignmentSelector(
      selected: alignment.value,
      onChanged: (v) => alignment.value = v!,
    );

    // ignore: unused_element
    void handleRoll() {
      selected.add(2);
    }

    return AppLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            alignmentSelector,
            SizedBox(height: 8),
            RollButtonWithPreview(
              selected: selectedIndex,
              items: fortuneValues,
              onPressed: () => selected.add(6),
            ),
            SizedBox(height: 8),
            Expanded(
              child: PieSelector(
                alignment: alignment.value,
                selected: selected.stream,
                // onAnimationStart: () => isAnimating.value = true,
                // onAnimationEnd: () => isAnimating.value = false,
                onFling: null,
                onFocusItemChanged: selected.add,
                hapticImpact: HapticImpact.heavy,
                sliceBuider: (context, index, wd, totalAngle) => CircleSlice(
                  radius: wd.radius,
                  angle: wd.itemAngle,
                  value: 2,
                  fillColor: Colors.yellow,
                  strokeColor: Colors.black,
                  softColor: Colors.blue,
                  strokeWidth: 2,
                  itemIndex: index,
                  itemCount: fortuneValues.length,
                  selectedItemIndex: selectedIndex,
                ),
                indicators: [
                  PieIndicator(
                    alignment: alignment.value,
                    child: TriangleIndicator(),
                  ),
                ],
                items: [
                  for (var it in fortuneValues)
                    TransformedPieItem(
                        offset: Offset(0, 50),
                        angle: pi / 2,
                        item: PieItem(
                            child: Transform.rotate(
                                angle: pi / 2, child: Text('$it ')),
                            onTap: () => print(it)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
