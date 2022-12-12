import 'dart:io';
import 'package:aljosur_center/model/add_course_model.dart';
import 'package:aljosur_center/shared/add_course_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AddCoursesCubit extends Cubit<AddCoursesStates>{

  AddCoursesCubit():super(InitialAddCoursesState());
  File? CourseImage;

  static AddCoursesCubit get(context) => BlocProvider.of(context);


  final picker = ImagePicker();

  Future getCourseImage() async {
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      CourseImage = File(pikedFile.path);
      emit(AddCourseImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(AddCourseImagePickedErrorState());
    }
  }

  String CourseImageUrl = '';

  void uploadCourseImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
      'Courses/${Uri.file(CourseImage!.path).pathSegments.last}',
    )
        .putFile(CourseImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CourseImageUrl = value;
        emit(AddCourseUploadImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(AddCourseUploadImageErrorState());
        print(error.toString());
        print('error 1');
      });
    }).catchError((error) {
      emit(AddCourseUploadImageErrorState());
      print('error 2');
    });
  }


  void changDateCourseState() {
    emit(ChangDateCourseState());
  }
  void AddCourseCreate({
    required String nameCourse,
    required String description,
    required String countHours,
    required String image,
    required String countSession,
    required String dateCourse,
    required String linkCourseZoom,
    required String priceCourse,
  }) {
    AddCourseModel model = AddCourseModel(
      nameCourse:nameCourse,
      image:image ,
      description: description,
      state: '0',
       countHours:  countHours,
      countSession:countSession ,
      dateCourse: dateCourse,
      linkCourseZoom:linkCourseZoom ,
      priceCourse:priceCourse ,

    );
    FirebaseFirestore.instance
        .collection('Courses')
        .add(model.toMap())
        .then(
          (value) {
        emit(AddCourseSuccessState());
      },
    ).catchError(
          (error) {
        emit(AddCourseErrorState());
      },
    );
  }
}