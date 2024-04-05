import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';

class CustomCheckBox extends StatefulWidget {
  final String label;
  final ValueChanged<bool> onChange;
  final bool? initialValue;

  const CustomCheckBox({
    Key? key,
    required this.label,
    required this.onChange,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _value = true;

  void changeHandler() {
    setState(() {
      _value = !_value;
    });
    widget.onChange(_value);
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      _value = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Checkbox(
            checkColor: Theme.of(context).colorScheme.background,
            // activeColor: Theme.of(context).primaryColor,
            side: BorderSide(
                color: CustomTheme.black.withOpacity(0.4), width: 0.5),
            value: _value,
            onChanged: (value) => changeHandler(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        // const SizedBox(
        //   width: 8,
        // ),
        TextButton(
            onPressed: changeHandler,
            child: Text(
              widget.label,
              style: TextStyle(
                  color: CustomTheme.black.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}
