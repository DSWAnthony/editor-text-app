import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:quill/custom_toolbar.dart';

class StylesItemsPanel extends StatelessWidget {
  const StylesItemsPanel({super.key, required this.controller});

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Heading styles row
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomToolbar.buildStyleButton(
                      Icons.h_plus_mobiledata_rounded,
                      'H1',
                      Attribute.h1,
                      controller,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomToolbar.buildStyleButton(
                      Icons.h_plus_mobiledata_rounded,
                      'H2',
                      Attribute.h2,
                      controller,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomToolbar.buildStyleButton(
                      Icons.h_plus_mobiledata_rounded,
                      'H3',
                      Attribute.h3,
                      controller,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomToolbar.buildStyleButton(
                      Icons.h_plus_mobiledata_rounded,
                      'H3',
                      Attribute.header,
                      controller,
                    ),
                  ),
                ],
              ),
            ),

            // Text formatting row
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  // Left group - Text style buttons
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_bold,
                              'Negrita',
                              Attribute.bold,
                              controller,
                            ),
                          ),
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_italic,
                              'Itálica',
                              Attribute.italic,
                              controller,
                            ),
                          ),
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_underline,
                              'Subrayado',
                              Attribute.underline,
                              controller,
                            ),
                          ),
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_strikethrough,
                              'Tachado',
                              Attribute.strikeThrough,
                              controller,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Right group - Text color button
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: QuillToolbarColorButton(
                              controller: controller,
                              isBackground: false,
                              baseOptions: QuillToolbarColorButtonOptions(
                                iconData: Icons.format_color_text,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // List and quote formatting row
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  // Left group - List formatting buttons
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_list_bulleted,
                              'Lista',
                              Attribute.ul,
                              controller,
                            ),
                          ),
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_list_numbered,
                              'Lista numerada',
                              Attribute.ol,
                              controller,
                            ),
                          ),
                          Expanded(
                            child: CustomToolbar.buildStyleButton(
                              Icons.format_quote,
                              'Cita',
                              Attribute.blockQuote,
                              controller,
                            ),
                          ),
                          Expanded(
                            child: QuillToolbarLinkStyleButton(
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Right group - Alignment options
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: QuillToolbarColorButton(
                              controller: controller,
                              isBackground: true,
                              baseOptions: QuillToolbarColorButtonOptions(
                                iconData: Icons.format_color_fill_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Font family row
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: QuillToolbarFontFamilyButton(
                        controller: controller,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: QuillToolbarToggleStyleButton(
                              controller: controller,
                              attribute: Attribute.inlineCode,
                            ),
                          ),
                        ],
                      ),
                    ),
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
