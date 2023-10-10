part of 'core.dart';

/// A [PieWidget] visualizes (random) selection processes by iterating over
/// a list of items before settling on a selected item.
///
/// See also:
///  * [PieWheel]
///  * [PieBar]
///  * [PieItem]
abstract class PieWidget implements Widget {
  /// The default value for [duration] (currently **5 seconds**).
  static const Duration kDefaultDuration = Duration(seconds: 5);

  /// The default value for [rotationCount] (currently **100**).
  static const int kDefaultRotationCount = 100;

  /// {@template flutter_fortune_wheel.PieWidget.items}
  /// A list of [PieItem]s to be shown within this [PieWidget].
  /// {@endtemplate}
  List<PieItem> get items;

  /// {@template flutter_fortune_wheel.PieWidget.selected}
  /// A stream notifying this widget that a new value within [items] was
  /// selected.Used by [PieWidget]s to align [indicators] on the selected
  /// item.
  /// {@endtemplate}
  Stream<int> get selected;

  /// {@template flutter_fortune_wheel.PieWidget.rotationCount}
  /// The number of times a [PieWidget] rotates around all
  /// [items] before it settles on the [selected] value.
  /// {@endtemplate}
  int get rotationCount;

  /// {@template flutter_fortune_wheel.PieWidget.duration}
  /// The animation duration used for [PieCurve.spin]
  /// within [PieWidget] instances.
  /// {@endtemplate}
  Duration get duration;

  /// {@template flutter_fortune_wheel.PieWidget.animationType}
  /// The type of curve to use for easing the animation when [selected] changes.
  ///
  /// See also:
  ///  * [PieCurve], which defines commonly used curves
  /// {@endtemplate}
  Curve get curve;

  /// {@template flutter_fortune_wheel.PieWidget.onAnimationStart}
  /// Called when this widget starts an animation.
  /// Useful for disabling other widgets during the animation.
  /// {@endtemplate}
  VoidCallback? get onAnimationStart;

  /// {@template flutter_fortune_wheel.PieWidget.onAnimationEnd}
  /// Called when this widget's animation ends.
  /// Useful for enabling other widgets after the animation ends.
  /// {@endtemplate}
  VoidCallback? get onAnimationEnd;

  /// {@template flutter_fortune_wheel.PieWidget.indicators}
  /// The list of [indicators] is rendered on top of the underlying
  /// [PieWidget]. These can be used to visualize the position of the
  /// [selected] item.
  /// {@endtemplate}
  List<PieIndicator> get indicators;

  /// {@template flutter_fortune_wheel.PieWidget.styleStrategy}
  /// The strategy to use for styling individual [items] when they have no
  /// dedicated [PieItem.style].
  /// {@endtemplate}
  StyleStrategy get styleStrategy;

  /// {@template flutter_fortune_wheel.PieWidget.animateFirst}
  /// Determines if this widget animates during its first build.
  ///
  /// The [onAnimationStart] and [onAnimationEnd] callbacks will not be called
  /// during the first build and no animation occurs, if this is set to false.
  ///
  /// Defaults to true.
  /// {@endtemplate}
  bool get animateFirst;

  /// {@template flutter_fortune_wheel.PieWidget.physics}
  /// The behavior used for handling pan events on this widget.
  ///
  /// See also:
  ///  * [PanPhysics] as the base class for implementing custom behavior
  ///  * [NoPanPhysics], which disables panning
  ///  * [DirectionalPanPhysics], which handles one directional panning
  ///  * [CircularPanPhysics], which handles panning on circular shapes
  /// {@endtemplate}
  PanPhysics get physics;

  /// {@template flutter_fortune_wheel.PieWidget.onFling}
  /// Called when a fling gesture is detected by the active [physics].
  /// {@endtemplate}
  VoidCallback? get onFling;
}
