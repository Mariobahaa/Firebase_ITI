import 'dart:io';

import 'package:firebaseiti/screens/Img/ImgBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Img extends StatefulWidget {
  @override
  _ImgState createState() => _ImgState();
}

class _ImgState extends State<Img> {
  ImgBloc imgBloc = ImgBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            _getUserImage(),
            SizedBox(
              height: 20.0,
            ),
            _getPickerButton(),
          ],
        ),
      ),
    );
  }

  Widget _getUserImage() {
    return BlocBuilder(
        bloc: imgBloc,
        builder: (context, state) {
          if (state != "" && state != null) {
            return Image.network(state.imgurl);
          } else
            return Center(
              child: Container(
                child: Text("Please upload your Picture"),
              ),
            );
        });
  }

  Widget _getPickerButton() {
    return Center(
      child: Container(
        child: ElevatedButton(
          child: Text("Upload"),
          onPressed: () {
            setState(() {
              getImg();
            });
          },
        ),
      ),
    );
  }

  Future getImg() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 200.0,
      maxHeight: 200.0,
    );
    print("After pick file $pickedFile");
    setState(() {
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        imgBloc.add(ImgBlocEvent(
          uploadedImage: image,
          id: '1',
          type: ImgBlocEventType.uploadImage,
        ));
      } else {
        print('No image selected.');
      }
    });
  }
}
