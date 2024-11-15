import 'package:edgar/colors.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';

/// A Field who follow the color of the application
class CustomField extends StatefulWidget {
  /// It's the label of the application
  final String label;

  /// Icon at the end of the text field
  final IconData? icon; // Changed from IconData to IconData?
  /// Bool define if it a password or no to put a visibility of the text
  final bool isPassword;

  /// It's the text Keyboard type
  final TextInputType keyboardType;

  /// Fuction onchange to define what will append on change
  final Function(String) onChanged;

  /// String to define a default value
  final String value; // Added onChanged parameter
  /// Int to define a max width of the widget
  final int? maxSize;

  /// Define the action to do on submit
  final TextInputAction action;

  /// Bool to define for the text field if it's not capitalize
  final bool? isNotCapitalize;

  /// Int to define the max lines of the text field
  final int maxLines;

  /// Take in required parameter a Label, a  fonction onchange, action.
  const CustomField({
    super.key,
    required this.label,
    this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.value = '',
    this.isNotCapitalize = false,
    this.maxSize,
    this.maxLines = 1,
    required this.action,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          // ignore: prefer_null_aware_operators
          width: widget.maxSize != null ? widget.maxSize?.toDouble() : null,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.blue500, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  obscureText: widget.isPassword && !_isPasswordVisible,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.action,
                  maxLines: widget.maxLines,
                  textCapitalization: widget.keyboardType ==
                              TextInputType.visiblePassword ||
                          widget.keyboardType == TextInputType.emailAddress ||
                          widget.isNotCapitalize == true
                      ? TextCapitalization.none
                      : TextCapitalization.sentences,
                  initialValue: widget.value,
                  style: const TextStyle(
                    color: AppColors.grey950,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    textBaseline: TextBaseline.ideographic,
                  ),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                        minWidth: 0, maxWidth: constraints.maxWidth),
                    border: InputBorder.none,
                    isDense: true,
                    hintText: widget.label,
                    
                    hintStyle: const TextStyle(
                      color: AppColors.grey400,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textBaseline: TextBaseline.ideographic,
                    ),
                  ),
                  onChanged: widget.onChanged,
                  autocorrect: true,
                ),
              ),
              if (widget.icon != null)
                Icon(widget.icon!, color: AppColors.grey950, size: 16),
              if (widget.isPassword)
                GestureDetector(
                  child: Icon(
                    _isPasswordVisible
                        ? BootstrapIcons.eye_slash_fill
                        : BootstrapIcons.eye_fill,
                    color: Colors.black,
                    size: 16,
                  ),
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

/// CustomFieldSearch class for a customizable search field with validation
class CustomFieldSearch extends StatefulWidget {
  /// It's the label of the text field
  final String label;

  /// It's the Icon at the end of it
  final Widget icon;

  /// It's the keyboard Type on click on the text field
  final TextInputType keyboardType;

  /// It's the fonction for what to do on validate
  final Function(String) onValidate;

  /// Doing only the validate
  final bool? onlyOnValidate;

  /// What to do on click on widget
  final Function()? onOpen;

  /// Required Parameter : Label, icon, keyboardType, onValidate
  const CustomFieldSearch({
    super.key,
    required this.label,
    required this.icon,
    required this.keyboardType,
    required this.onValidate,
    this.onlyOnValidate = false,
    this.onOpen,
  });

  @override
  State<CustomFieldSearch> createState() => _CustomFieldSearchState();
}

class _CustomFieldSearchState extends State<CustomFieldSearch> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode =
      FocusNode(); // Create a FocusNode for requesting focus

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.blue500, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: widget.keyboardType,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                    color: AppColors.grey950,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    textBaseline: TextBaseline.ideographic,
                  ),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: constraints.maxWidth,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    hintText: widget.label,
                    hintStyle: const TextStyle(
                      color: AppColors.grey400,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textBaseline: TextBaseline.ideographic,
                    ),
                  ),
                  onTap: widget.onOpen,
                  onTapAlwaysCalled: true,
                  onSubmitted: (value) {
                    widget.onValidate(value);
                    _controller.clear();
                  },
                  onChanged: (value) {
                    if (widget.onlyOnValidate == true) {
                      return;
                    }
                    widget.onValidate(value);
                  },
                  focusNode:
                      _focusNode, // Associate the FocusNode with the TextField
                ),
              ),
              GestureDetector(
                child: widget.icon,
                onTap: () {
                  widget.onValidate(_controller.text);
                  _controller.clear();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// TextField with an autocompletioon
class CustomAutoComplete extends StatefulWidget {
  /// The label of the widget
  final String label;

  /// The Icon at the end of the textfield
  final IconData icon;

  /// The keyboard Type
  final TextInputType keyboardType;

  /// The fonction on validate
  final Function(String) onValidate;

  /// The list of suggestion for the autocompletion
  final List<String> suggestions; // Added for suggestions list
  /// Required element : label, icon, keyboard type, onvalidate, suggestion
  const CustomAutoComplete({
    super.key,
    required this.label,
    required this.icon,
    required this.keyboardType,
    required this.onValidate,
    required this.suggestions, // Added for suggestions list
  });

  @override
  State<CustomAutoComplete> createState() => _CustomAutoComplete2State();
}

class _CustomAutoComplete2State extends State<CustomAutoComplete> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Adjust padding as needed
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: AppColors.blue500,
                width: 2.0), // Adjust border color and width if desired
          ),
          child: Row(
            children: [
              Expanded(
                child: EasyAutocomplete(
                    controller: _controller,
                    suggestions: widget.suggestions,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: widget.keyboardType,
                    decoration: InputDecoration(
                      hintText: widget.label,
                      border: InputBorder
                          .none, // Remove border for seamless appearance
                    ),
                    onChanged: (value) {
                      widget.onValidate(value);
                    },
                    suggestionBuilder: (data) {
                      return Container(
                          margin: const EdgeInsets.all(1),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(data,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins')));
                    }),
              ),
              GestureDetector(
                child: Icon(widget.icon, color: AppColors.grey950, size: 16.0),
                onTap: () => widget.onValidate(_controller.text),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// It a custom field for shearch an element with a maxline
class CustomFieldSearchMaxLines extends StatefulWidget {
  /// Label of the custom field
  final String label;

  /// Icon at the end of the custom field
  final Widget icon;

  /// Keyboard type on click on the custom field
  final TextInputType keyboardType;

  /// Function who take a string in parameter to do something on validate
  final Function(String) onValidate;

  /// Bool to know if do only on validate
  final bool? onlyOnValidate;

  /// Function to do something on open
  final Function()? onOpen;

  /// The maxlines
  final int maxLines;

  /// Required : Label , icon, keyboardType, onValidate, maxLines
  const CustomFieldSearchMaxLines({
    super.key,
    required this.label,
    required this.icon,
    required this.keyboardType,
    required this.onValidate,
    this.onlyOnValidate = false,
    this.onOpen,
    required this.maxLines,
  });

  @override
  State<CustomFieldSearchMaxLines> createState() =>
      _CustomFieldSearchMaxLinesState();
}

class _CustomFieldSearchMaxLinesState extends State<CustomFieldSearchMaxLines> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode =
      FocusNode(); // Create a FocusNode for requesting focus

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.blue500, width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: widget.maxLines,
                  keyboardType: widget.keyboardType,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                    color: AppColors.grey950,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    textBaseline: TextBaseline.ideographic,
                  ),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: constraints.maxWidth,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    hintText: widget.label,
                    hintStyle: const TextStyle(
                      color: AppColors.grey400,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textBaseline: TextBaseline.ideographic,
                    ),
                  ),
                  onTap: widget.onOpen,
                  onTapAlwaysCalled: true,
                  onSubmitted: (value) {
                    widget.onValidate(value);
                    _controller.clear();
                  },
                  onChanged: (value) {
                    if (widget.onlyOnValidate == true) {
                      return;
                    }
                    widget.onValidate(value);
                  },
                  focusNode:
                      _focusNode, // Associate the FocusNode with the TextField
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: widget.icon,
                ),
                onTap: () {
                  widget.onValidate(_controller.text);
                  _controller.clear();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
