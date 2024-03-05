import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management_app/constants/constants.dart';
import 'package:provider_student_management_app/controller/provider.dart';
import 'package:provider_student_management_app/models/student_model.dart';
import 'package:provider_student_management_app/presentation/all_students/widgets/studet_detail.dart';



// ignore: must_be_immutable
class ScreenAllStudents extends StatelessWidget {
  const ScreenAllStudents({super.key});



  @override
  Widget build(BuildContext context) { 
       final StudetsDetailProvider dataBadeServices = Provider.of<StudetsDetailProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar( 
         backgroundColor:const Color.fromARGB(10, 62, 60, 55) ,
        elevation: 0,
        actions: [ 
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon:const Icon(Icons.add_chart))
        ],
        centerTitle: true,
        title:const Text('Student List'),
      ),  
      body: Column(
        children: [
          kHeight10,
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 6),
            child: CupertinoSearchTextField(  
              onChanged: (value) {
                dataBadeServices.setSearchTxt(value);
                  },
                  backgroundColor:  Colors.grey.withOpacity(0.1),
                  suffixIcon:const Icon(CupertinoIcons.xmark_circle_fill,color: Colors.grey,) ,
                  prefixIcon:const Icon(CupertinoIcons.search,color: Colors.grey,),
                  style:const TextStyle(color: Colors.white),
                ),
          ),
          Expanded( 
            child: StreamBuilder(
              
              stream:dataBadeServices.searchTxt==null? dataBadeServices.getAllStudents() 
              : dataBadeServices.searchStudents(dataBadeServices.searchTxt!.toLowerCase().trim()),
 
              builder: (context, snapshot) {
                List studet=snapshot.data?.docs??[];
                if(snapshot.connectionState==ConnectionState.waiting){
                  return  const Center(child: CircularProgressIndicator(),); 
                }
                  
                  if(studet.isEmpty){
                     return const Center(child: Text('List is Empty'),);
                  }else{
                  return GridView.count(
                  padding:const EdgeInsets.only(top: 10,left:4,right: 4),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:7/10, 
                  crossAxisCount: 2, 
                  children:List.generate(
                    studet.length,
                   (index) {
                    StudentModel data=studet[index].data();
                   String id=studet[index].id;
                    return StudetDetailsWidget(data: data,id: id,);
                   }  )
                  ); 
                  }
          
                
              }
            ),
          ),
        ],
      )
    );
  }
}

