import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/Controller/home_cubit.dart';

class AddStudentContent extends StatelessWidget {
  const AddStudentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Add your data'),
      ),

      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          //========== handle fail state
          if (state is HomeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red, content: Text(state.msg)),
            );
          }
        },

        builder: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                TextField(
                  controller: cubit.nameControl,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),


                TextField(
                  controller: cubit.ageControl,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Age',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),

                TextField(
                  controller: cubit.gradeControl,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Grade',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async{
                    if (cubit.nameControl.text.trim().isEmpty ||
                        cubit.gradeControl.text.trim().isEmpty ||
                        cubit.ageControl.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('please fill the fields'),
                        ),
                      );
                      return;
                    }

                    await cubit.AddStudentsToServer();

                    if (!context.mounted) return;

                    if (cubit.state is AddStudentSuccess) {
                      Navigator.pop(context, true);
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(50),
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}