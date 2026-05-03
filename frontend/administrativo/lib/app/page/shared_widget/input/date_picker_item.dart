import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerItem extends StatefulWidget {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? mask;
  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;
  final bool? readOnly;
  final String? Function(DateTime?)? validator;

  DatePickerItem({
    Key? key,
    DateTime? dateTime,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.mask,
    this.readOnly,
    this.validator,
  })  : date = dateTime == null ? null : DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  @override
  DatePickerItemState createState() => DatePickerItemState();
}

class DatePickerItemState extends State<DatePickerItem> {
  DateTime? _currentDate;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.date;
    _validateDate(_currentDate);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var today = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: theme.textTheme.titleMedium!,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: _errorText != null ? theme.colorScheme.error : theme.dividerColor),
                    ),
                  ),
                  child: InkWell(
                    onDoubleTap: () {
                      _updateDate(null);
                    },
                    onTap: () {
                      if (widget.readOnly == null || widget.readOnly == false) {
                        showDatePicker(
                          context: context,
                          initialDate: _currentDate ?? today,
                          firstDate: widget.firstDate!,
                          lastDate: widget.lastDate!,
                        ).then<void>((DateTime? value) {
                          if (value != null) {
                            _updateDate(DateTime(value.year, value.month, value.day));
                          }
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            _currentDate != null ? DateFormat(widget.mask ?? 'dd/MM/yyyy').format(_currentDate!) : '',
                          ),
                        ),
                        const Expanded(
                          flex: 0,
                          child: Icon(Icons.arrow_drop_down, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }

  void _updateDate(DateTime? newDate) {
    setState(() {
      _currentDate = newDate;
    });
    widget.onChanged(newDate);
    _validateDate(newDate);
  }

  void _validateDate(DateTime? date) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(date);
      });
    }
  }
}
