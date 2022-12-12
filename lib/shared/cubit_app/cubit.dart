import 'dart:io';

import 'package:aljosur_center/Layout/aljosur_layout.dart';
import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/constance/constants.dart';
import 'package:aljosur_center/model/add_course_model.dart';
import 'package:aljosur_center/model/book_course_model.dart';
import 'package:aljosur_center/model/user_model.dart';
import 'package:aljosur_center/modules/authentication/login/login_screen.dart';
import 'package:aljosur_center/modules/home/home_screen.dart';
import 'package:aljosur_center/modules/my_courses/my_courses_screen.dart';
import 'package:aljosur_center/shared/cubit_app/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aljosur_center/remote/cach_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../modules/my_account/my_account_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppCubitInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    HomeScreen(),
    MyCoursesScreen(),
    MyAccountScreen(),
  ];

  List<String> titles = [
    'الرئيسية',
    'دوراتي',
    'حسابي',
  ];

  void onChangeScreen(int index,context) {
    if(index==2 && uId==null){
      PushToNextScreen(context, LoginScreen());
    }else
    currentIndex = index;
    emit(AppCubitChangeBottomNavigationState());
  }


  void logOut(context) {
      cachHelper.removeData('uId');
      uId=cachHelper.getData('uId');
      print(uId);
      navigatorAndFinish(context, AljosurLayout());
      emit(AppCubitLogOutState());

  }

  List<AddCourseModel> coursesModel = [];
  List<String> idCoursesModel = [];

  void getCourseData() {

    emit(AppCubitGetCourseLoadingState());
    FirebaseFirestore.instance.collection('Courses').get().then((value) {
      value.docs.forEach((element) {
        coursesModel.add(AddCourseModel.fromJson(element.data()));
        idCoursesModel.add(element.id);
      });
      emit(AppCubitGetCourseSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(AppCubitGetCourseErrorState());
      },
    );
  }

  UserModel userModel = UserModel();

  void getUserData() {
    if(uId!=null){
    emit(AppCubitGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppCubitGetUserSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(AppCubitGetUserErrorState());
      },
    );
  }
  }

  File? paymentImage;

  final picker = ImagePicker();

  Future getPaymentImage() async {
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      paymentImage = File(pikedFile.path);
      emit(AppCubitPaymentImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(AppCubitPaymentImagePickedErrorState());
    }
  }

  String PaymentImageUrl = '';

  void uploadPaymentImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'Payments/${Uri.file(paymentImage!.path).pathSegments.last}',
        )
        .putFile(paymentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        PaymentImageUrl = value;
        emit(AppCubitPaymentUploadImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(AppCubitPaymentUploadImageErrorState());
        print(error.toString());
        print('error 1');
      });
    }).catchError((error) {
      emit(AppCubitPaymentUploadImageErrorState());
      print('error 2');
    });
  }

  void bookCourse({
    required String nameCourse,
    required String imageCourse,
    required String image,
    required String uIdUser,
    required String nameUser,
    required String uIdCourse,
  }) {
    emit(AppCubitBookCourseLoadingState());
    BookCourseModel model = BookCourseModel(
      nameCourse: nameCourse,
      nameUser: nameUser,
      imageCourse: imageCourse,
      uIdUser: uIdUser,
      image: image,
      state: '0',
      uIdCourse: uIdCourse,
    );
    FirebaseFirestore.instance.collection('Booking').add(model.toMap()).then(
      (value) {
        emit(AppCubitBookCourseSuccessState());
      },
    ).catchError(
      (error) {
        emit(AppCubitBookCourseErrorState());
      },
    );
  }

  List<BookCourseModel> myBookCoursesModel = [];

  void getMyBookCourseData() {
   if(uId!=null) {
      emit(AppCubitGetMyBookCourseLoadingState());
      FirebaseFirestore.instance
          .collection('Booking')
          .where('uIdUser', isEqualTo: uId)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          myBookCoursesModel.add(BookCourseModel.fromJson(element.data()));
        });
        emit(AppCubitGetMyBookCourseSuccessState());
      }).catchError(
        (error) {
          print(error.toString());
          emit(AppCubitGetMyBookCourseErrorState());
        },
      );
    }
  }

  AddCourseModel myCourseDetailsModel = AddCourseModel();

  void getMyCourseDetailsData(idCourse) {
    emit(AppCubitGetMyCourseDetailsLoadingState());
    FirebaseFirestore.instance
        .collection('Courses')
        .doc(idCourse)
        .get()
        .then((value) {
      myCourseDetailsModel = AddCourseModel.fromJson(value.data()!);
      emit(AppCubitGetMyCourseDetailsSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(AppCubitGetMyCourseDetailsErrorState());
      },
    );
  }
}
