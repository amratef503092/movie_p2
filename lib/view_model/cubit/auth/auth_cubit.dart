import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../model/cinema_owner_model/MiniShops_model.dart';
import '../../../model/cinema_owner_model/cinema_owner_model.dart';
import '../../../model/cinema_owner_model/halls_model.dart';
import '../../../model/cinema_owner_model/movie_model.dart';
import '../../../model/cinema_owner_model/snacks.dart';
import '../../../model/user.dart';
import '../../database/local/cache_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
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
    }).catchError((error) {
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
        print(element.data().toString() + "iiodaosidiojasdjio");
        userModelList.add(UserModel.fromMap(element.data()));
      }

      emit(GetAllCustomerScreenSuccessful());
    }).catchError((error) {
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
            ref.getDownloadURL().then((value) async{
              // here modify the profile pic
              userModel!.photo = value;
             await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'photo': value}).then((value) {
                emit(UploadImageStateSuccessful('upload done'));
              }).catchError((onError) {
                emit(UploadImageStateError('Error'));
              });
            })
          });
    }
  }

  String? imageUrl;

  Future<void> uploadImageMovie(XFile? file, BuildContext context) async {
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
              imageUrl = value;
              emit(UploadImageStateSuccessful('upload done'));
            })
          });
    }
  }

  XFile? image;

  Future<void> pickImageMovie(BuildContext context) async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      print(image!.path);
      await uploadImageMovie(image, context).then((value) {});
    }
  }
  Future<void> pickImageGallary(BuildContext context) async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      print(image!.path);
      await uploadFile(image, context).then((value) {});
    }
  }

  Future<void> pickImageCamera(BuildContext context) async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
    } else {
      print(image!.path);
      emit(PickImageSuccessful());
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

  List<HallsModel> halls = [];

  Future<void> getHalls({required String cinemaID}) async {
    halls = [];
    emit(GetHallsLoading());
    await FirebaseFirestore.instance
        .collection('Halls')
        .where('cinema_id', isEqualTo: cinemaID)
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(element.id);
        halls.add(HallsModel.fromMap(element.data()));
      }
      emit(GetHallsSuccessful());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetHallsError());
    });
  }

  Future<void> createHalls(
      {required String name,
      required String description,
      required int seat,
      required String cinemaID}) async {
    emit(CreateHallsLoading());
    FirebaseFirestore.instance.collection('Halls').get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data()['name'] == name) {
            emit(CreateHallsError('this name is already exist'));
          } else {
            await FirebaseFirestore.instance.collection('Halls').doc(name).set({
              'name': name,
              'seats': seat,
              'description': description,
              'cinema_id': cinemaID,
            }).then((value) {
              emit(CreateHallsSuccessful());
            }).catchError((error) {
              if (error.toString().contains('already exists')) {
                emit(CreateHallsError('this hall is already exists'));
              } else {
                emit(CreateHallsError(error.toString()));
              }
            });
          }
        }
      } else {
        await FirebaseFirestore.instance.collection('Halls').doc(name).set({
          'name': name,
          'seats': seat,
          'description': description,
          'cinema_id': cinemaID,
        }).then((value) {
          emit(CreateHallsSuccessful());
        }).catchError((error) {
          if (error.toString().contains('already exists')) {
            emit(CreateHallsError('this hall is already exists'));
          } else {
            emit(CreateHallsError(error.toString()));
          }
        });
      }
    });
  }

  Future<void> editHalls(
      {required String name,
      required String description,
      required int seat,
      required String cinemaID}) async {
    emit(EditHallsLoading());
    await FirebaseFirestore.instance.collection('Halls').doc(name).update({
      'name': name,
      'seats': seat,
      'description': description,
    }).then((value) {
      emit(EditHallsSuccessful());
    }).catchError((onError) {
      emit(EditHallsError());
    });
  }

  Future<void> deleteHalls({
    required String name,
  }) async {
    emit(EditHallsLoading());
    await FirebaseFirestore.instance
        .collection('Halls')
        .doc(name)
        .delete()
        .then((value) {
      emit(EditHallsSuccessful());
    }).catchError((onError) {
      emit(EditHallsError());
    });
  }

  Future<void> addNewMovie({
    required String nameMovie,
    required String description,
    required String hall,
    required String time,
    required String cinemaID,
    required BuildContext context,
    required int price,
  }) async {
    bool isExist = false;
    await FirebaseFirestore.instance
        .collection('Movie')
        .where('hall', isEqualTo: hall)
        .where('expire', isEqualTo: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(element.data()['time']);
        if (element.data()['time'] == time) {
          isExist = true;
          print("exist");
          print("hi");
          break;
        }
      }
    }).then((value) async {
      if (isExist) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('this time is Booked in this hall')));
      } else {
        await uploadImageMovie(image, context).then((value) {});
        emit(AddNewFilmLoading());

        await FirebaseFirestore.instance.collection('Movie').add({
          'nameMovie': nameMovie,
          'description': description,
          'hall': hall,
          'image': imageUrl,
          'time': time,
          'expire': false,
          'price' : price,
          'cinemaID': AuthCubit.get(context).userModel!.cinemaID,
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection('Movie')
              .doc(value.id)
              .update({
            'id': value.id,
          });
          emit(AddNewFilmSuccessful());
        }).catchError((onError) {
          emit(AddNewFilmError());
        });
      }
    });
  }

  List<MovieModel> movies = [];

  Future<void> getMovies({required String cinemaID}) async {
    emit(GetFilmsLoading());
    movies = [];
    await FirebaseFirestore.instance
        .collection('Movie')
        .where('cinemaID', isEqualTo: cinemaID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());

        movies.add(MovieModel.fromMap(element.data()));
      });
      emit(GetFilmsSuccessful());
    }).catchError((error) {
      emit(GetFilmsError());
    });
  }

  Future<void> deleteMovie({required String id}) async {
    emit(DeleteFilmLoading());
    await FirebaseFirestore.instance
        .collection('Movie')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteFilmSuccessful());
    }).catchError((error) {
      emit(DeleteFilmError());
    });
  }

  Future<void> editFilm({required MovieModel movieModel}) async {
    emit(EditFilmLoading());
    await FirebaseFirestore.instance
        .collection('Movie')
        .doc(movieModel.id)
        .update({
      'nameMovie': movieModel.nameMovie,
      'description': movieModel.description,
      'hall': movieModel.hall,
      'image': movieModel.image,
      'time': movieModel.time,
      'expire': movieModel.expire,
      'cinemaID': movieModel.cinemaID,
    }).then((value) {
      emit(EditFilmSuccessful());
    }).catchError((onError) {
      emit(EditFilmError());
    });
  }

  List<MovieModel> hallInfo = [];

  Future<void> getHallInfo(
      {required String hallName, required String cinemaID}) async {
    emit(GetHallInfoLoading());
    hallInfo = [];
    await FirebaseFirestore.instance
        .collection('Movie')
        .where('hall', isEqualTo: hallName)
        .where('cinemaID', isEqualTo: cinemaID)
        .get()
        .then((value) {
      print(value.docs.length);
      for (var element in value.docs) {
        hallInfo.add(MovieModel.fromMap(element.data()));
      }
      emit(GetHallInfoSuccessful());
    }).catchError((error) {
      emit(GetHallInfoError());
    });
  }

  String? snckImageUrl;

  Future<void> uploadMINIShops(XFile? file, BuildContext context) async {
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
              imageUrl = value;
              emit(UploadImageStateSuccessful('upload done'));
            })
          });
    }
  }

  Future<void> uploadSnackImage(XFile? file, BuildContext context) async {
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
              snckImageUrl = value;
              emit(UploadImageStateSuccessful('upload done'));
            })
          });
    }
  }

  XFile? image2;
  XFile? imageSnack;

  Future<void> pickImageGallaryMiniShops(BuildContext context) async {
    image2 = await _picker.pickImage(source: ImageSource.gallery);
    if (image2 == null) {
    } else {
      print(image2!.path);
      await uploadMINIShops(image2, context).then((value) {});
    }
  }

  Future<void> pickImageGallarySnack(BuildContext context) async {
    imageSnack = await _picker.pickImage(source: ImageSource.gallery);
    if (imageSnack == null) {
    } else {
      print(imageSnack!.path);
      await uploadSnackImage(imageSnack, context).then((value) {});
    }
  }

  Future<void> createMainShops(
      {required String? name, required BuildContext context}) async {
    emit(CreateMainShopesLaoding());
    await FirebaseFirestore.instance.collection('shops').add({
      'name': name,
      'photo': imageUrl,
      'cinemaId': AuthCubit.get(context).userModel!.cinemaID,
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(value.id)
          .update({
        'id': value.id,
      });
      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(AuthCubit.get(context).userModel!.cinemaID)
          .update({
        'number_of_mini_shops': FieldValue.increment(1),
      });
      emit(CreateMainShopesSuccessful());
    }).catchError(() {
      emit(CreateMainShopesLaoding());
    });
  }

  List<MiniShopsModel> miniShops = [];

  Future<void> getMiniShops({required String cinemaID}) async {
    emit(GetMiniShopesLoading());
    miniShops = [];
    await FirebaseFirestore.instance
        .collection('shops')
        .where('cinemaId', isEqualTo: cinemaID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());

        miniShops.add(MiniShopsModel.fromMap(element.data()));
      });
      emit(GetMiniShopesSuccessful());
    }).catchError((error) {
      emit(GetMiniShopesError());
    });
  }

  Future<void> addSnacks(
      {required String name,
      required int price,
      required String miniShopId ,

      }) async {
    emit(AddSnacksLoading());
    await FirebaseFirestore.instance.collection('Snacks').add({
      'name': name,
      'price': price,
      'photo': snckImageUrl,
      'miniShopId': miniShopId,
      'cinemaId': userModel!.cinemaID,
      'outOfStock': false,
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('Snacks')
          .doc(value.id)
          .update({
        'id': value.id,
      });
      emit(AddSnacksSuccessful());
    }).catchError((error) {
      emit(AddSnacksError());
    });
  }

  List<SnacksModel> snacks = [];

  Future<void> getSnacks({required String miniShopId}) async {
    emit(GetSnacksLoading());
    snacks = [];
    await FirebaseFirestore.instance
        .collection('Snacks')
        .where('miniShopId', isEqualTo: miniShopId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());

        snacks.add(SnacksModel.fromMap(element.data()));
      });
      emit(GetSnacksSuccessful());
    }).catchError((error) {
      print(error.toString());
      emit(GetSnacksError());
    });
  }

  Future<void> editSnacks(
      {required String name,
      required int price,
      required snackID,
        required String photo,
      required bool outOfStock}) async {
    emit(EditSnacksLoading());
    await FirebaseFirestore.instance
        .collection('Snacks')
        .doc(snackID)
        .update({
      'name': name,
      'price': price,
      'outOfStock': outOfStock,
      'photo': photo,
    }).then((value) {
      emit(EditSnacksSuccessful());
    }).catchError((error) {
      emit(EditSnacksError());
    });
  }
}
