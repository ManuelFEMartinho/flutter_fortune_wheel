part of 'core.dart';

/// A selection of commonly used curves for animating when the value of
/// [PieWidget.selected] changes.
class PieCurve {
  const PieCurve._();

  /// The default curve used when spinning a [FortuneWidget].
  static const Curve spin = Cubic(0, 1.0, 0, 1.0);

  /// A curve used for disabling spin animations.
  static const Curve none = Threshold(0.0);
}
