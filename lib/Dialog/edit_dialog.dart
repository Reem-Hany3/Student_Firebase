import 'package:flutter/material.dart';

import '../Home/Controller/home_cubit.dart';

Future<bool?> showEditDialog({
  required BuildContext context,
  required HomeCubit cubit,
  required String id,
  required Map<String, dynamic> student,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      cubit.nameControl.text = student["Name"];
      cubit.ageControl.text = student["Age"];
      cubit.gradeControl.text = student["Grade"];

      return AlertDialog(
        title: Text("Edit Student"),
        content: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              TextFormField(
                controller: cubit.nameControl,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              TextFormField(
                controller: cubit.ageControl,
                decoration: InputDecoration(
                  hintText: "Enter your age",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              TextFormField(
                controller: cubit.gradeControl,
                decoration: InputDecoration(
                  hintText: "Enter your grade",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () async {
              //============= Validation  ===========
              if (cubit.nameControl.text.trim().isEmpty ||
                  cubit.gradeControl.text.trim().isEmpty ||
                  cubit.ageControl.text.trim().isEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Please fill the fields",
                      style: TextStyle(fontSize: 20),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              await cubit.updateStudent(id);

              //=============  check on state

              if (!dialogContext.mounted) return;

              if (cubit.state is EditStudentSuccess) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
