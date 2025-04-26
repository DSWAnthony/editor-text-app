import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:quill/alignments_items_panel.dart';
import 'package:quill/custom_toolbar.dart';
import 'package:quill/preview_screen.dart';
import 'package:quill/quill_delta_sample.dart';
import 'package:quill/styles_items_panel.dart'; // Make sure this import is correct

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();

  double _keyboardHeight = 0;
  double _lastKeyboardHeight = 0;
  bool _showStylesPanel = false;
  bool _showAlignmentsPanel = false;

  @override
  void initState() {
    super.initState();
    _controller.document = Document.fromJson(kQuillDefaultSample);
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      setState(() {
        _keyboardHeight = height;
        if (height > 0) {
          _lastKeyboardHeight = height;
          _showStylesPanel = false;
          _showAlignmentsPanel = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _keyboardHeightPlugin.dispose();
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  void _toggleStylesPanel(bool show) {
    if (show) _editorFocusNode.unfocus();
    setState(() {
      if (_showAlignmentsPanel) _toggleAlignmentsPanel(false);
      _showStylesPanel = show;
    });
  }

  void _toggleAlignmentsPanel(bool show) {
    if (show) _editorFocusNode.unfocus();
    setState(() {
      if (_showStylesPanel) _toggleStylesPanel(false);
      _showAlignmentsPanel = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = _editorFocusNode.hasFocus;
    final hasSelection =
        _controller.selection.isValid && !_controller.selection.isCollapsed;
    final showToolbar = hasFocus || hasSelection || _showAlignmentsPanel;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => PreviewScreen(
                        deltaJson: _controller.document.toDelta().toJson(),
                      ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Note saved')));
              debugPrint(jsonEncode(_controller.document.toDelta().toJson()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: QuillEditor(
                focusNode: _editorFocusNode,
                scrollController: _editorScrollController,
                controller: _controller,
                config: QuillEditorConfig(
                  expands: true,
                  placeholder: 'Start writing your notes...',
                  padding: const EdgeInsets.all(16),
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
                    ),
                  ],
                ),
              ),
            ),

            if (showToolbar)
              Positioned(
                bottom:
                    _keyboardHeight > 0
                        ? _keyboardHeight
                        : (_showStylesPanel || _showAlignmentsPanel
                            ? _lastKeyboardHeight
                            : 0),
                left: 0,
                right: 0,
                height: 45,
                child: Material(
                  elevation: 8,
                  child: CustomToolbar(
                    controller: _controller,
                    focusNode: _editorFocusNode,
                    isStylesPanelOpen: _showStylesPanel,
                    isAlignmentsPanelOpen: _showAlignmentsPanel,
                    onToggleStyles: _toggleStylesPanel,
                    onToggleAlignments: _toggleAlignmentsPanel,
                  ),
                ),
              ),

            if (_showStylesPanel && _lastKeyboardHeight > 0)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: _lastKeyboardHeight,
                child: StylesItemsPanel(controller: _controller),
              ),
            if (_showAlignmentsPanel && _lastKeyboardHeight > 0)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: _lastKeyboardHeight,
                child: AlignmentsItemsPanel(controller: _controller),
              ),
          ],
        ),
      ),
    );
  }
}
