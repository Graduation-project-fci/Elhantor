import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/services/Authenticate/authenticate.dart';
import 'package:new_project/services/Storage/storage.dart';
import 'dart:async';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Auth _auth = Auth();

  bool isObsecurepassword = true;
  XFile? img1;
  String? img = 'https://pixlr.com/images/index/remove-bg.webp';
  final ImagePicker picker = ImagePicker();
  ImageStorage storage = ImageStorage();
  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      img1 = img;
    });
  }

  @override
  void initState() {
    // TODO: implement initState


  }
  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog( // <-- SEE HERE

            title: const Text('Choose a Picture'),
            children: <Widget>[
              SimpleDialogOption(
                
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:  TextButton.icon(style: IconButton.styleFrom(
                  alignment: Alignment.topLeft
                ),onPressed: ()=> getImage(ImageSource.camera), icon: Icon(Icons.camera_alt_outlined), label: Text('Use Camera',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: TextButton.icon(style: IconButton.styleFrom(
                    alignment: Alignment.topLeft
                ),onPressed: () => {getImage(ImageSource.gallery), }, icon: Icon(Icons.browse_gallery_rounded), label: Text('Browse Gallery',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
              ),

            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp( theme: ThemeData.dark(),debugShowCheckedModeBanner: false,
        home: Scaffold(
  appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,
    
    title:  Text('Driver profile'),
    leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: () {  },
  ),

    ),
    body:Container(
      padding: const EdgeInsets.only(left:15,top:20,right: 15),
      child: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus( );},
        child: ListView(children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4,color: Colors.white),
                    boxShadow:[BoxShadow(spreadRadius: 2,blurRadius: 10,color: Colors.black.withOpacity(0.1))],
                    shape: BoxShape.circle,
                    image:  const DecorationImage(
                      image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/elhantor-3f993.appspot.com/o/personal_images%2Fimage_picker993351879.png?alt=media&token=b386a2da-dd41-4109-b7de-e327caeba5d9') ,
                      fit:BoxFit.cover

                    )
                  ),

                ),
                Positioned(bottom:0,right:0,child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    border: Border.all(width:4,color: Colors.white),
                    color: Colors.deepOrangeAccent
                  ),
                  child: IconButton(onPressed: ()async{
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if(image!=null){
                      final path=image.path;
                      final name=image.name;


                      await storage.uploadImage(name, path);
                      String? link=await storage.getdownloadurl(name);

                      setState(() async{
                        if(link!=null){
                          print(link);

                        }

                      });

                    }


                    },icon:Icon(Icons.photo_camera,color: Colors.white,),)
                  //const Icon(Icons.edit,color: Colors.white,),
                  
                ))
              ],
            ),
          ),
          const SizedBox(height:30),
          buildTextField("Full Name", "Enter Full Name ...", false),
          buildTextField("Email address", "person@mail.com", false),
          buildTextField("Location", "Cairo", false),
          buildTextField('Password', '.12.', true),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(onPressed: (){}, child:Text('CANCEL',style: TextStyle(
                fontSize: 15,letterSpacing: 2,
                color: Colors.white
              ),),style:
                OutlinedButton.styleFrom(
                  padding:const EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ,backgroundColor: Colors.grey[800]
                ),),
        OutlinedButton(onPressed: (){}, child:Text('UPDATE',style: TextStyle(
            fontSize: 15,letterSpacing: 2,
            color: Colors.white
        ),),style:
        OutlinedButton.styleFrom(
            padding:const EdgeInsets.symmetric(horizontal: 30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
            ,backgroundColor: Colors.deepOrange
        ),)

         ] )

        ],),
      ),
    ),
    ));
  }
  Widget buildTextField(String labelText,String placeholder,bool isPassword){
    return Padding(padding:const EdgeInsets.only(bottom: 30),
      child: TextField(obscureText: isPassword?isObsecurepassword:false,decoration:
        InputDecoration(
          suffixIcon: isPassword? IconButton(onPressed: (){
            setState(() {
              isObsecurepassword=!isObsecurepassword;

            });
          }, icon:  Icon(isObsecurepassword?(Icons.visibility_off):(Icons.visibility),color: Colors.grey,))
          :null,
            contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(

            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          )

        ),),
    );
  }
}