import 'package:aljosur_center/Layout/aljosur_layout.dart';
import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/constance/constants.dart';
import 'package:aljosur_center/modules/authentication/login/login_screen.dart';
import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:aljosur_center/shared/register_cubit/cubit.dart';
import 'package:aljosur_center/shared/register_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:aljosur_center/remote/cach_helper.dart';

class RegisterScreen extends StatelessWidget {
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterCreateUserSuccessState) {
          cachHelper.Savedataa(key: 'uId', value: state.Uid.toString()).then((value) {
            uId = cachHelper.getData('uId');
            AppCubit.get(context).getUserData();
            navigatorAndFinish(context, AljosurLayout());
          });
        }
        if (state is RegisterUploadImageSuccessState) {
          RegisterCubit.get(context).userRegister(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            phone: phoneController.text,
            image: RegisterCubit.get(context).profileImageUrl,
            context: context,
          );
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = RegisterCubit.get(context);
        var profileImage = RegisterCubit.get(context).profileImage;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              shadowColor: HexColor('#F15A22'),
              centerTitle: true,
              title: const Text(
                'إنشاء حساب',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 50.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40.0,
                                  backgroundImage: profileImage == null
                                      ? const NetworkImage(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Person_icon_BLACK-01.svg/1200px-Person_icon_BLACK-01.svg.png',
                                        )
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                color: Colors.orange,
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          prefix: Icons.person_outline,
                          Controlar: nameController,
                          keyboardType: TextInputType.text,
                          Lable: 'اسم المستخدم',
                          // prefix: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال اسم المستخدم';
                            }
                            return null;
                          },
                          hint: 'ادخل اسم المستخدم',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          prefix: Icons.email_outlined,
                          Controlar: emailController,
                          keyboardType: TextInputType.text,
                          Lable: 'البريد الالكتروني',
                          //prefix: Icons.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال البريد الالكتروني';
                            }
                            return null;
                          },
                          hint: 'jusoor@example.com',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          prefix: Icons.lock_open_outlined,
                          Controlar: passwordController,
                          keyboardType: TextInputType.text,
                          Lable: 'كلمة السر',
                          //prefix: Icons.lock,
                          sufix: cubit.iconData,
                          obscureText: cubit.isoscureShow,
                          suffixPressed: () {
                            cubit.eyeisShow();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال كلمة سر صحيحة';
                            }
                            return null;
                          },
                          onfiled: (value) {
                            print(value);
                          },
                          hint: 'ادخل كلمة السر',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          prefix: Icons.add_ic_call_rounded,
                          Controlar: phoneController,
                          keyboardType: TextInputType.phone,
                          Lable: 'الموبايل',
                          //prefix: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال رقم الهاتف';
                            }
                            return null;
                          },
                          hint: '0000000000',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Center(
                          child: state is! RegisterLoadingState
                              ? customBottom(
                                  widget: Text(
                                    'ابدأ الآن',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  borderColor: HexColor('#050640'),
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 50.0,
                                  color: HexColor('#050640'),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (profileImage != null) {
                                        cubit.uploadProfileImage();
                                      } else {
                                        RegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          image: RegisterCubit.get(context).profileImageUrl,
                                          context: context,
                                        );
                                      }
                                    }
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'انت تملك حساب بالفعل ؟',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                PushToNextScreen(context, LoginScreen());
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: HexColor('#F15A22'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
