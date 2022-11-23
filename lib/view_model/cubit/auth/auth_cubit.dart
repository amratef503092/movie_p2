import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../model/cinema_owner_model/cinema_owner_model.dart';
import '../../../model/user.dart';
import '../../database/local/cache_helper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>
{
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  UserModel? userModel;
  final ImagePicker _picker = ImagePicker();

  // login function start
  Future<void> getUserData() async {

    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.get(key: 'id'))
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data()!);

      emit(GetUserDataSuccessfulState('data come true'));
    }).catchError((onError) {
      print(onError.toString());
      emit(GetUserDataErrorState('some Thing Error'));
    });
  }

  Future<void> update({
    required String email,
    required String phone,
    required String age,
    required String name,

    // required String role,
  }) async {
    emit(UpdateDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.get(key: 'id'))
        .update({
      'name': name,
      'phone': phone,
      'age': age,
      'email': email,
    }).then((value) {
      emit(UpdateDataSuccessfulState('done'));
    }).catchError((onError) {
      emit(UpdateDataErrorState('some thing Error'));
    });
  }

  List<CinemaOwnerModel> cinemaOwnerModel = [];

  Future<void> getAllCinemaOwner() async {
    emit(GetAllCinemaOwnerLoadingState());
    cinemaOwnerModel = [];
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: '2')
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(element.data());
        cinemaOwnerModel.add(CinemaOwnerModel.fromMap(element.data()));
      }

      emit(GetAllCustomerScreenSuccessful());

    }).catchError((error){

      emit(GetAllCinemaOwnerErrorState('some thing Error'));
    });
  }
  List<UserModel> userModelList = [];
  Future<void> getCustomerUSer() async {
    emit(GetAllCinemaOwnerLoadingState());
    userModelList = [];
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: '3')
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(element.data().toString()+ "iiodaosidiojasdjio");
        userModelList.add(UserModel.fromMap(element.data()));
      }

      emit(GetAllCustomerScreenSuccessful());

    }).catchError((error){

      emit(GetAllCinemaOwnerErrorState('some thing Error'));
    });
  }

  Future<void> uploadFile(XFile? file, BuildContext context) async {
    emit(UploadImageStateLoading('loading'));
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref().child('/${file.name}');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      print('Amr2');
      ref.putFile(io.File(file.path), metadata).then((p0) => {
            ref.getDownloadURL().then((value) {
              // here modify the profile pic
              userModel!.photo = value;
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(CacheHelper.get(key: 'id'))
                  .update({'photo': value}).then((value) {
                emit(UploadImageStateSuccessful('upload done'));
              }).catchError((onError) {
                emit(UploadImageStateError('Error'));
              });
            })
          });
    }
  }

  Future<void> pickImageGallary(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      print(image.path);
      await uploadFile(image, context).then((value) {});
    }
  }

  Future<void> pickImageCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
    } else {
      print(image.path);
      await uploadFile(image, context).then((value) {});
    }
  }

  List<UserModel> adminData = [];

  Future<void> getAdmin() async {
    emit(GetAdminsStateLoading('loading'));
    adminData = [];
    FirebaseFirestore.instance
        .collection('users')
        .where(
          'role',
          isEqualTo: '1',
        )
        .get()
        .then((value) {
      print(value.docs.length);
      value.docChanges.forEach((element) {
        if (element.doc.data()!['id'] == CacheHelper.get(key: 'id')) {
          print('same');
        } else {
          adminData.add(UserModel.fromMap(element.doc.data()!));
        }
      });
      emit(GetAdminsStateSuccessful('loading'));
    }).catchError((onError) {
      print(onError.toString());
      print('Amr');
      emit(GetAdminsStateError('loading'));
    });
  }

  String? docOne;
  String? docTwo;

  // send message firebase
  Future<void> sendMessage(
      {required String message,
      required String pharmacyID,
      required String customerName,
      required String customerId,
      required String pharmacyName,
      required String senderID,
      required String type,
      String? baseName}) async {
    emit(SendMessageStateLoading('loading'));
    print(baseName);
    FirebaseFirestore.instance
        .collection('users')
        .doc(customerId)
        .collection('messages')
        .add({
      'message': message,
      'senderID': senderID,
      'customerName': customerName,
      'pharmacyID': pharmacyID,
      'pharmacyName': pharmacyName,
      'customerId': customerId,
      'type': type,
      'time': DateTime.now().toString(),
      'baseName': baseName
    }).then((value) {
      docOne = value.id;
      FirebaseFirestore.instance
          .collection('users')
          .doc(customerId)
          .collection('messages')
          .doc(value.id)
          .update({
        'id': value.id,
      });
    }).catchError((onError) {
      emit(SendMessageStateError('onError'));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(pharmacyID)
        .collection('messages')
        .add({
      'message': message,
      'customerName': customerName,
      'senderID': senderID,
      'baseName': baseName,
      'pharmacyID': pharmacyID,
      'pharmacyName': pharmacyName,
      'customerId': customerId,
      'type': type,
      'time': DateTime.now().toString(),
    }).then((value) {
      docTwo = value.id;
      FirebaseFirestore.instance
          .collection('users')
          .doc(pharmacyID)
          .collection('messages')
          .doc(value.id)
          .update({
        'id': value.id,
        'docOne': docOne,
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(customerId)
            .collection('messages')
            .doc(docOne)
            .update({
          'docOne': docTwo,
        });
      });
      print(value);
      emit(SendMessageStateSuccessful('Successful'));
    }).catchError((onError) {
      emit(SendMessageStateError('onError'));
    });
  }

  FilePickerResult? result;

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      io.File file = io.File(result!.files.single.path.toString());
      FirebaseStorage.instance.ref().child('files').putFile(file).then((p0) {
        p0.ref.getDownloadURL().then((value) {
          print(value);
        });
      });
    }
  }

  String? baseName;

  Future<void> pickFileMessage(
      {required String customerId,
      required String pharmacyID,
      required String pharmacyName,
      required String customerName,
      required String type}) async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      io.File file = io.File(result!.files.single.path.toString());
      baseName = basename(file.path);

      FirebaseStorage.instance
          .ref()
          .child(result!.files.single.path.toString())
          .putFile(file)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          sendMessage(
              senderID: CacheHelper.get(key: 'id').toString(),
              pharmacyName: pharmacyName,
              customerId: customerId,
              customerName: customerName,
              message: value,
              pharmacyID: pharmacyID,
              type: type,
              baseName: baseName);
        });
      });
    }
  }
}
