import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/model/book_course_model.dart';
import 'package:aljosur_center/modules/my_account/my_account_screen.dart';
import 'package:aljosur_center/shared/admin_cubit/cubit.dart';
import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ReviewPayment extends StatelessWidget {
  final BookCourseModel model;
  final String idBook;

  const ReviewPayment({Key? key, required this.model, required this.idBook})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'تأكيد الطلب',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
               model.image.toString()!=null? Image(
                  image: NetworkImage(model.image.toString()),
                  width: double.infinity,
                ):Icon(
                 Icons.image_not_supported_outlined
               ),
                SizedBox(
                  height: 10.0,
                ),
                customBottom(
                  width: 150.0,
                  height: 50.0,
                  color: Colors.white,
                  onPressed: () {
                    AdminCubit.get(context).getUserData(model.uIdUser.toString(), context);
                  },
                  widget: Text('عرض الملف الشخصي'),
                  borderColor: HexColor('#050640'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton(
                          heroTag: 'btn1',
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            AdminCubit.get(context).updateBookingSuccessReview(
                              uIdUser: model.uIdUser.toString(),
                              uIdCourse: model.uIdCourse.toString(),
                              state: '1',
                              nameUser: model.nameUser.toString(),
                              nameCourse: model.nameCourse.toString(),
                              image: model.image.toString(),
                              imageCourse: model.imageCourse.toString(),
                              uIdBook:idBook,
                              context: context,
                            );
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('تأكيد')
                      ],
                    ),
                    Column(
                      children: [
                        FloatingActionButton(
                          heroTag: 'btn2',
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            AdminCubit.get(context).deleteBookingSuccessReview(
                              uIdBook:idBook,
                              context: context,
                            );
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('إلغاء'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
