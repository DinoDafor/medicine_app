import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/bloc/profile_edit_bloc.dart';

import '../utils/user.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    if (User.firstName.isNotEmpty) {
      _firstNameController.text = User.firstName;
    }
    if (User.lastName.isNotEmpty) {
      _lastNameController.text = User.lastName;
    }
    if (User.birthDate.isNotEmpty) {
      _birthDateController.text = User.birthDate;
    }
    if (User.email.isNotEmpty) {
      _emailController.text = User.email;
    }
    if (User.phoneNumber.isNotEmpty) {
      _phoneController.text = User.phoneNumber;
    }
    _genderController.text = User.sex.sex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildFirstNameField(),
                const SizedBox(height: 16.0),
                _buildLastNameField(),
                const SizedBox(height: 16.0),
                _buildBirthDateField(),
                const SizedBox(height: 16.0),
                _buildEmailField(),
                const SizedBox(height: 16.0),
                _buildCountryField(),
                const SizedBox(height: 16.0),
                _buildPhoneField(),
                const SizedBox(height: 16.0),
                _buildGenderField(),
                const SizedBox(height: 16.0),
                _buildUpdateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      controller: _firstNameController,
      validator: _validateFirstName,
      decoration: InputDecoration(
        hintText: "Введите Ваше имя...",
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _lastNameController,
      validator: _validateLastName,
      decoration: InputDecoration(
        hintText: "Введите Вашу фамилию...",
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBirthDateField() {
    return TextFormField(
      validator: _validateBirthDate,
      onTap: () => _selectDate(context),
      controller: _birthDateController,
      decoration: InputDecoration(
        hintText: "Введите Ваш День Рождения...",
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: SvgPicture.asset(
          'assets/icons/birthdate_icon.svg',
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        int year = picked.year;
        String month =
            picked.month > 9 ? "${picked.month}" : "0${picked.month}";
        String day = picked.day > 9 ? "${picked.day}" : "0${picked.day}";
        _birthDateController.text = "$year-$month-$day";
      });
    }
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      validator: _validateEmail,
      decoration: InputDecoration(
        hintText: "Введите Вашу почту...",
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: SvgPicture.asset(
          'assets/icons/email_icon.svg',
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  Widget _buildCountryField() {
    return DropdownButton<String>(
      icon: SvgPicture.asset(
        'assets/icons/dropdown_icon.svg',
        width: 16,
        height: 16,
      ),
      value: "США",
      // value: _countryController.text,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          _countryController.text = newValue!;
        });
      },
      items: <String>['США', 'Россия', 'Беларусь']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      validator: _validatePhone,
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: "Введите Ваш номер телефона...",
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGenderField() {
    return DropdownButton<String>(
      icon: SvgPicture.asset(
        'assets/icons/dropdown_icon.svg',
        width: 16,
        height: 16,
      ),
      value: "Мужчина",
      // value: _genderController.text,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          _genderController.text = newValue!;
        });
      },
      items: <String>['Мужчина', 'Женщина', 'Другое']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String fistName = _firstNameController.text.trim();
            String lastName = _lastNameController.text.trim();
            String email = _emailController.text.trim();
            String phoneNumber = _phoneController.text.trim();
            String birthDate = _birthDateController.text.trim();
            Sex sex = _genderController.text.toLowerCase() == 'мужчина'
                ? Sex.MALE
                : Sex.FEMALE;

            Map<String, dynamic> updatedData = {};

            updatedData['firstName'] = fistName;

            updatedData['lastName'] = lastName;

            updatedData['birthDate'] = birthDate;

            updatedData['email'] = email;

            updatedData['phoneNumber'] = phoneNumber;

            updatedData['gender'] = sex.name;

            if (updatedData.isNotEmpty) {
              BlocProvider.of<ProfileEditBloc>(context).add(
                ProfileEditChangeUserDataEvent(updatedFields: updatedData),
              );
            }
          }
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF0ebe7e)),
        ),
        child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
            builder: (context, state) {
          if (state is ProfileEditUpdatedLoadingState && state.isLoading) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          } else {
            return const Text(
              "Обновить",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          }
        }),
      ),
    );
  }

  String? _validateFirstName(String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "First name cannot be empty";
    }
    return null;
  }

  String? _validateLastName(String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "Last name cannot be empty";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "Email cannot be empty";
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return "Invalid email format";
    }
    return null;
  }

  String? _validatePhone(String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "Phone number cannot be empty";
    } else if (!RegExp(r'^\+\d{1,15}$').hasMatch(value)) {
      return "Invalid phone number format";
    }
    return null;
  }

  String? _validateBirthDate(String? value) {
    value = value?.trim();
    if (value!.isEmpty) {
      return "Birthday cannot be empty";
    } else {
      // DateTime selectedDate = DateTime.parse(value);
      // DateTime maxDate = DateTime.now().subtract(Duration(days: 18 * 365));
      // if (selectedDate.isAfter(maxDate)) {
      //   return "Birthday must be at least 18 years old";
      // }
    }
    return null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
