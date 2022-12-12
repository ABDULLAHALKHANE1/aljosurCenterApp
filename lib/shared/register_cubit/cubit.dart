import 'dart:io';
import 'package:aljosur_center/constance/constants.dart';
import 'package:aljosur_center/model/user_model.dart';
import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData iconData = Icons.visibility_outlined;

  bool isoscureShow = true;

  void eyeisShow() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(RegisterShowPassword());
  }


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required BuildContext context,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          image: image,
          context: context,
        );

      },

    ).catchError(
      (error) {
        print(error);
        emit(RegisterErrorState());
      },
    );
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String image,
    required  context,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: image,
      token: token
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then(
      (value) {
        emit(RegisterCreateUserSuccessState(uId));
      },
    ).catchError(
      (error) {
        emit(RegisterCreateUserErrorState());
      },
    );
  }

  File? profileImage;

  final picker = ImagePicker();

  Future getProfileImage() async {
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      profileImage = File(pikedFile.path);
      emit(RegisterImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(RegisterImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage!.path).pathSegments.last}',
        )
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(RegisterUploadImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(RegisterUploadImageErrorState());
        print(error.toString());
        print('error 1');
      });
    }).catchError((error) {
      emit(RegisterUploadImageErrorState());
      print('error 2');
    });
  }
}
