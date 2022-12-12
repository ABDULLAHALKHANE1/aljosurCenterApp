import 'package:aljosur_center/shared/admin_cubit/cubit.dart';
import 'package:aljosur_center/shared/admin_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewProfilePersonly extends StatelessWidget {
  const ViewProfilePersonly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      builder: (context, state) {
        var model=AdminCubit.get(context).userModel;
        return Scaffold(
            appBar: AppBar(),
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: model.uId==null? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 90.0,
                      backgroundImage: NetworkImage('${model.image}',),
                    ):CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 90.0,
                      child: Icon(Icons.person_outline,size: 40,),
                    ),
                  ),
                  const   SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      model.name.toString(),
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('البريد الإلكتروني'),
                      SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsetsDirectional.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),

                            border: Border.all(color: Colors.orange)
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            model.email.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const  SizedBox(
                    height: 10.0,
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('رقم الهاتف'),
                      SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsetsDirectional.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.orange)
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            model.phone.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        );
      },
      listener: (context, state) {

      },
    );
  }
}
