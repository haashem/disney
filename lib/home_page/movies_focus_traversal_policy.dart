import 'package:flutter/material.dart';

class MovieRowTraversalPolicy extends FocusTraversalPolicy
    with DirectionalFocusTraversalPolicyMixin {
  @override
  bool inDirection(FocusNode currentNode, TraversalDirection direction) {
    final parentScope = currentNode.enclosingScope;
    if (parentScope == null) return false;

    final nodes = parentScope.traversalDescendants
        .where((n) => n.canRequestFocus && n.context != null)
        .toList();

    final index = nodes.indexOf(currentNode);
    if (index == -1) return false;

    switch (direction) {
      case TraversalDirection.left:
        if (index == 0) {
          // Let it move to the side menu
          return super.inDirection(currentNode, direction);
        }
        nodes[index - 1].requestFocus();
        return true;

      case TraversalDirection.right:
        if (index == nodes.length - 1) {
          // Don't jump to next row
          return false;
        }
        nodes[index + 1].requestFocus();
        return true;

      case TraversalDirection.up:
      case TraversalDirection.down:
        // Let Flutter handle row-to-row traversal
        return false;
    }
  }

  @override
  Iterable<FocusNode> sortDescendants(
    Iterable<FocusNode> descendants,
    FocusNode currentNode,
  ) {
    return descendants.where((n) => n.canRequestFocus).toList();
  }
}
