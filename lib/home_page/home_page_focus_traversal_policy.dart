import 'package:flutter/widgets.dart';

class HomePageFocusTraversalPolicy extends ReadingOrderTraversalPolicy {
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.up ||
        direction == TraversalDirection.down) {
      return super.inDirection(currentNode.parent!.parent!, direction);
    }

    final parent = currentNode.parent;
    if (parent == null) return false;

    final siblings = parent.children.toList();
    final index = siblings.indexOf(currentNode);

    if (direction == TraversalDirection.left) {
      if (index > 0) {
        final previousNode = siblings[index - 1];
        if (currentNode.rect.center.dy == previousNode.rect.center.dy) {
          // previousNode.requestFocus();
          requestFocusCallback(
            previousNode,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
          );
          return true;
        }
      }
    }

    if (direction == TraversalDirection.right) {
      if (index < siblings.length - 1) {
        final nextNode = siblings[index + 1];
        if (currentNode.rect.center.dy == nextNode.rect.center.dy) {
          requestFocusCallback(
            nextNode,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
          );
          return true;
        }
      }
    }

    return false; // Block wrapping to another row
  }

  @override
  TraversalRequestFocusCallback get requestFocusCallback => (FocusNode node,
          {ScrollPositionAlignmentPolicy? alignmentPolicy,
          double? alignment,
          Duration? duration,
          Curve? curve}) {
        node.requestFocus();
        Scrollable.ensureVisible(
          node.context!,
          alignment: alignment ?? 1,
          alignmentPolicy:
              alignmentPolicy ?? ScrollPositionAlignmentPolicy.explicit,
          duration: Duration(milliseconds: 200),
          curve: curve ?? Curves.ease,
        );
      };
}
