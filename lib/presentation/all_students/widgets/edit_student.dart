


import 'dart:io'; 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../controller/provider.dart';
import '../../../models/student_model.dart';
import '../../home/widgets/text_formfild.dart';

// ignore: must_be_immutable
class EditStudentWidget extends StatelessWidget {
   EditStudentWidget({super.key,
    required this.data,
    required this.id
  });
   final StudentModel data;
   final String id;
  final StudetsDetailProvider _services=StudetsDetailProvider();




  @override 
  Widget build(BuildContext context) {
       final namecontroller=TextEditingController(text:data.name );
       final departmentcontroller=TextEditingController(text:data.department );
       final phNocontroller=TextEditingController(text:data.phNo );
       final rollNocontroller=TextEditingController(text:data.rollNo );
       Provider.of<StudetsDetailProvider>(context,listen: false).setImageFile(File(data.image));


    return Padding(padding:const EdgeInsets.only(top: 100  ,bottom: 50  ),
      child: SingleChildScrollView(
        child: AlertDialog(
            title:  const Text('Edit'),
            content: Column(
              children: [ 
                   Consumer<StudetsDetailProvider>(
                    builder: (context, provider, child) {
                  return GestureDetector(
                    onTap: () {
                      provider.selectImageFromGallery();
                    },
                    child: CircleAvatar(
                       backgroundColor: Colors.black.withOpacity(0.6),
                      radius: 50,  
                      backgroundImage: provider.imageFile.path.isNotEmpty
                          ? FileImage(File(provider.imageFile.path))
                          : null,
                      child: provider.imageFile.path.isEmpty
                          ? const Icon(
                              Icons.add_a_photo, 
                              
                            )
                          : null,
                    ),
                  );
                  }
                  ),
                   
                   kHeight20,
                BuildTextformFild(hintText: 'name',controller: namecontroller), 
                kHeight20,
               BuildTextformFild(hintText: 'Department',controller: departmentcontroller,), 
                kHeight20,
               BuildTextformFild(hintText: 'RollNo',controller: rollNocontroller,keyboardType: TextInputType.number),  
                kHeight20,
               BuildTextformFild(hintText: 'PhNo',controller: phNocontroller,keyboardType: TextInputType.number,), 
                kHeight20,
              ],
            ),
          
           actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const Text('Cancel',
            style: TextStyle(color: Colors.white),)),
          
            TextButton(onPressed: (){
               StudentModel student=data.copyWith(
                 image: Provider.of<StudetsDetailProvider>(context,listen: false).imageFile.path,
                department: departmentcontroller.text,
                name: namecontroller.text,
                phNo: phNocontroller.text,
                rollNo: rollNocontroller.text
               );
        
                 _services.updateStudent(id, student,context); 
                
                 Provider.of<StudetsDetailProvider>(context,listen: false).clearImage();
                                 
            }, 
             child:const Text('Edit',style: TextStyle(color: Colors.white))),
           ],
        ),
      ),
    );
  }
}

