import 'package:edgar/colors.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

/// A custom date Picker
// ignore: must_be_immutable
class CustomDatePiker extends StatefulWidget {
  /// Data Picker constructor
  const CustomDatePiker({
    super.key,
    this.startDate,
    this.endDate,
    this.initialValue,
    this.placeholder,
    this.onChanged,
    this.label,
    this.isRequired = false,
    this.errorText,
  });

  /// The start date of the date picker
  final DateTime? startDate;

  /// The end date
  final DateTime? endDate;

  /// The initial value of the date picker
  final String? initialValue;

  /// The placeholder if there is no value
  final String? placeholder;

  /// The label text above the date picker
  final String? label;

  /// Whether the field is required
  final bool isRequired;

  /// Error text to display below the date picker
  final String? errorText;

  /// Callback function when date changes
  final ValueChanged<String>? onChanged;

  @override
  State<CustomDatePiker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePiker> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(CustomDatePiker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
    }
  }

  DateTime _parseDate(String date) {
    final parts = date.split('/');
    return DateTime(
      int.parse(parts[2]), // year
      int.parse(parts[1]), // month
      int.parse(parts[0]), // day
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
  }

  Future<void> _showDatePicker() async {
    final DateTime initialDate =
        _value != null ? _parseDate(_value!) : DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: widget.startDate ?? DateTime(1900),
      lastDate: widget.endDate ?? DateTime(2100),
      locale: const Locale('fr', 'FR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blue500,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      final formattedDate = _formatDate(selectedDate);
      setState(() => _value = formattedDate);
      widget.onChanged?.call(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              if (widget.isRequired)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        InkWell(
          onTap: _showDatePicker,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    widget.errorText != null ? Colors.red : AppColors.blue500,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _value ?? widget.placeholder ?? '',
                    style: TextStyle(
                      color:
                          _value != null ? AppColors.black : AppColors.grey400,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  BootstrapIcons.calendar3,
                  color: AppColors.grey400,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
