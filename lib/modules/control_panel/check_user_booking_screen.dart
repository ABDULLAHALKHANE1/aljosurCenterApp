import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/model/book_course_model.dart';
import 'package:aljosur_center/modules/control_panel/review_paymemt_and_approve_screen.dart';
import 'package:aljosur_center/shared/admin_cubit/cubit.dart';
import 'package:aljosur_center/shared/admin_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckUserBookingScreen extends StatelessWidget {
  const CheckUserBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'مراجعة الإشتراكات',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: state is AdminCubitGetAllBookCourseLoadingState
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(itemBuilder: (context, index) {
                      return buildReviewBook(AdminCubit.get(context).allBookCoursesModel[index], context,AdminCubit.get(context).idAllBookCoursesModel[index]);
                    }, separatorBuilder: (context, index) {
                      return
                      const SizedBox(height: 10.0,);
                    }, itemCount: AdminCubit.get(context).allBookCoursesModel.length)
                  ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
Widget buildReviewBook( BookCourseModel model,context,idBook)
{
  return InkWell(
    onTap: (){
      PushToNextScreen(context, ReviewPayment(model: model,idBook:idBook));
    },
    child: Card(
        color: Colors.blueGrey,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children:  [
                Flexible(
                  child: Text(
                    'اسم الطالب: ${model.nameUser.toString()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    'اسم الكورس: ${model.nameCourse}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )),
  );
}