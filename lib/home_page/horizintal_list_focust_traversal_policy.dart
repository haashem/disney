import 'package:flutter/widgets.dart';

/// A custom focus traversal policy for horizontal movie lists.
/// Prevents focus from jumping to the next section when reaching the end of the list.
class HorizontalListFocusTraversalPolicy extends FocusTraversalPolicy
    with DirectionalFocusTraversalPolicyMixin {
  final List<FocusNode> listNodes;

  /// Creates a policy that restricts focus traversal within the horizontal list.
  ///
  /// [listNodes] should contain the list of focus nodes for the items in the horizontal list.
  HorizontalListFocusTraversalPolicy({required this.listNodes});

  @override
  Iterable<FocusNode> sortDescendants(
      Iterable<FocusNode> descendants, FocusNode currentNode) {
    // Default sorting behavior (can be customized if needed).
    return descendants;
  }

  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    if (direction == TraversalDirection.right ||
        direction == TraversalDirection.left) {
      // Restrict horizontal navigation within the list.
      if (listNodes.contains(currentNode)) {
        final int currentIndex = listNodes.indexOf(currentNode);
        final int nextIndex = direction == TraversalDirection.right
            ? currentIndex + 1
            : currentIndex - 1;

        if (nextIndex >= 0 && nextIndex < listNodes.length) {
          listNodes[nextIndex].requestFocus();
          return true;
        }
      }
      return false; // Prevent focus from jumping outside the list.
    }

    // Allow vertical navigation or other directions by default.
    return super.inDirection(currentNode, direction);
  }
}
