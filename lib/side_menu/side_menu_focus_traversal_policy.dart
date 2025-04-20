import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SideMenuFocusTraversalPolicy extends FocusTraversalPolicy
    with DirectionalFocusTraversalPolicyMixin {
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    FocusNode? found;
    
    switch (direction) {
      case TraversalDirection.up || TraversalDirection.down:
        return super.inDirection(currentNode, direction);
      case TraversalDirection.left || TraversalDirection.right:
        final FocusScopeNode nearestScope = currentNode.enclosingScope!.enclosingScope!;
        final FocusNode focusedChild = currentNode;
  
        if (focusedChild == null) {
          return super.inDirection(currentNode, direction);
        }
         final ScrollableState? focusedScrollable =
            Scrollable.maybeOf(focusedChild.context!);
         Iterable<FocusNode> eligibleNodes = _sortAndFilterHorizontally(
          direction,
          focusedChild.rect,
          nearestScope.traversalDescendants,
        );
        if (eligibleNodes.isEmpty) {
          break;
        }
        if (focusedScrollable != null && !focusedScrollable.position.atEdge) {
          final Iterable<FocusNode> filteredEligibleNodes = eligibleNodes.where(
            (FocusNode node) =>
                Scrollable.maybeOf(node.context!) == focusedScrollable,
          );
          if (filteredEligibleNodes.isNotEmpty) {
            eligibleNodes = filteredEligibleNodes;
          }
        }
        if (direction == TraversalDirection.left) {
          eligibleNodes = eligibleNodes.toList().reversed;
        }
         // Find any nodes that intersect the band of the focused child.
        final Rect band = Rect.fromLTRB(
          -double.infinity,
          focusedChild.rect.top,
          double.infinity,
          focusedChild.rect.bottom,
        );
        final Iterable<FocusNode> inBand = eligibleNodes.where(
          (FocusNode node) => !node.rect.intersect(band).isEmpty,
        );
        if (inBand.isNotEmpty) {
          found =
              _sortByDistancePreferHorizontal(focusedChild.rect.center, inBand)
                  .first;
          break;
        }
        // Only out-of-band targets are eligible, so pick the one that is
        // closest to the center line vertically, and if any are the same
        // distance vertically, pick the closest one of those horizontally.
        found = _sortClosestEdgesByDistancePreferVertical(
          focusedChild.rect.center,
          eligibleNodes,
        ).first;
    }

    if (found != null) {
      // _pushPolicyData(direction, nearestScope, focusedChild);
      switch (direction) {
        case TraversalDirection.up:
        case TraversalDirection.left:
          requestFocusCallback(
            found,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
          );
        case TraversalDirection.down:
        case TraversalDirection.right:
          requestFocusCallback(
            found,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
      }
      return true;
    }
    return false;
  }

  // Sort the ones that have edges that are closest vertically first, and if
  // two are the same vertical distance, pick the one that is closest
  // horizontally.
  static Iterable<FocusNode> _sortClosestEdgesByDistancePreferVertical(
    Offset target,
    Iterable<FocusNode> nodes,
  ) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(
      sorted,
      compare: (FocusNode nodeA, FocusNode nodeB) {
        final int vertical =
            _verticalCompareClosestEdge(target, nodeA.rect, nodeB.rect);
        if (vertical == 0) {
          // If they're the same distance vertically, pick the closest one
          // horizontally.
          return _horizontalCompare(
              target, nodeA.rect.center, nodeB.rect.center);
        }
        return vertical;
      },
    );
    return sorted;
  }

  static int _verticalCompareClosestEdge(Offset target, Rect a, Rect b) {
    // Find which edge is closest to the target for each.
    final double aCoord =
        (a.top - target.dy).abs() < (a.bottom - target.dy).abs()
            ? a.top
            : a.bottom;
    final double bCoord =
        (b.top - target.dy).abs() < (b.bottom - target.dy).abs()
            ? b.top
            : b.bottom;
    return (aCoord - target.dy).abs().compareTo((bCoord - target.dy).abs());
  }

  // Sorts nodes from left to right horizontally, and removes nodes that are
  // either to the right of the left side of the target node if we're going
  // left, or to the left of the right side of the target node if we're going
  // right.
  //
  // This doesn't need to take into account directionality because it is
  // typically intending to actually go left or right, not in a reading
  // direction.
  Iterable<FocusNode> _sortAndFilterHorizontally(
    TraversalDirection direction,
    Rect target,
    Iterable<FocusNode> nodes,
  ) {
    assert(direction == TraversalDirection.left ||
        direction == TraversalDirection.right);
    final List<FocusNode> sorted = nodes
        .where(switch (direction) {
          TraversalDirection.left => (FocusNode node) =>
              node.rect != target && node.rect.center.dx <= target.left,
          TraversalDirection.right => (FocusNode node) =>
              node.rect != target && node.rect.center.dx >= target.right,
          TraversalDirection.up ||
          TraversalDirection.down =>
            throw ArgumentError('Invalid direction $direction'),
        })
        .toList();
    // Sort all nodes from left to right.
    mergeSort<FocusNode>(
      sorted,
      compare: (FocusNode a, FocusNode b) =>
          a.rect.center.dx.compareTo(b.rect.center.dx),
    );
    return sorted;
  }

  // Sort the ones that are closest horizontally first, and if two are the same
  // horizontal distance, pick the one that is closest vertically.
  static Iterable<FocusNode> _sortByDistancePreferHorizontal(
    Offset target,
    Iterable<FocusNode> nodes,
  ) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(
      sorted,
      compare: (FocusNode nodeA, FocusNode nodeB) {
        final Offset a = nodeA.rect.center;
        final Offset b = nodeB.rect.center;
        final int horizontal = _horizontalCompare(target, a, b);
        if (horizontal == 0) {
          return _verticalCompare(target, a, b);
        }
        return horizontal;
      },
    );
    return sorted;
  }

  static int _verticalCompare(Offset target, Offset a, Offset b) {
    return (a.dy - target.dy).abs().compareTo((b.dy - target.dy).abs());
  }

  static int _horizontalCompare(Offset target, Offset a, Offset b) {
    return (a.dx - target.dx).abs().compareTo((b.dx - target.dx).abs());
  }

  @override
  Iterable<FocusNode> sortDescendants(
      Iterable<FocusNode> descendants, FocusNode currentNode) {
    return descendants.where((node) => node.canRequestFocus).toList();
  }
}
