import 'package:flutter/material.dart';

class DepartementDropdown extends StatelessWidget {
  final List<String> departements;
  final String departement;
  final Function(String) onChanged;

  const DepartementDropdown({
    @required this.departements,
    @required this.departement,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: departement,
            items: departements
                .map(
                  (dep) => DropdownMenuItem(
                    child: Row(
                      children: <Widget>[
                        Text(
                          dep.contains('97')
                              ? dep.substring(0, 3) + ' -'
                              : dep.substring(0, 2) + ' -',
                        ),
                        const SizedBox(width: 10),
                        Text(
                          dep.contains('97')
                              ? dep.substring(4)
                              : dep.substring(3),
                        ),
                      ],
                    ),
                    value: dep,
                  ),
                )
                .toList(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
