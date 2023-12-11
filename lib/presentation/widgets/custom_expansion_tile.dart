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
                  //on error, color : Colors.red
                  color: colors.primary,
                  width:1,
                ),
              ),
              child: ExpansionTile(
                key: GlobalKey(),
               //  maintainState: true,
              shape: const Border(),
              title: Text(getSelectedText(selectedGender)),
              onExpansionChanged: (expanded) {
                setState(() {
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
                          isExpanded = !isExpanded;
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
                        isExpanded = !isExpanded;
                });
              })
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

//TODO REGISTER CUBIT 
// TODO USERNAME, GEN, NAME USERNAME INPUTS