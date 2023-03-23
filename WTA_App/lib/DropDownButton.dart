import 'package:flutter/material.dart';

const List<String> issuesList = <String>[
  'Drainage',
  'Fallen Tree',
  'Trail Erosion',
  'Overgrown Shrubbery',
  'Damage to Man-made Structure',
  'Other (Specify in Description)'
];

String issue = 'no issue selected';

class _DropDownButtonState extends State<DropDownButton> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropDownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      hint: Text('Select an issue'),
      underline: Container(
        height: 2,
      ),
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
          print('Issues Drop-Down Menu Field: $value');
          issue = value;
        });
      },
      items: issuesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}
