
import 'package:chatapp/pages/application/index.dart';
import 'package:chatapp/pages/contact/index.dart';
import 'package:chatapp/pages/message/chat/index.dart';
import 'package:chatapp/pages/message/photo_view/index.dart';
import 'package:chatapp/pages/profile/index.dart';
import 'package:chatapp/pages/sign_in/index.dart';
import 'package:chatapp/pages/welcome/index.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/common/middlewares/middlewares.dart';

import 'package:get/get.dart';

import 'routes.dart';


class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),

    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        // RouteAuthMiddleware(priority: 1),
      ],
    ),

    // 最新路由
    // 首页
    GetPage(name: AppRoutes.Contact,
        page: () => ContactPage(),
        binding: ContactBinding()),
    GetPage(
        name: AppRoutes.Chat,
        page: () => ChatPage(),
        binding: ChatBinding()),

    //消息
    /*
    GetPage(name: AppRoutes.Message, page: () => MessagePage(), binding: MessageBinding()),
    //我的*/
    GetPage(name: AppRoutes.Me,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    //聊天详情
    GetPage(name: AppRoutes.Photoimgview,
        page: () => PhotoImgViewPage(),
        binding: PhotoImgViewBinding()),
  ];






}
