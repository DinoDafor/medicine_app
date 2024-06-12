import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';

import '../utils/user.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Profile')),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildProfilePicture(),
                _buildNameText(),
                _buildPhoneText(),
                const Divider(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProfileEdit(context),
                      _buildNotifications(),
                      _buildSecurity(context),
                      _buildChooseLanguage(),
                      _buildDarkMode(),
                      _buildSupport(),
                      _buildConnectAccount(),
                      _buildLogOutProfile(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildProfilePicture() {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ))
      ],
    );
  }

  Widget _buildNameText() {
    return Text(
      User.firstName.isEmpty ? "Empty UserName" : User.firstName,
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget _buildPhoneText() {
    return Text(
      User.phoneNumber.isEmpty ? "Empty phoneNumber" : User.phoneNumber,
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildProfileEdit(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context)
            .add(NavigationToProfileEditScreenEvent(context: context));
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/profile_edit_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text(
            "Редактировать профиль",
            style: TextStyle(fontSize: 24),
          ),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildNotifications() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/notification_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text("Уведомления", style: TextStyle(fontSize: 24),),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurity(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context)
            .add(NavigationToProfileSecurityScreenEvent(context: context));
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/security_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text("Безопасность",style: TextStyle(fontSize: 24),),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildChooseLanguage() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/choose_language_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text("Выбрать язык", style: TextStyle(fontSize: 24),),
          const Spacer(),
          // todo: remove hardcore
          const Text("Русский", style: TextStyle(fontSize: 24),),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildDarkMode() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/dark_mode_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text("Темный режим",style: TextStyle(fontSize: 24),),
          Expanded(child: Container()),
          Switch(value: false, onChanged: (value) {})
        ],
      ),
    );
  }

  Widget _buildSupport() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/support_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text("Поддержка", style: TextStyle(fontSize: 24),),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectAccount() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/conncect_account.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text("Подключить аккаунт", style: TextStyle(fontSize: 24),),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildLogOutProfile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // openBottomSheet(context);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/log_out_icon.svg',
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16.0),
          const Text(
            "Выйти",
            style: TextStyle(
              color: Colors.red,
              fontSize: 32
            ),
          ),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/icons/arrow_right_icon.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }
// openBottomSheet(BuildContext context) {
// return  showBottomSheet(
//     context: context,
//     builder: (context) {
//       return const Row(children: [
//         Text("hello!"),
//       ]);
//     });
// }
}
