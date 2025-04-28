import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicExampleApp extends StatelessWidget {
  const BasicExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.dark();
    return MaterialApp(
      title: 'Basic Focus Example',
      theme: theme.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(100, 40)),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.white;
            }
            return Colors.white10;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.black;
            }
            return Colors.white;
          }),
        ),
      )),
      home: BasicExample(),
    );
  }
}

class BasicExample extends StatefulWidget {
  const BasicExample({super.key});

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
  final List<FocusNode> _scope1focusNodes = [
    FocusNode(debugLabel: 'A'),
    FocusNode(debugLabel: 'B'),
    FocusNode(debugLabel: 'C'),
    FocusNode(debugLabel: 'D'),
    FocusNode(debugLabel: 'E'),
  ];

  final FocusScopeNode _focusScopeNode1 =
      FocusScopeNode(debugLabel: 'FocusScope 1');
  final FocusScopeNode _focusScopeNode2 =
      FocusScopeNode(debugLabel: 'FocusScope 2');

  @override
  void dispose() {
    for (var node in _scope1focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF1a1c28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FocusScope(
              node: _focusScopeNode1,
              onKeyEvent: (node, event) {
                if (event is KeyUpEvent) {
                  return KeyEventResult.handled;
                }
                if (event.logicalKey != LogicalKeyboardKey.arrowDown) {
                  return KeyEventResult.ignored;
                }
                if (!_focusScopeNode1
                    .focusInDirection(TraversalDirection.down)) {
                  _focusScopeNode2.requestFocus();
                }
                return KeyEventResult.handled;
              },
              child: _ButtonsContainer(
                label: 'FocusScope 1',
                buttons: [
                  ElevatedButton(
                    onPressed: () {},
                    //autofocus: true,
                    focusNode: _scope1focusNodes[0],
                    child: Text('A'),
                  ),
                  Focus(
                    debugLabel: 'Focus Wrapper for B',
                    skipTraversal: true,
                    // descendantsAreTraversable: false,
                    child: ElevatedButton(
                      onPressed: () {},
                      focusNode: _scope1focusNodes[1],
                      child: Text('B'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    focusNode: _scope1focusNodes[2],
                    child: Text('C'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    focusNode: _scope1focusNodes[3],
                    child: Text('D'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    focusNode: _scope1focusNodes[4],
                    child: Text('E'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            FocusScope(
              node: _focusScopeNode2,
              onKeyEvent: (node, event) {
                if (event is KeyUpEvent) {
                  return KeyEventResult.handled;
                }
                if (event.logicalKey != LogicalKeyboardKey.arrowUp) {
                  return KeyEventResult.ignored;
                }

                if (!_focusScopeNode2.focusInDirection(TraversalDirection.up)) {
                  _focusScopeNode1.requestFocus();
                }
                return KeyEventResult.handled;
              },
              child: _ButtonsContainer(
                label: 'FocusScope 2',
                buttons: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('F'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('G'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('H'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('I'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('J'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonsContainer extends StatelessWidget {
  final String label;
  final List<Widget> buttons;
  const _ButtonsContainer({required this.label, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            spacing: 16,
            children: [
              Row(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: buttons.take(3).toList(),
              ),
              Row(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: buttons.sublist(3).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
