import 'package:flutter/widgets.dart';

extension ScrollableX on Scrollable {
  // Modified version of Scrollable.ensureVisible
  static Future<void> ensureDirectionalAlignment(
    BuildContext context,
    double Function(AxisDirection) alignment, {
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    final List<Future<void>> futures = <Future<void>>[];
    RenderObject? targetRenderObject;
    ScrollableState? scrollable = Scrollable.maybeOf(context);
    while (scrollable != null) {
      final List<Future<void>> newFutures;
      newFutures = scrollable._performEnsureAlignment(
        context.findRenderObject()!,
        alignment: alignment(scrollable.axisDirection),
        duration: duration,
        curve: curve,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        targetRenderObject: targetRenderObject,
      );
      futures.addAll(newFutures);

      targetRenderObject ??= context.findRenderObject();
      context = scrollable.context;
      scrollable = Scrollable.maybeOf(context);
    }

    if (futures.isEmpty || duration == Duration.zero) {
      return Future.value();
    }
    if (futures.length == 1) {
      // ignore: avoid-unsafe-collection-methods
      return futures.single;
    }
    return Future.wait<void>(futures).then((List<void> _) => null);
  }
}

extension on ScrollableState {
  List<Future<void>> _performEnsureAlignment(
    RenderObject object, {
    double alignment = 0.0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
    RenderObject? targetRenderObject,
  }) {
    final Future<void> ensureVisibleFuture = position.ensureVisible(
      object,
      alignment: alignment,
      duration: duration,
      curve: curve,
      alignmentPolicy: alignmentPolicy,
      targetRenderObject: targetRenderObject,
    );
    return [ensureVisibleFuture];
  }
}
