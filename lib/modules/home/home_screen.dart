import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/model/add_course_model.dart';
import 'package:aljosur_center/modules/details_course/detail_cours_screen.dart';
import 'package:aljosur_center/shared/cubit_app/cubit.dart';
import 'package:aljosur_center/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
        return  Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),itemBuilder: (context, index) {
              return buildCourses(AppCubit.get(context).coursesModel[index],context,AppCubit.get(context).idCoursesModel[index]);
            }, separatorBuilder: (context, index) {
              return const SizedBox(
                height: 20.0,
              );
            }, itemCount:AppCubit.get(context).coursesModel.length),
          ),
        );
      },
      listener: (context, state) {

      },
    );
  }
}
Widget buildCourses(AddCourseModel model,context,id){
  return   InkWell(
    child: Container(
      width: double.infinity,
      height: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: NetworkImage(
              model.image!,
            ),
            fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 200.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.all(10.0),
              decoration: BoxDecoration(
                borderRadius:const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: Colors.black.withOpacity(0.7),
              ),
              width: double.infinity,
              child: Text(
                model.nameCourse!,
                style:const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
    onTap: (){

      PushToNextScreen(context,DetailCourseScreen(model: model,id: id));

      print(id);
    },
  );

}