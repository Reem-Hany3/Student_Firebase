import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  //============== object ==========
  final cloud = FirebaseFirestore.instance;

  //================ doc name ==================
  final String CollectionName = 'Students';

  //================ Controllers  ======================
  final nameControl = TextEditingController();
  final ageControl = TextEditingController();
  final gradeControl = TextEditingController();





  //============== Add Students =============


  Future<void> AddStudentsToServer() async {
    emit(HomeLoading());
    try {
      await cloud.collection(CollectionName).add({
        'Name': nameControl.text,
        'Age': ageControl.text,
        'Grade': gradeControl.text,
      });
      emit(AddStudentSuccess());
    }
    // ------------------------- Handle Errors  ------------
    catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }






//============== Get  Students From Servers  =============
  Future<void> getStudentsFromServer() async {
    emit(HomeLoading());

    try {
      final response= await cloud.collection(CollectionName).get();
      emit(GetStudentSuccess(response.docs));

    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }


  //================ Delete===================
  Future<void> deleteStudents(String id) async {
    emit(HomeLoading());

    try {
      await cloud.collection(CollectionName).doc(id).delete();
      emit(DeleteStudentSuccess());
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }


  //================ Update===================
  Future<void> updateStudent(String id) async {
    emit(HomeLoading());

    try {
      await cloud.collection(CollectionName).doc(id).update({

        'Name': nameControl.text,
        'Age': ageControl.text,
        'Grade': gradeControl.text,
      });
      emit(EditStudentSuccess());

    } catch (E) {
      emit(HomeFailure(E.toString()));
    }
  }



  //================ Close===================
  @override
  Future<void> close() {
    nameControl.dispose();
    ageControl.dispose();
    gradeControl.dispose();
    return super.close();
  }
}
