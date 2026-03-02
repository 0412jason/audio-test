import 'package:flutter/material.dart';

class MenuTracker {
  static final List<MenuController> _controllers = [];

  static void register(MenuController controller) {
    if (!_controllers.contains(controller)) {
      _controllers.add(controller);
    }
  }

  static void unregister(MenuController controller) {
    _controllers.remove(controller);
  }

  static bool closeAnyOpenMenu() {
    bool closedAny = false;
    for (var controller in _controllers.reversed) {
      if (controller.isOpen) {
        controller.close();
        closedAny = true;
      }
    }
    return closedAny;
  }
}

class TrackedDropdownMenu<T> extends StatefulWidget {
  final EdgeInsetsGeometry? expandedInsets;
  final Widget? label;
  final InputDecorationTheme? inputDecorationTheme;
  final T? initialSelection;
  final bool enabled;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final ValueChanged<T?>? onSelected;

  const TrackedDropdownMenu({
    super.key,
    this.expandedInsets,
    this.label,
    this.inputDecorationTheme,
    this.initialSelection,
    this.enabled = true,
    required this.dropdownMenuEntries,
    this.onSelected,
  });

  @override
  State<TrackedDropdownMenu<T>> createState() => _TrackedDropdownMenuState<T>();
}

class _TrackedDropdownMenuState<T> extends State<TrackedDropdownMenu<T>> {
  final MenuController _controller = MenuController();

  @override
  void initState() {
    super.initState();
    MenuTracker.register(_controller);
  }

  @override
  void dispose() {
    MenuTracker.unregister(_controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      menuController: _controller,
      expandedInsets: widget.expandedInsets,
      label: widget.label,
      inputDecorationTheme: widget.inputDecorationTheme,
      initialSelection: widget.initialSelection,
      enabled: widget.enabled,
      dropdownMenuEntries: widget.dropdownMenuEntries,
      onSelected: widget.onSelected,
    );
  }
}
