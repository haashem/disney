import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BrowseTraversalPolicy extends ReadingOrderTraversalPolicy {
  final Map<FocusScopeNode, _DirectionalPolicyData> _policyData = {};
  BrowseTraversalPolicy({super.requestFocusCallback});
  @override
  void invalidateScopeData(FocusScopeNode node) {
    super.invalidateScopeData(node);
    _policyData.remove(node);
  }

  @override
  void changedScope({FocusNode? node, FocusScopeNode? oldScope}) {
    super.changedScope(node: node, oldScope: oldScope);
    if (oldScope != null) {
      _policyData[oldScope]
          ?.history
          .removeWhere((_DirectionalPolicyDataEntry entry) {
        return entry.node == node;
      });
    }
  }

  @override
  Iterable<FocusNode> sortDescendants(Iterable<FocusNode> descendants, FocusNode currentNode) {
    // TODO: implement sortDescendants
    return super.sortDescendants(descendants, currentNode);
  }

  @override
  FocusNode? findFirstFocusInDirection(
      FocusNode currentNode, TraversalDirection direction) {
    switch (direction) {
      case TraversalDirection.up:
        // Find the bottom-most node so we can go up from there.
        return _sortAndFindInitial(currentNode, vertical: true, first: false);
      case TraversalDirection.down:
        // Find the top-most node so we can go down from there.
        return _sortAndFindInitial(currentNode, vertical: true, first: true);
      case TraversalDirection.left:
        // Find the right-most node so we can go left from there.
        return _sortAndFindInitial(currentNode, vertical: false, first: false);
      case TraversalDirection.right:
        // Find the left-most node so we can go right from there.
        return _sortAndFindInitial(currentNode, vertical: false, first: true);
    }
  }

  FocusNode? _sortAndFindInitial(FocusNode currentNode,
      {required bool vertical, required bool first}) {
    final Iterable<FocusNode> nodes =
        currentNode.nearestScope!.traversalDescendants;
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(sorted, compare: (FocusNode a, FocusNode b) {
      if (vertical) {
        if (first) {
          return a.rect.top.compareTo(b.rect.top);
        }
        return b.rect.bottom.compareTo(a.rect.bottom);
      }
      if (first) {
        return a.rect.left.compareTo(b.rect.left);
      }
      return b.rect.right.compareTo(a.rect.right);
    });

    return sorted.firstOrNull;
  }

  static int _verticalCompare(Offset target, Offset a, Offset b) {
    return (a.dy - target.dy).abs().compareTo((b.dy - target.dy).abs());
  }

  static int _horizontalCompare(Offset target, Offset a, Offset b) {
    return (a.dx - target.dx).abs().compareTo((b.dx - target.dx).abs());
  }

  // Sort the ones that are closest to target vertically first, and if two are
  // the same vertical distance, pick the one that is closest horizontally.
  static Iterable<FocusNode> _sortByDistancePreferVertical(
      Offset target, Iterable<FocusNode> nodes) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(sorted, compare: (FocusNode nodeA, FocusNode nodeB) {
      final Offset a = nodeA.rect.center;
      final Offset b = nodeB.rect.center;
      final int vertical = _verticalCompare(target, a, b);
      if (vertical == 0) {
        return _horizontalCompare(target, a, b);
      }
      return vertical;
    });
    return sorted;
  }

  // Sort the ones that are closest horizontally first, and if two are the same
  // horizontal distance, pick the one that is closest vertically.
  static Iterable<FocusNode> _sortByDistancePreferHorizontal(
      Offset target, Iterable<FocusNode> nodes) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(sorted, compare: (FocusNode nodeA, FocusNode nodeB) {
      final Offset a = nodeA.rect.center;
      final Offset b = nodeB.rect.center;
      final int horizontal = _horizontalCompare(target, a, b);
      if (horizontal == 0) {
        return _verticalCompare(target, a, b);
      }
      return horizontal;
    });
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

  static int _horizontalCompareClosestEdge(Offset target, Rect a, Rect b) {
    // Find which edge is closest to the target for each.
    final double aCoord =
        (a.left - target.dx).abs() < (a.right - target.dx).abs()
            ? a.left
            : a.right;
    final double bCoord =
        (b.left - target.dx).abs() < (b.right - target.dx).abs()
            ? b.left
            : b.right;
    return (aCoord - target.dx).abs().compareTo((bCoord - target.dx).abs());
  }

  // Sort the ones that have edges that are closest horizontally first, and if
  // two are the same horizontal distance, pick the one that is closest
  // vertically.
  static Iterable<FocusNode> _sortClosestEdgesByDistancePreferHorizontal(
      Offset target, Iterable<FocusNode> nodes) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(sorted, compare: (FocusNode nodeA, FocusNode nodeB) {
      final int horizontal =
          _horizontalCompareClosestEdge(target, nodeA.rect, nodeB.rect);
      if (horizontal == 0) {
        // If they're the same distance horizontally, pick the closest one
        // vertically.
        return _verticalCompare(target, nodeA.rect.center, nodeB.rect.center);
      }
      return horizontal;
    });
    return sorted;
  }

  // Sort the ones that have edges that are closest vertically first, and if
  // two are the same vertical distance, pick the one that is closest
  // horizontally.
  static Iterable<FocusNode> _sortClosestEdgesByDistancePreferVertical(
      Offset target, Iterable<FocusNode> nodes) {
    final List<FocusNode> sorted = nodes.toList();
    mergeSort<FocusNode>(sorted, compare: (FocusNode nodeA, FocusNode nodeB) {
      final int vertical =
          _verticalCompareClosestEdge(target, nodeA.rect, nodeB.rect);
      if (vertical == 0) {
        // If they're the same distance vertically, pick the closest one
        // horizontally.
        return _horizontalCompare(target, nodeA.rect.center, nodeB.rect.center);
      }
      return vertical;
    });
    return sorted;
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
    final Iterable<FocusNode> filtered;
    switch (direction) {
      case TraversalDirection.left:
        filtered = nodes.where((FocusNode node) =>
            node.rect != target && node.rect.center.dx <= target.left);
      case TraversalDirection.right:
        filtered = nodes.where((FocusNode node) =>
            node.rect != target && node.rect.center.dx >= target.right);
      case TraversalDirection.up:
      case TraversalDirection.down:
        throw ArgumentError('Invalid direction $direction');
    }
    final List<FocusNode> sorted = filtered.toList();
    // Sort all nodes from left to right.
    mergeSort<FocusNode>(sorted,
        compare: (FocusNode a, FocusNode b) =>
            a.rect.center.dx.compareTo(b.rect.center.dx));
    return sorted;
  }

  // Sorts nodes from top to bottom vertically, and removes nodes that are
  // either below the top of the target node if we're going up, or above the
  // bottom of the target node if we're going down.
  Iterable<FocusNode> _sortAndFilterVertically(
    TraversalDirection direction,
    Rect target,
    Iterable<FocusNode> nodes,
  ) {
    assert(direction == TraversalDirection.up ||
        direction == TraversalDirection.down);
    final Iterable<FocusNode> filtered;
    switch (direction) {
      case TraversalDirection.up:
        filtered = nodes.where((FocusNode node) =>
            node.rect != target && node.rect.center.dy <= target.top);
      case TraversalDirection.down:
        filtered = nodes.where((FocusNode node) =>
            node.rect != target && node.rect.center.dy >= target.bottom);
      case TraversalDirection.left:
      case TraversalDirection.right:
        throw ArgumentError('Invalid direction $direction');
    }
    final List<FocusNode> sorted = filtered.toList();
    mergeSort<FocusNode>(sorted,
        compare: (FocusNode a, FocusNode b) =>
            a.rect.center.dy.compareTo(b.rect.center.dy));
    return sorted;
  }

  // Updates the policy data to keep the previously visited node so that we can
  // avoid hysteresis when we change directions in navigation.
  //
  // Returns true if focus was requested on a previous node.
  bool _popPolicyDataIfNeeded(
      TraversalDirection direction, FocusScopeNode nearestScope, FocusNode _) {
    final _DirectionalPolicyData? policyData = _policyData[nearestScope];
    final firstNodeInHistory = policyData?.history.firstOrNull;

    if (policyData == null || firstNodeInHistory == null) {
      invalidateScopeData(nearestScope);
      return false;
    }

    if (direction == firstNodeInHistory.direction) {
      return false;
    }

    if (firstNodeInHistory.direction != direction) {
      final lastHistory = policyData.history.lastOrNull;
      if (lastHistory?.node.parent == null) {
        // If a node has been removed from the tree, then we should stop
        // referencing it and reset the scope data so that we don't try and
        // request focus on it. This can happen in slivers where the rendered
        // node has been unmounted. This has the side effect that hysteresis
        // might not be avoided when items that go off screen get unmounted.
        invalidateScopeData(nearestScope);
        return false;
      }
    }

    final hasChangedDirection = switch (direction.orientation) {
      TraversalDirectionOrientation.vertical => switch (
            firstNodeInHistory.direction.orientation) {
          TraversalDirectionOrientation.horizontal => true,
          TraversalDirectionOrientation.vertical => false,
        },
      TraversalDirectionOrientation.horizontal => switch (
            firstNodeInHistory.direction.orientation) {
          TraversalDirectionOrientation.horizontal => false,
          TraversalDirectionOrientation.vertical => true,
        }
    };

    if (hasChangedDirection) {
      // Reset the policy data if we change directions.
      invalidateScopeData(nearestScope);
      return false;
    }
    _popLastNode(policyData, direction);
    return true;
  }

  // Returns true if successfully popped the history.
  // Or invaldiates the existing scope data.
  void _popLastNode(
      _DirectionalPolicyData policyData, TraversalDirection direction) {
    final FocusNode lastNode = policyData.history.removeLast().node;
    final ScrollPositionAlignmentPolicy alignmentPolicy = switch (direction) {
      TraversalDirection.up ||
      TraversalDirection.left =>
        ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      TraversalDirection.right ||
      TraversalDirection.down =>
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd
    };
    requestFocusCallback(
      lastNode,
      alignmentPolicy: alignmentPolicy,
      alignment: 0.5,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void pushPolicyData(TraversalDirection direction, FocusScopeNode nearestScope,
      FocusNode focusedChild) {
    final _DirectionalPolicyData? policyData = _policyData[nearestScope];
    final _DirectionalPolicyDataEntry newEntry =
        _DirectionalPolicyDataEntry(node: focusedChild, direction: direction);
    if (policyData != null) {
      policyData.history.add(newEntry);
    } else {
      _policyData[nearestScope] = _DirectionalPolicyData(history: [newEntry]);
    }
  }

  /// Focuses the next widget in the given [direction] in the [FocusScope] that
  /// contains the [currentNode].
  ///
  /// This determines what the next node to receive focus in the given
  /// [direction] will be by inspecting the node tree, and then calling
  /// [FocusNode.requestFocus] on it.
  ///
  /// Returns true if it successfully found a node and requested focus.
  ///
  /// Maintains a stack of previous locations that have been visited on the
  /// policy data for the affected [FocusScopeNode]. If the previous direction
  /// was the opposite of the current direction, then the this policy will
  /// request focus on the previously focused node. Change to another direction
  /// other than the current one or its opposite will clear the stack.
  ///
  /// If this function returns true when called by a subclass, then the subclass
  /// should return true and not request focus from any node.
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final nearestScope = currentNode.nearestScope;
    if (nearestScope == null) {
      return false;
    }

    final FocusNode? focusedChild = nearestScope.focusedChild;
    if (focusedChild == null) {
      return inDirectionNoCurrentFocus(currentNode, direction);
    }
    if (_popPolicyDataIfNeeded(direction, nearestScope, focusedChild)) {
      return true;
    }
    FocusNode? found;
    final ScrollableState? focusedScrollable =
        Scrollable.maybeOf(focusedChild.context!);
    switch (direction) {
      case TraversalDirection.down:
      case TraversalDirection.up:
        Iterable<FocusNode> eligibleNodes = _sortAndFilterVertically(
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
        if (direction == TraversalDirection.up) {
          eligibleNodes = eligibleNodes.toList().reversed;
        }
        // Find any nodes that intersect the band of the focused child.
        final Rect band = Rect.fromLTRB(
          focusedChild.rect.left,
          -double.infinity,
          focusedChild.rect.right,
          double.infinity,
        );
        final Iterable<FocusNode> inBand = eligibleNodes.where(
          (FocusNode node) => !node.rect.intersect(band).isEmpty,
        );
        if (inBand.isNotEmpty) {
          found =
              _sortByDistancePreferVertical(focusedChild.rect.center, inBand)
                  .first;
          break;
        }
        // Only out-of-band targets are eligible, so pick the one that is
        // closest to the center line horizontally, and if any are the same
        // distance horizontally, pick the closest one of those vertically.
        found = _sortClosestEdgesByDistancePreferHorizontal(
          focusedChild.rect.center,
          eligibleNodes,
        ).first;
      case TraversalDirection.right:
      case TraversalDirection.left:
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
        return false;
        // Only out-of-band targets are eligible, so pick the one that is
        // closest to the center line vertically, and if any are the same
        // distance vertically, pick the closest one of those horizontally.
        found = _sortClosestEdgesByDistancePreferVertical(
          focusedChild.rect.center,
          eligibleNodes,
        ).first;
    }
    if (found != null) {
      pushPolicyData(direction, nearestScope, focusedChild);
      return foundNodeToFocus(found, direction);
    }
    return super.inDirection(currentNode, direction);
  }

  bool inDirectionNoCurrentFocus(
      FocusNode currentNode, TraversalDirection direction) {
    final FocusNode firstFocus =
        findFirstFocusInDirection(currentNode, direction) ?? currentNode;
    return foundNodeToFocus(firstFocus, direction);
  }

  bool foundNodeToFocus(FocusNode chosenNode, TraversalDirection direction) {
    final alignmentPolicy = switch (direction) {
      TraversalDirection.up ||
      TraversalDirection.left =>
        ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      TraversalDirection.right ||
      TraversalDirection.down =>
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd
    };
    requestFocusCallback(
      chosenNode,
      alignmentPolicy: alignmentPolicy,
      alignment: 0.5,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    return true;
  }
}

// A policy data object for use by the DirectionalFocusTraversalPolicyMixin so
// it can keep track of the traversal history.
class _DirectionalPolicyDataEntry {
  const _DirectionalPolicyDataEntry(
      {required this.direction, required this.node});

  final TraversalDirection direction;
  final FocusNode node;
}

class _DirectionalPolicyData {
  const _DirectionalPolicyData({required this.history});

  /// A queue of entries that describe the path taken to the current node.
  final List<_DirectionalPolicyDataEntry> history;
}

extension Orientation on TraversalDirection {
  bool get isVertical => orientation == TraversalDirectionOrientation.vertical;

  bool get isHorizontal => !isVertical;

  TraversalDirectionOrientation get orientation => switch (this) {
        TraversalDirection.up ||
        TraversalDirection.down =>
          TraversalDirectionOrientation.vertical,
        TraversalDirection.left ||
        TraversalDirection.right =>
          TraversalDirectionOrientation.horizontal,
      };
}

enum TraversalDirectionOrientation {
  vertical,
  horizontal,
}
