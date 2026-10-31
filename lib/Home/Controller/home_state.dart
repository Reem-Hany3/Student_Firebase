part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeFailure extends HomeState {
  final String msg;
  HomeFailure(this.msg);

}

/// ------------------------------     Add Collection ------------------
/// --------------------------------  Edit  ------------------
/// ---------------------------------- Get --------------------
/// ----------------------------------Delete -----------------------


///------------------- Get Success ----------------
class GetStudentSuccess  extends HomeState{

   final List<QueryDocumentSnapshot<Map<String,dynamic>>>students;
   GetStudentSuccess(this.students);



}

///--------------------- Add Success  -------------------------
class AddStudentSuccess  extends HomeState{}

///--------------------- Edit Success  -------------------------
class EditStudentSuccess  extends HomeState{}

///--------------------- Delete Success  -------------------------
class DeleteStudentSuccess  extends HomeState{}

