import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:aljosur_center/shared/cubit_app/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCourseDetailsScreen extends StatelessWidget {
  const MyCourseDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var model = AppCubit.get(context).myCourseDetailsModel;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'معلومات الدورة',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: HexColor('#050640'),
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.grey),
            ),
            body: state is AppCubitGetMyCourseDetailsLoadingState
                ? const Center(child: const CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Image(
                            fit: BoxFit.fill,
                            height: 300.0,
                            width: double.infinity,
                            image: NetworkImage(
                              '${model.image}',
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            '${model.nameCourse}',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'عن الدورة',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              child: Text(
                                '${model.description}',
                              ),
                            ),
                          ),
                          Text(
                            'رابط الدورة على زوم',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[200],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child:  Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5),
                                child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "اضغط للحصول على الرابط",
                                              recognizer: TapGestureRecognizer()..onTap =  () async{
                                                var url = "https://zoom.us/j/95086940698?pwd=K0Q2MXdhRHF4YTFOVU1STnlMVHhlQT09";
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }
                                          ),
                                        ]
                                    ))
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'عدد الجلسات',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              child: Text(
                                '${model.countSession}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'عدد الساعات',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              child: Text(
                                '${model.countHours}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'تاريخ البدء',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              child: Text(
                                '${model.dateCourse}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'سعر الدورة',
                            style: TextStyle(
                                color: HexColor('#F15A22'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              child: Text(
                                '${model.priceCourse} ل.س',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
