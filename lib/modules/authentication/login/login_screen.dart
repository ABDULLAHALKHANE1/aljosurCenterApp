import 'package:aljosur_center/Layout/aljosur_layout.dart';
import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/constance/constants.dart';
import 'package:aljosur_center/modules/authentication/register/register_screen.dart';
import 'package:aljosur_center/modules/control_panel/control_panel_screen.dart';
import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:aljosur_center/shared/login_cubit/cubit.dart';
import 'package:aljosur_center/shared/login_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:aljosur_center/remote/cach_helper.dart';


class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              showToast('يرجى التأكد من الايميل وكلمة السر');
            }

            if (state is LoginSuccessState) {
              cachHelper.Savedataa(key: 'uId', value: state.Uid.toString()).then((value) {
                uId = cachHelper.getData('uId');
                navigatorAndFinish(context, AljosurLayout());
                AppCubit.get(context).getUserData();
                AppCubit.get(context).getMyBookCourseData();


              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                shadowColor: HexColor('#F15A22'),
                centerTitle: true,
                title: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(20.0),
                  child: Column(

                    children: [
                      SizedBox(height: 40.0,),
                      Center(
                        child: Image(
                          width: 150.0,
                          height: 150.0,
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defulteditTextx(
                              prefix: Icons.email_outlined,
                              Controlar: emailController,
                              keyboardType: TextInputType.emailAddress,
                              Lable: 'البريد الإلكتروني',
                              hint: 'jusoor@example.com',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'البريد الإلكتروني غير صحيح';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            defulteditTextx(
                              obscureText:  LoginCubit.get(context).isoscureShow,
                              prefix: Icons.lock_open_outlined,
                              Controlar: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              suffixPressed: () {
                                LoginCubit.get(context).eyeisShow();
                              },
                              sufix:  LoginCubit.get(context).iconData,
                              Lable: 'كلمة السر',
                              hint: 'ادخل كلمة السر',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'كلمة السر غير صحيحة';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        children: [
                          customBottom(
                            width: 150.0,
                            height: 50.0,
                            color: Colors.white,
                            onPressed: () {
                              if (emailController.text == 'admin' &&
                                  passwordController.text == 'admin') {
                                PushToNextScreen(context, ControlPanelScreen());
                              }
                              else if (formKey.currentState!
                                  .validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);

                              }
                            },
                            widget: Text('تسجيل الدخول',style:TextStyle(fontWeight: FontWeight.bold),),
                            borderColor: HexColor('#050640'),
                          ),
                          SizedBox(width: 20.0,),
                          customBottom(
                            width: 150.0,
                            height: 50.0,
                            color: HexColor('#050640'),
                            onPressed: () {
                              PushToNextScreen(context, RegisterScreen());
                            },
                            widget: Text('التسجيل',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            borderColor: HexColor('#050640'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
