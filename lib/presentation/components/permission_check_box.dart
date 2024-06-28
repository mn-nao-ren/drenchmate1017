import 'package:flutter/material.dart';

class PermissionCheckbox extends StatefulWidget {
  final String title;
  final List<String> permissions;
  final ValueChanged<List<String>> onChanged;

  const PermissionCheckbox({
    super.key,
    required this.title,
    required this.permissions,
    required this.onChanged,
  });

  @override
  _PermissionCheckboxState createState() => _PermissionCheckboxState();
}

class _PermissionCheckboxState extends State<PermissionCheckbox> {
  List<String> selectedPermissions = [];

  @override
  void initState() {
    super.initState();
    selectedPermissions = List.from(widget.permissions);
  }

  void _onPermissionChanged(String permission, bool? selected) {
    setState(() {
      if (selected == true) {
        if (!selectedPermissions.contains(permission)) {
          selectedPermissions.add(permission);
        }
      } else {
        selectedPermissions.remove(permission);
      }
      widget.onChanged(selectedPermissions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        CheckboxListTile(
          title: const Text('Create'),
          value: selectedPermissions.contains('Create'),
          onChanged: (bool? selected) => _onPermissionChanged('Create', selected),
        ),
        CheckboxListTile(
          title: const Text('View'),
          value: selectedPermissions.contains('View'),
          onChanged: (bool? selected) => _onPermissionChanged('View', selected),
        ),
        CheckboxListTile(
          title: const Text('Update'),
          value: selectedPermissions.contains('Update'),
          onChanged: (bool? selected) => _onPermissionChanged('Update', selected),
        ),
        CheckboxListTile(
          title: const Text('Delete'),
          value: selectedPermissions.contains('Delete'),
          onChanged: (bool? selected) => _onPermissionChanged('Delete', selected),
        ),
      ],
    );
  }
}
