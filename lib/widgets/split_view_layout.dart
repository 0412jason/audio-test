import 'package:flutter/material.dart';

class SplitViewLayout extends StatefulWidget {
  final String title;
  final Widget Function() builder;
  final int initialSplitCount;

  const SplitViewLayout({
    super.key,
    required this.title,
    required this.builder,
    this.initialSplitCount = 1,
  });

  @override
  State<SplitViewLayout> createState() => _SplitViewLayoutState();
}

class _SplitViewLayoutState extends State<SplitViewLayout> {
  late int _splitCount;

  @override
  void initState() {
    super.initState();
    _splitCount = widget.initialSplitCount;
  }

  void _increaseSplit() {
    setState(() {
      if (_splitCount == 1) {
        _splitCount = 2;
      } else if (_splitCount == 2) {
        _splitCount = 4;
      }
    });
  }

  void _decreaseSplit() {
    setState(() {
      if (_splitCount == 4) {
        _splitCount = 2;
      } else if (_splitCount == 2) {
        _splitCount = 1;
      }
    });
  }

  Widget _buildGrid() {
    if (_splitCount == 1) {
      return widget.builder();
    } else if (_splitCount == 2) {
      return Row(
        children: [
          Expanded(child: widget.builder()),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: widget.builder()),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: widget.builder()),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: widget.builder()),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: Row(
              children: [
                Expanded(child: widget.builder()),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: widget.builder()),
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _splitCount > 1 ? _decreaseSplit : null,
            ),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _splitCount < 4 ? _increaseSplit : null,
            ),
          ],
        ),
        Expanded(child: _buildGrid()),
      ],
    );
  }
}
