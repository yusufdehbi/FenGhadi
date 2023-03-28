import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  final bool isTaxiChecked;
  final bool isBusChecked;
  final bool isTramChecked;
  final Function(bool, bool, bool) onPreferenceChanged;

  const PreferencesPage({
    super.key,
    required this.isBusChecked,
    required this.isTaxiChecked,
    required this.isTramChecked,
    required this.onPreferenceChanged,
  });

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SwitchListTile(
        value: widget.isTaxiChecked,
        title: const Text('Taxi'),
        onChanged: (isChecked) {
          setState(() {
            widget.onPreferenceChanged(
                widget.isBusChecked, isChecked, widget.isTramChecked);
          });
        },
      ),
      SwitchListTile(
        value: widget.isBusChecked,
        title: const Text('Bus'),
        onChanged: (isChecked) {
          setState(() {
            widget.onPreferenceChanged(
                isChecked, widget.isTaxiChecked, widget.isTramChecked);
          });
        },
      ),
      SwitchListTile(
        value: widget.isTramChecked,
        title: const Text('Tram'),
        onChanged: (isChecked) {
          setState(() {
            widget.onPreferenceChanged(
                widget.isBusChecked, widget.isTaxiChecked, isChecked);
          });
        },
      ),
    ]);
  }
}
