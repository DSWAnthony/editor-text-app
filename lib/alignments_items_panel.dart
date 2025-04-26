import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:quill/custom_toolbar.dart';

class AlignmentsItemsPanel extends StatelessWidget {
  const AlignmentsItemsPanel({super.key, required this.controller});
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
            // Alignment styles row
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomToolbar.buildStyleButton(
                        Icons.format_align_left_rounded,
                        "left",
                        Attribute.leftAlignment,
                        controller,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: CustomToolbar.buildStyleButton(
                        Icons.format_align_center_rounded,
                        "center",
                        Attribute.centerAlignment,
                        controller,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: CustomToolbar.buildStyleButton(
                        Icons.format_align_right_rounded,
                        "right",
                        Attribute.rightAlignment,
                        controller,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade100,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           flex: 1,
            //           child: QuillToolbarIndentButton(
            //             controller: controller,
            //             isIncrease: true,
            //           ),
            //         ),
            //         const SizedBox(width: 8),
            //         Expanded(
            //           flex: 1,
            //           child: QuillToolbarIndentButton(
            //             controller: controller,
            //             isIncrease: false,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
