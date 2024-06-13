import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSecurityScreen extends StatelessWidget {
  const ProfileSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Безопасность'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildReminder(),
              _buildFaceID(),
              _buildBiometryID(),
              _buildGoogleAuthentication(),
              const SizedBox(height: 16),
              _buildChangePIN(),
              const SizedBox(height: 16),
              _buildChangePassword(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminder() {
    return Row(
      children: [
        const Text("Напоминать мне"),
        Expanded(child: Container()),
        Switch(value: true, onChanged: (value) {})
      ],
    );
  }

  Widget _buildFaceID() {
    return Row(
      children: [
        const Text("Face ID"),
        Expanded(child: Container()),
        Switch(value: false, onChanged: (value) {})
      ],
    );
  }

  Widget _buildBiometryID() {
    return Row(
      children: [
        const Text("Биометрия ID"),
        Expanded(child: Container()),
        Switch(value: true, onChanged: (value) {})
      ],
    );
  }

  Widget _buildGoogleAuthentication() {
    return Row(
      children: [
        const Text("Google Аутентификация"),
        Expanded(child: Container()),
        SvgPicture.asset(
          'assets/icons/arrow_right_icon.svg',
          width: 16,
          height: 16,
        )
      ],
    );
  }

  Widget _buildChangePIN() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF0ebe7e)),
        ),
        child: const Text(
          "Изменить PIN",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildChangePassword() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF0ebe7e)),
        ),
        child: const Text(
          "Изменить пароль",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
