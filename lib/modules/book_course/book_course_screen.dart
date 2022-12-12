import 'package:aljosur_center/Layout/aljosur_layout.dart';
import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:aljosur_center/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class BookCourseScreen extends StatelessWidget {
  final String imageCourse;
  final String nameCourse;
  final String uIdCourse;

  const BookCourseScreen(
      {required this.imageCourse, required this.nameCourse, Key? key, required this.uIdCourse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppCubitPaymentUploadImageSuccessState) {
            AppCubit.get(context).bookCourse(
              nameCourse: nameCourse,
              imageCourse:imageCourse ,
              image: AppCubit.get(context).PaymentImageUrl,
              uIdUser: AppCubit.get(context).userModel.uId!,
              nameUser: AppCubit.get(context).userModel.name!,
              uIdCourse: uIdCourse,
            );
          }
          if (state is AppCubitBookCourseSuccessState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(child: Text('لقد تم تسجيل طلبك بنجاح')),
                    content: customBottom(
                      width: 50,
                      height: 50,
                      color: HexColor('#050640'),
                      onPressed: () {
                        AppCubit.get(context).myBookCoursesModel.clear();
                        AppCubit.get(context).getMyBookCourseData();
                        navigatorAndFinish(context, AljosurLayout());
                      },
                      widget: const Text('تم',style: TextStyle(
                        color: Colors.white
                      ),),
                      borderColor: HexColor('#050640'),
                    ),
                  );
                });
          }
        },
        builder: (context, state) {
          var paymentImage = AppCubit.get(context).paymentImage;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'تأكيد الإشتراك',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: HexColor('#050640'),
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.grey),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.all(20.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.orange[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.crisis_alert_outlined),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            'يرجى رفع صورة اشعار الدفع وانتظار تأكيد الطلب'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 105.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100.0,
                            backgroundImage: paymentImage == null
                                ? const NetworkImage(
                                    'https://thumbs.dreamstime.com/b/bill-icon-simple-vector-illustration-black-white-dollar-sign-background-122371158.jpg',
                                  )
                                : FileImage(paymentImage) as ImageProvider,
                          ),
                        ),
                        IconButton(
                          color: Colors.orange,
                          onPressed: () {
                            AppCubit.get(context).getPaymentImage();
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
                  const SizedBox(
                    height: 50.0,
                  ),
                 state is AppCubitBookCourseLoadingState?
                   const CircularProgressIndicator(
                   )
                   : customBottom(
                    width: double.infinity,
                    height: 50.0,
                    color: HexColor('#050640'),
                    onPressed: () {
                      // if(paymentImage==null)
                      // {
                      //   showToast('الرجاء ادخال اشعار الدفع');
                      // }
                      // else {
                       if(paymentImage==null){

                         AppCubit.get(context).bookCourse(
                           nameCourse: nameCourse,
                           imageCourse:imageCourse ,
                           image: AppCubit.get(context).PaymentImageUrl,
                           uIdUser: AppCubit.get(context).userModel.uId!,
                           nameUser: AppCubit.get(context).userModel.name!,
                           uIdCourse: uIdCourse,
                         );
                       } else {
                              AppCubit.get(context).uploadPaymentImage();
                            }
                            // }
                    },
                    widget: const Text(
                      'تأكيد الطلب',
                      style: TextStyle(color: Colors.white),
                    ),
                    borderColor: HexColor('#050640'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
