import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/modules/control_panel/add_course_screen.dart';
import 'package:aljosur_center/modules/control_panel/check_user_booking_screen.dart';
import 'package:aljosur_center/shared/admin_cubit/cubit.dart';
import 'package:aljosur_center/shared/admin_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ControlPanelScreen extends StatelessWidget {
  const ControlPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AdminCubit,AdminStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              shadowColor: HexColor('#F15A22'),
              centerTitle: true,
              title: const Text(
                'لوحة التحكم',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  customBottom(
                    width:double.infinity,
                    height: 50.0,
                    color: HexColor('#050640'),
                    onPressed: () {
                      PushToNextScreen(context, AddCourseScreen());
                    },
                    widget: Text(
                      'إضافة دورة جديدة',
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    borderColor: HexColor('#050640'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  customBottom(
                    width:double.infinity,
                    height: 50.0,
                    color: HexColor('#050640'),
                    onPressed: () {
                      PushToNextScreen(context, CheckUserBookingScreen());
                    },
                    widget: Text(
                      'مراجعة طلبات التسجيل',
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    borderColor: HexColor('#050640'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                ],
              ),
            ),
          );
        },
        listener: (context, state) {

        },
      ),
    );
  }
}
