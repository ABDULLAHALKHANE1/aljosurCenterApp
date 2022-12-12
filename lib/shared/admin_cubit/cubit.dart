import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/model/book_course_model.dart';
import 'package:aljosur_center/model/user_model.dart';
import 'package:aljosur_center/modules/control_panel/view_profile_personly.dart';
import 'package:aljosur_center/shared/admin_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates>{

  AdminCubit():super(InitialAdminState());

  static AdminCubit get(context) => BlocProvider.of(context);

  List<BookCourseModel> allBookCoursesModel = [];
  List<String> idAllBookCoursesModel = [];

  void getAllBookCourseData() {
    emit(AdminCubitGetAllBookCourseLoadingState());
    FirebaseFirestore.instance
        .collection('Booking').where('state', isEqualTo: '0')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allBookCoursesModel .add(BookCourseModel.fromJson(element.data()));
        idAllBookCoursesModel.add(element.id);
      });
      emit(AdminCubitGetAllBookCourseSuccessState());
    }).catchError(
          (error) {
        print(error.toString());
        emit(AdminCubitGetAllBookCourseErrorState());
      },
    );
  }


  void updateBookingSuccessReview({
    required String uIdUser,
    required String uIdCourse,
    required String nameUser,
    required String nameCourse,
    required String image,
    required String state,
    required String imageCourse,
    required String uIdBook,
    required  context,
  }) {
    emit(AdminCubitUpdateBookingReviewLoadingState());
    BookCourseModel bookCourseModel = BookCourseModel(
       uIdCourse:uIdCourse ,
        nameUser:nameUser ,
        nameCourse:nameCourse ,
        image:image ,
        imageCourse:imageCourse ,
         state: state,
        uIdUser: uIdUser);
    FirebaseFirestore.instance
        .collection('Booking')
        .doc(uIdBook)
        .update(bookCourseModel.toMap())
        .then((value) {
      emit(AdminCubitUpdateBookingReviewSuccessState());
      allBookCoursesModel.clear();
      idAllBookCoursesModel.clear();
      Navigator.pop(context);
      getAllBookCourseData();
    }).catchError((error) {
      print(error);
      print(uIdBook);
      emit(AdminCubitUpdateBookingReviewErrorState());
    });
  }

    void deleteBookingSuccessReview({
    required String uIdBook,
    required context,
  }) {
    emit(AdminCubitDeleteBookingReviewLoadingState());

    FirebaseFirestore.instance
        .collection('Booking')
        .doc(uIdBook)
        .delete()
        .then((value) {
      emit(AdminCubitDeleteBookingReviewSuccessState());
      allBookCoursesModel.clear();
      idAllBookCoursesModel.clear();
      Navigator.pop(context);
      getAllBookCourseData();
    }).catchError((error) {
      emit(AdminCubitDeleteBookingReviewErrorState());
    });
  }

  UserModel userModel = UserModel();

  void getUserData(uIdUser,context)
  {
    emit(AdminCubitGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users').doc(uIdUser)
        .get()
        .then((value) {
      userModel=UserModel.fromJson(value.data()!);
      emit(AdminCubitGetUserSuccessState());
      PushToNextScreen(context, ViewProfilePersonly());
    }).catchError(
          (error) {
        print(error.toString());
        emit(AdminCubitGetUserErrorState());
      },
    );
  }

}