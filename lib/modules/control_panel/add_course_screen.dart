import 'package:aljosur_center/constance/component.dart';
import 'package:aljosur_center/shared/add_course_cubit/cubit.dart';
import 'package:aljosur_center/shared/add_course_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;

class AddCourseScreen extends StatelessWidget {
  var countSessionController = TextEditingController();
  var priceCourseController = TextEditingController();
  var nameController = TextEditingController();
  var linkCourseController = TextEditingController();
  var countHoursController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime? courseMonthDisplay = DateTime.now();
  String? courseMonth;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCoursesCubit, AddCoursesStates>(

      listener: (BuildContext context, state) {

        if (state is AddCourseUploadImageSuccessState) {
          AddCoursesCubit.get(context).AddCourseCreate(
            linkCourseZoom: linkCourseController.text,
            dateCourse: courseMonth!,
            countSession: countSessionController.text,
            countHours: countHoursController.text,
            description: descriptionController.text,
            image: AddCoursesCubit.get(context).CourseImageUrl,
            nameCourse: nameController.text,
              priceCourse:priceCourseController.text,
          );

        }
        if(state is AddCourseSuccessState){
          showToastSuccess('تم اضافة الدورة بنجاح');
          Navigator.pop(context);

        }
      },
      builder: (BuildContext context, Object? state) {
        var courseImage = AddCoursesCubit.get(context).CourseImage;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
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
                            child: Text(
                              'إضافة دورة',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30.0,
                                color: HexColor('#050640'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
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
                                    backgroundImage: courseImage == null
                                        ? const NetworkImage(
                                            'https://static.vecteezy.com/system/resources/previews/002/219/582/original/illustration-of-book-icon-free-vector.jpg',
                                          )
                                        : FileImage(courseImage)
                                            as ImageProvider,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.orange,
                                  onPressed: () {
                                    AddCoursesCubit.get(context)
                                        .getCourseImage();
                                  },
                                  icon: const CircleAvatar(
                                    child:  Icon(
                                      Icons.camera_alt_outlined,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          defulteditTextx(
                            prefix: Icons.drive_file_rename_outline,
                            Controlar: nameController,
                            keyboardType: TextInputType.text,
                            Lable: 'الاسم',
                            // prefix: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال اسم  الدورة';
                              }
                              return null;
                            },
                            hint: 'ادخل اسم الدورة',
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defulteditTextx(
                            prefix: Icons.link,
                            Controlar: linkCourseController,
                            keyboardType: TextInputType.text,
                            Lable: 'رابط الدورة على زوم',
                            //prefix: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال الرابط';
                              }
                              return null;
                            },
                            hint: 'ادخل رابط الدورة',
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defulteditTextx(
                            prefix: Icons.format_list_numbered_rtl,
                            Controlar: countSessionController,
                            keyboardType: TextInputType.text,
                            Lable: 'عدد الجلسات',
                            //prefix: Icons.lock,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال عدد الجلسات';
                              }
                              return null;
                            },
                            onfiled: (value) {
                              print(value);
                            },
                            hint: 'ادخل عدد الجلسات',
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defulteditTextx(
                            prefix: Icons.format_list_numbered_rtl,
                            Controlar: priceCourseController,
                            keyboardType: TextInputType.text,
                            Lable: 'سعر الدورة',
                            //prefix: Icons.lock,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال سعر الدورة';
                              }
                              return null;
                            },
                            onfiled: (value) {
                              print(value);
                            },
                            hint: 'ادخل سعر الدورة',
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defulteditTextx(
                            prefix: Icons.timelapse,
                            Controlar: countHoursController,
                            keyboardType: TextInputType.phone,
                            Lable: 'عدد الساعات',
                            //prefix: Icons.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال عدد الساعات';
                              }
                              return null;
                            },
                            hint: 'ادخل عدد الساعات',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.description_outlined,
                                color: HexColor('#050640'),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'الوصف',
                              hintText: 'ادخل الوصف لهذه الدورة',
                              hintStyle: const TextStyle(fontSize: 11.5),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: HexColor('#F15A22'),
                              ),
                            ),
                            controller: descriptionController,
                            minLines: 4,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: Row(
                              children: [
                                const Icon(Icons.date_range_outlined),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'تاريخ الدورة',
                                      style: TextStyle(
                                          color: HexColor('#F15A22'),
                                          fontSize: 18.0),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    customBottom(
                                      borderColor: Colors.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 50,
                                      color: Colors.white,
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2050-12-31'),
                                        ).then((value) {
                                          courseMonth = intl.DateFormat.yMMMd()
                                              .format(value!);
                                          courseMonthDisplay = value;
                                          AddCoursesCubit.get(context)
                                              .changDateCourseState();
                                          print(courseMonth);
                                        });
                                      },
                                      widget: Column(
                                        children: [
                                          Text(
                                            courseMonthDisplay!.month
                                                .toString(),
                                            style: TextStyle(
                                              color: HexColor('#F15A22'),
                                            ),
                                          ),
                                          const Divider(
                                            height: 1,
                                          ),
                                          Text(
                                            courseMonthDisplay!.day.toString(),
                                            style: TextStyle(
                                              color: HexColor('#F15A22'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Center(
                            child: bottom(
                              borderColor: HexColor('#050640'),
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              color: HexColor('#050640'),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (courseImage != null) {
                                    AddCoursesCubit.get(context)
                                        .uploadCourseImage();
                                  } else {
                                    showToast('الرجاء التحقق من الصورة ');
                                  }
                                }
                              },
                              text: 'إضافة الدورة',
                              Colortext: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
