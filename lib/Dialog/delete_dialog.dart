import 'package:flutter/material.dart';

import '../Home/Controller/home_cubit.dart';

Future<bool?> showDeleteDialog({
  required BuildContext context,
  required HomeCubit cubit,
  required String id,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text("Delete Student"),
        content: Text("Are you SureYou Want to delete  student?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await cubit.deleteStudents(id);

              if (!dialogContext.mounted) return;

              //================ check on state

              if (cubit.state is DeleteStudentSuccess) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}