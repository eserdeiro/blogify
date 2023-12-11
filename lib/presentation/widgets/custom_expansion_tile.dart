import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  
  const CustomExpansionTile({super.key});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}
enum Gender{male, female}

class _CustomExpansionTileState extends State<CustomExpansionTile> {

    Gender? selectedGender;
    bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colors.primary,
                  width:1,
                ),
              ),
              child: ExpansionTile(
               //  maintainState: true,
              shape: const Border(),
              title: Text('${getSelectedText(selectedGender)}'),
              onExpansionChanged: (expanded) {
                setState(() {
                  print('expanded $expanded');
                  isExpanded = expanded;
                });
              },
              initiallyExpanded: isExpanded,
                children: [
                  RadioListTile(
                    title: const Text('Male'),
                    value: Gender.male, 
                    groupValue: selectedGender, 
                    onChanged: (value) {
                      setState(() {
                        selectedGender = Gender.male; 
                        isExpanded = false;
                      });
                    }
                    ),
                  RadioListTile(
                    title: const Text('Female'),
                    value: Gender.female, 
                    groupValue: selectedGender, 
                    onChanged: (value) {
                      setState(() {
                        selectedGender = Gender.female;
                        isExpanded = false;
                      });
                    }
                    )
                ],
                ),
            );
  }

String getSelectedText(Gender? gender) {
  switch (gender) {
    case Gender.male:
      return 'Male';
    case Gender.female:
      return 'Female';
    case null:
      return 'Gender';
  } 
  }
}