import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class PreviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> deltaJson;

  const PreviewScreen({super.key, required this.deltaJson});

  @override
  Widget build(BuildContext context) {
    final quillController = QuillController(
      document: Document.fromJson(deltaJson),
      readOnly: true,
      selection: const TextSelection.collapsed(offset: 0),
      config: const QuillControllerConfig(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Previa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: QuillEditor(
          focusNode: FocusNode(),
          scrollController: ScrollController(),
          controller: quillController,
          config: QuillEditorConfig(
            expands: true,
            padding: const EdgeInsets.all(16),
            showCursor: false,
            embedBuilders: [
              ...FlutterQuillEmbeds.editorBuilders(
                imageEmbedConfig: QuillEditorImageEmbedConfig(
                  imageProviderBuilder: (context, imageUrl) {
                    if (imageUrl.startsWith('assets/')) {
                      return AssetImage(imageUrl);
                    }
                    return null;
                  },
                ),
                videoEmbedConfig: QuillEditorVideoEmbedConfig(
                  customVideoBuilder: (videoUrl, readOnly) => null,
                ),
              ),
              // TimeStampEmbedBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
