


class StudentModel{

    String image;
    String name;
    String department;
    String rollNo;
    String phNo;


    StudentModel({
      required this.department,
      required this.image,
      required this.name,
      required this.phNo,
      required this.rollNo
    });

   
    StudentModel.fromJson(Map<String,Object?>json)
    :this (
      department: json['department']as String,
       image: json['image']as String,
       name: json['name']as String,
       phNo: json['phno']as String,
       rollNo: json['roll_no']as String); 
   
   

   StudentModel copyWith({
    String? image, 
    String? name,
    String? department,
    String? rollNo,
    String? phNo
   }){
    return StudentModel(
      department: department?? this.department,
       image: image?? this.image, 
       name: name ?? this.image,
       phNo: phNo ?? this.phNo,
       rollNo: rollNo?? this.phNo);
   }

   Map<String,Object>toJson(){
      
      return {
        'department':department,
        'name':name,
          'image':image ,
        'phno':phNo,
        'roll_no':rollNo,
      };
   }
    
}