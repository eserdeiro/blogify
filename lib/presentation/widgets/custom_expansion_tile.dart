import 'package:blogify/config/helpers/formats.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Function(GenderType)? onChanged;
  final String? errorText;

  const CustomExpansionTile({
    super.key,
    this.onChanged,
    this.errorText,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

enum GenderType { male, female, nn }

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  GenderType gender = GenderType.nn;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.primary,
        ),
      ),
      child: ExpansionTile(
        key: GlobalKey(),
        shape: const Border(),
        title: Text(
          Formats.getGenderSelected(gender),
          style: TextStyle(
            color: widget.errorText == 'Required' ? Colors.red : Colors.white,
          ),
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          RadioListTile(
            title: const Text('Male'),
            value: GenderType.male,
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value!;
                widget.onChanged?.call(value);
                isExpanded = !isExpanded;
              });
            },
          ),
          RadioListTile(
            title: const Text('Female'),
            value: GenderType.female,
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value!;
                widget.onChanged?.call(value);
                isExpanded = !isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }
}
