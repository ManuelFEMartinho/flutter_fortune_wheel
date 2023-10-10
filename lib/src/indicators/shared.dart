part of 'indicators.dart';

@immutable
class PieIndicator {
  final Alignment alignment;
  final Widget child;

  const PieIndicator({
    this.alignment = Alignment.center,
    required this.child,
  });

  @override
  int get hashCode => hash2(alignment, child);

  @override
  bool operator ==(Object other) {
    return other is PieIndicator &&
        alignment == other.alignment &&
        child == other.child;
  }
}
