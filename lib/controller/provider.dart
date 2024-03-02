import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_student_management_app/constants/constants.dart';
import 'package:provider_student_management_app/models/student_model.dart';
import 'package:provider_student_management_app/presentation/all_students/screen_all_students.dart';
const String studentCollectionRef="studentCollection";
class StudetsDetailProvider extends ChangeNotifier {

   
 
  late File _imageFile=File('');
  String? _searchTxt;


  final ImagePicker _imagePicker=ImagePicker();
  File get imageFile=>_imageFile;
 
 
   void setImageFile(File file) {
    _imageFile = file;
    notifyListeners();
  }

  Future<void> selectImageFromGallery()async{
    final pickedFile=await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      _imageFile=File(pickedFile.path);
      notifyListeners();
    }
  }


    void clearImage() {
    _imageFile = File('');
    notifyListeners();
    }


///////////////CRUD//////////////////////////



 final fireStore=FirebaseFirestore.instance;  
  late final CollectionReference studentRef;
  
  
  StudetsDetailProvider(){
    studentRef=fireStore.collection(studentCollectionRef).withConverter<StudentModel>(
      fromFirestore:(snapshot, _) =>StudentModel.fromJson(snapshot.data()!) ,
       toFirestore: (value, options) =>value.toJson() );
  }
   
////////////


    Stream<QuerySnapshot>getAllStudents(){
      return studentRef.snapshots();
    }



//////////////



    void addStudent(
    StudentModel data,
    BuildContext context,
    TextEditingController namecontroller,
    TextEditingController departmentcontroller,
    TextEditingController phNocontroller,
    TextEditingController rollNocontroller
    )async{
      
      studentRef.add(data);
      notifyListeners();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenAllStudents(),));
      kClearAllFields(namecontroller, departmentcontroller, phNocontroller, rollNocontroller);
      kSnackBar(context,'Data Added Succesfully');
    }


/////////////

void updateStudent(
  String id,
  StudentModel student,
  BuildContext context,

  ){
    
    studentRef.doc(id).update(student.toJson());
    notifyListeners();
      kSnackBar(context, 'Edited Sucessfully');
      Navigator.pop(context);

}

/////////////

deleteStudent(
  String id,
){
  studentRef.doc(id).delete();
  notifyListeners();

}

///////////

 Stream<QuerySnapshot> searchStudents(String searchTerm) {
    return studentRef.where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThan: searchTerm+ 'z')
        .snapshots();
  }
 String? get searchTxt => _searchTxt;

  void setSearchTxt(String? value) {
    _searchTxt = value;
    notifyListeners();
  }


}