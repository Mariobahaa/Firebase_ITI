import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebaseiti/handlers/StorageHandler.dart';

enum ImgBlocEventType { uploadImage }

class ImgBlocEvent {
  ImgBlocEventType type;
  File uploadedImage;
  String id;
  ImgBlocEvent({this.type, this.uploadedImage, this.id});
}

class ImgBlocState {
  String imgurl;
  ImgBlocState({this.imgurl});
}

class ImgBloc extends Bloc<ImgBlocEvent, ImgBlocState> {
  ImgBloc() : super(ImgBlocState(imgurl: ""));
  @override
  Stream<ImgBlocState> mapEventToState(ImgBlocEvent event) async* {
    if (event.type == ImgBlocEventType.uploadImage) {
      String downloadUrl =
          await StorageHandler().uploadFile(event.uploadedImage, event.id);
      yield ImgBlocState(imgurl: downloadUrl);
    }
  }
}
