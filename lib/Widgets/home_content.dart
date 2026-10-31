import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Dialog/delete_dialog.dart';
import '../Dialog/edit_dialog.dart';
import '../Home/Controller/home_cubit.dart';
import '../Home/add_student_screen.dart';
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentScreen()),
          );

          if (!context.mounted) return;

          if (result == true) {

            //========= refresh
            await context.read<HomeCubit>().getStudentsFromServer();


            //========= handle success state
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Student added successfully",
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        backgroundColor: Colors.orange,
        label: Text(
          "Add Student",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "All Students",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {

          //================  Failure  ====================
          if (state is HomeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg, style: TextStyle(fontSize: 20)),
                backgroundColor: Colors.red,
              ),
            );
          }

          //================  Success  ====================
          if (state is EditStudentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Student edit success",
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          //================  Delete  ====================

          if (state is DeleteStudentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Student deleted success",
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },

        builder: (context, state) {

          //============== Handle Loading ========
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          //==========================    Handle Success ( Body Must Onlly View in Casw Of SUCESS  GETTING Data  ======
          if (state is GetStudentSuccess) {

            //=======  if empty
            if (state.students.isEmpty) {
              return Center(child: Text("No Students Yet !! "));
            }
            return ListView.separated(

              separatorBuilder: (context, index) => Divider(),
              itemCount: state.students.length,

              itemBuilder: (context, index) {
                final student = state.students[index];
                return ListTile(
                  title: Text("Name: ${student["name"]}"),
                  subtitle: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Age: ${student["age"]}"),
                      Text("Grade: ${student["grade"]}"),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      final cubit = BlocProvider.of<HomeCubit>(context);
                      if (value == "edit") {
                        final updated = await showEditDialog(
                          context: context,
                          cubit: cubit,
                          id: student.id,
                          student: student.data(),
                        );
                        if (updated == true) {
                          await cubit.getStudentsFromServer();
                        }
                      }
                      if (value == "delete") {
                        if (!context.mounted) return;
                        final deleted = await showDeleteDialog(
                          context: context,
                          cubit: cubit,
                          id: student.id,
                        );
                        if (deleted == true) {
                          await cubit.getStudentsFromServer();
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(value: "edit", child: Text("Edit")),
                      PopupMenuItem<String>(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                );
              },

            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
