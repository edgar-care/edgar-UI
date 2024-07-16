import 'package:edgar/colors.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

/// A custom date Picker
// ignore: must_be_immutable
class CustomDatePiker extends StatefulWidget {
  /// The star date of the datePciker
  final DateTime? startDate;

  /// The endDate
  final DateTime? endDate;

  /// The value of the date picker
  String? value;

  /// The placeHolder if there is no value
  final String? placeHolder;

  /// Function on change
  final Function(String)? onChanged;

  // ignore: public_member_api_docs
  CustomDatePiker({
    super.key,
    this.startDate,
    this.endDate,
    this.value,
    this.placeHolder,
    this.onChanged,
  });

  @override
  State<CustomDatePiker> createState() => _CustomDatePikerState();
}

class _CustomDatePikerState extends State<CustomDatePiker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blue500, width: 2),
      ),
      child: InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: widget.value != null
                ? DateTime(
                    int.parse(widget.value!.split('/')[2]), // year
                    int.parse(widget.value!.split('/')[1]), // month
                    int.parse(widget.value!.split('/')[0]), // day
                  )
                : DateTime.now(),
            firstDate:
                widget.startDate != null ? widget.startDate! : DateTime(1900),
            lastDate: widget.endDate != null ? widget.endDate! : DateTime(2100),
            locale: const Locale('fr', 'FR'),
          ).then(
            (value) {
              if (value != null) {
                setState(() {
                  widget.value =
                      '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year.toString()}';
                });
                widget.onChanged?.call(
                    '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year.toString()}');
              }
            },
          );
        },
        child: Row(
          children: [
            if (widget.placeHolder != null) ...[
              Text(
                widget.value ?? widget.placeHolder!,
                style: TextStyle(
                  color: widget.value != null
                      ? AppColors.black
                      : AppColors.grey400,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const Spacer(),
            const Icon(
              BootstrapIcons.calendar3,
              color: AppColors.grey400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
