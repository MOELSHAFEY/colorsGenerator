import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../logic/color_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = ColorLogic.randomColor();
  final List<Color> _history = [];

  void changeColor() {
    var newColor = ColorLogic.randomColor();
    while (newColor.value == _color.value) {
      newColor = ColorLogic.randomColor();
    }
    setState(() {
      _history.add(_color);
      _color = newColor;
    });
  }

  void undo() {
    if (_history.isEmpty) return;
    setState(() {
      _color = _history.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fg = ColorLogic.getForegroundColor(_color);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Home Screen', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            onPressed: _history.isEmpty ? null : undo,
            icon: const Icon(Icons.undo, color: Colors.red),
          ),
          IconButton(
            onPressed: () async {
              final hex = ColorLogic.getHex(_color);
              await Clipboard.setData(ClipboardData(text: hex));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Copied $hex')),
              );
            },
            icon: const Icon(Icons.copy, color: Colors.blue),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: changeColor,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 666),
          curve: Curves.easeOut,
          color: _color,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hello there',
                  style: TextStyle(
                    color: fg,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: _color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorLogic.isDark(_color)
                              ? Colors.white30
                              : Colors.black26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          "hex: ${ColorLogic.getHex(_color)}",
                          style: TextStyle(
                            color: fg.withOpacity(0.9),
                            fontSize: 16,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          "argb: ${ColorLogic.getArgb(_color)}",
                          style: TextStyle(
                            color: fg.withOpacity(0.9),
                            fontSize: 16,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap anywhere to change color',
                  style: TextStyle(color: fg.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
