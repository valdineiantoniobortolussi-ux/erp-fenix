import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropdownButton extends StatefulWidget {
  final String value;
  final String labelText;
  final String hintText;
  final List<String> items;
  final ValueChanged<dynamic> onChanged;
  final Function(dynamic)? validator;

  const CustomDropdownButton({
    Key? key,
    required this.value,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  CustomDropdownButtonState createState() => CustomDropdownButtonState();
}

class CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  KeyEventResult _handleKeyboardNavigation(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      int currentIndex = widget.items.indexOf(_selectedValue);

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          currentIndex = (currentIndex + 1) % widget.items.length;
          _selectedValue = widget.items[currentIndex];
        });
        widget.onChanged(_selectedValue);
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          currentIndex = (currentIndex - 1) < 0
              ? widget.items.length - 1
              : currentIndex - 1;
          _selectedValue = widget.items[currentIndex];
        });
        widget.onChanged(_selectedValue);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleKeyboardNavigation,
      child: DropdownButtonFormField<String>(
			  isExpanded: true,
        value: _selectedValue,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: const UnderlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 8,
          ),
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        validator: widget.validator as String? Function(dynamic)?,
      ),
    );
  }
}