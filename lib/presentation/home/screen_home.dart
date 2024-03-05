
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management_app/constants/constants.dart';
import 'package:provider_student_management_app/controller/provider.dart';
import 'package:provider_student_management_app/models/student_model.dart';
import 'package:provider_student_management_app/presentation/all_students/screen_all_students.dart';
import 'package:provider_student_management_app/presentation/home/widgets/text_formfild.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
    ScreenHome({super.key});

 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final namecontroller=TextEditingController();
  final departmentcontroller=TextEditingController(); 
  final phNocontroller=TextEditingController();
  final rollNocontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
     
        return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(10, 62, 60, 55),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenAllStudents()),
                );
              },
              icon: const Icon(Icons.list),
            ),
          ],
          centerTitle: true,
          title: const Text('Add Student'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10), 
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  kHeight30,
                  Consumer<StudetsDetailProvider>(
                    builder: (context, provider, child) {
                      return GestureDetector(
                      onTap: () {
                        provider.selectImageFromGallery();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.6),
                        radius: 60,
                        backgroundImage: provider.imageFile.path.isNotEmpty?
                        FileImage(provider.imageFile):
                        null,
                        child: provider.imageFile.path.isEmpty
                          ? const Center(
                            child:  Icon(
                                Icons.add_a_photo, 
                              ),
                          )
                          : null,
                      ),
                    );
                    },
                     
                  ),
                  kHeight40,
                  BuildTextformFild(
                    controller: namecontroller, 
                    hintText: 'Name',
               
                  ),
                  kHeight20,
                  BuildTextformFild(
                    keyboardType: TextInputType.number,
                    controller:rollNocontroller ,
                    hintText: 'Roll No',
                
                  ),
                  kHeight20, 
                  BuildTextformFild(
                    controller: departmentcontroller,
                    hintText: 'Department',
                  
                  ),
                  kHeight20,
                  BuildTextformFild(
                    keyboardType: TextInputType.number,
                    controller: phNocontroller,
                    hintText: 'Ph No',
                   
                  ),
                  kHeight40,
                  SizedBox(
                    width: 150,
                    child: ElevatedButton( 
                      onPressed: ()async { 
                       if(_formKey.currentState!.validate()&& Provider.of<StudetsDetailProvider>(context, listen: false)
                                .imageFile
                                .path
                                .isNotEmpty){
                          StudetsDetailProvider().addStudent(
                           StudentModel(
                            image: Provider.of<StudetsDetailProvider>(context,listen: false).imageFile.path, 
                            department: departmentcontroller.text, name: namecontroller.text, phNo: phNocontroller.text, rollNo: rollNocontroller.text),
                          context, namecontroller, departmentcontroller, phNocontroller, rollNocontroller,
                          ); 
                          Provider.of<StudetsDetailProvider>(context,listen: false).clearImage();
                       }
                       
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.6),  
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      

  }

 
}




