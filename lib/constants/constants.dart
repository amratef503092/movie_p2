import 'package:flutter/material.dart';
import 'package:movie_flutterr/model/user.dart';

import '../view_model/database/local/cache_helper.dart';

const Color BACKGROUND_COLOR = Color(0xff121212);
const Color RED_COLOR = Color(0xffD22424);

const TEXT_FIELD_BACKGROUND_COLOR = Color(0xff1C1C1C);
const DARK_TEXT_COLOR = Color(0xFF707070);


const String LOGIN_CHECK_KEY = "isLogedIn";
const String USER_NAME_KEY = "username";
const String EMAIL_KEY = "email";
const String PASSWORD_KEY = "password";

String TOKEN = "";

var userID = CacheHelper.get(key: 'id');
var role = CacheHelper.get(key: 'role');

const Color buttonColor =  RED_COLOR;
UserModel? user;
