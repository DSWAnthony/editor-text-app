import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class CustomToolbar extends StatelessWidget {
  const CustomToolbar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onToggleStyles,
    required this.isStylesPanelOpen,
    required this.isAlignmentsPanelOpen,
    required this.onToggleAlignments,
  });

  final QuillController controller;
  final FocusNode focusNode;
  final bool isStylesPanelOpen;
  final bool isAlignmentsPanelOpen;
  final Function(bool) onToggleStyles;
  final Function(bool) onToggleAlignments;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: kToolbarHeight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  final selection = controller.selection;
                  final showStyleButton =
                      selection.isValid && !selection.isCollapsed;

                  return Row(
                    children: [
                      if (showStyleButton)
                        IconButton(
                          icon: Icon(
                            Icons.text_fields,
                            color: isStylesPanelOpen ? Colors.white : null,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor:
                                isStylesPanelOpen
                                    ? Theme.of(context).primaryColorDark
                                    : Colors.transparent,
                            shape: const CircleBorder(),
                          ),
                          onPressed: () => onToggleStyles(!isStylesPanelOpen),
                          tooltip: 'Text styles',
                        ),
                      IconButton(
                        icon: Icon(
                          Icons.format_align_left_rounded,
                          color: isAlignmentsPanelOpen ? Colors.white : null,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              isAlignmentsPanelOpen
                                  ? Theme.of(context).primaryColorDark
                                  : Colors.transparent,
                          shape: const CircleBorder(),
                        ),
                        onPressed:
                            () => onToggleAlignments(!isAlignmentsPanelOpen),
                        tooltip: 'Aligments Styles',
                      ),

                      if (showStyleButton) QuillToolbarDivider.horizontal(),
                      if (showStyleButton)
                        QuillToolbarClearFormatButton(controller: controller),
                      if (!showStyleButton)
                        buildStyleButton(
                          Icons.format_bold,
                          'Negrita',
                          Attribute.bold,
                          controller,
                        ),
                      if (!showStyleButton)
                        buildStyleButton(
                          Icons.format_italic,
                          'Itálica',
                          Attribute.italic,
                          controller,
                        ),
                      if (!showStyleButton)
                        buildStyleButton(
                          Icons.format_underline,
                          'Subrayado',
                          Attribute.underline,
                          controller,
                        ),
                      if (!showStyleButton)
                        QuillToolbarColorButton(
                          controller: controller,
                          isBackground: false,
                          baseOptions: QuillToolbarColorButtonOptions(
                            iconData: Icons.format_color_text_rounded,
                          ),
                        ),
                      if (!showStyleButton)
                        QuillToolbarColorButton(
                          controller: controller,
                          isBackground: true,
                          baseOptions: QuillToolbarColorButtonOptions(
                            iconData: Icons.format_color_fill_rounded,
                          ),
                        ),
                      QuillToolbarToggleCheckListButton(controller: controller),
                      if (!showStyleButton)
                        QuillToolbarToggleStyleButton(
                          controller: controller,
                          attribute: Attribute.ol,
                        ),
                      if (!showStyleButton)
                        QuillToolbarToggleStyleButton(
                          controller: controller,
                          attribute: Attribute.ul,
                        ),
                      if (!showStyleButton)
                        QuillToolbarToggleStyleButton(
                          controller: controller,
                          attribute: Attribute.inlineCode,
                        ),
                      if (!showStyleButton)
                        QuillToolbarToggleStyleButton(
                          controller: controller,
                          attribute: Attribute.blockQuote,
                        ),

                      QuillToolbarIndentButton(
                        controller: controller,
                        isIncrease: true,
                      ),
                      QuillToolbarIndentButton(
                        controller: controller,
                        isIncrease: false,
                      ),
                      QuillToolbarImageButton(controller: controller),
                      QuillToolbarCameraButton(controller: controller),
                      QuillToolbarVideoButton(controller: controller),
                      if (!showStyleButton)
                        QuillToolbarLinkStyleButton(controller: controller),
                      QuillToolbarDivider.horizontal(),
                      QuillToolbarHistoryButton(
                        isUndo: true,
                        controller: controller,
                      ),
                      QuillToolbarHistoryButton(
                        isUndo: false,
                        controller: controller,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        QuillToolbarDivider.horizontal(space: 3),
        IconButton(
          icon: const Icon(Icons.keyboard_hide),
          onPressed: () {
            focusNode.unfocus();
            onToggleStyles(false);
            onToggleAlignments(false);
          },
        ),
      ],
    );
  }

  static Widget buildStyleButton(
    IconData icon,
    String tooltip,
    Attribute attribute,
    QuillController controller,
  ) {
    return QuillToolbarToggleStyleButton(
      controller: controller,
      attribute: attribute,
      options: QuillToolbarToggleStyleButtonOptions(
        tooltip: tooltip,
        iconData: icon,
        iconSize: 15,
      ),
    );
  }
}
