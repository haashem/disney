import 'dart:ui';

import 'package:disney/models/movie.dart';
import 'package:disney/show_page/episodes_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExtraPane extends StatefulWidget {
  final Movie movie;
  final FocusNode focusNode;
  final ValueChanged<bool> onFocusChange;

  const ExtraPane({
    super.key,
    required this.movie,
    required this.focusNode,
    required this.onFocusChange,
  });

  @override
  State<ExtraPane> createState() => _ExtraPaneState();
}

class _ExtraPaneState extends State<ExtraPane> {
  late final FocusNode _focusNode = widget
      .focusNode; //FocusNode(debugLabel: 'Extra Pane Inner Focus Node', skipTraversal: true);
  bool _isFocused = false;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: FocusableActionDetector(
        onFocusChange: (focused) {
          _isFocused = focused;
          widget.onFocusChange(focused);
        },
        focusNode: _focusNode,
        shortcuts: {
          SingleActivator(LogicalKeyboardKey.goBack): const DismissIntent(),
        },
        actions: {
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (intent) => _focusNode.unfocus(),
          ),
        },
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _isFocused,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        widget.movie.titleImageUrl,
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white10,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        TextButton(
                            onPressed: () => {
                                  setState(() {
                                    selectedTabIndex = 0;
                                  })
                                },
                            onFocusChange: (value) => {
                                  setState(() {
                                    selectedTabIndex = 0;
                                  })
                                },
                            child: Text('EPISODES')),
                        TextButton(
                            onPressed: () {},
                            onFocusChange: (value) {},
                            child: Text('SUGGESTED')),
                        TextButton(
                            onPressed: () {},
                            onFocusChange: (value) {},
                            child: Text('DETAILS')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: selectedTabIndex,
                      children: [
                        EpisodesTab(),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
