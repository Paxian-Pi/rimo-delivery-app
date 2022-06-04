import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rimo_tech/google_map.dart';
import 'package:rimo_tech/loading_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_model.dart';
import 'constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late SharedPreferences _pref;

  final formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      Constants.hideOrShowPassword = !Constants.hideOrShowPassword;
    });
  }

  bool _validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  final _dio = Dio();

  Future _login(LoginRequestModel loginRequest) async {
    String loginUrl = 'https://handova.ddns.net/api/login';

    try {
      final response = await _dio.post(loginUrl, data: loginRequest);
      if (kDebugMode) print(response.data);

      final data = response.data;

      _pref = await SharedPreferences.getInstance();

      return response.data;
    }
    on DioError catch (e) {
      return e.response!.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.png"),
            fit: BoxFit.cover,
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     // Colors.purple,
          //     Constant.mainColor,
          //     Constant.accent,
          //   ],
          // ),
        ),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(margin: const EdgeInsets.only(top: 75), child: Image.asset('assets/logo.png')),
            //     Column(
            //       children: [
            //         _welcomeText(),
            //         _subWelcomeText(),
            //       ],
            //     )
            //   ],
            // ),
            Expanded(
              child: Container(
                width: double.infinity,
                // decoration: const BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(30),
                //     topRight: Radius.circular(30),
                //   ),
                // ),
                margin: const EdgeInsets.only(top: 20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 200),
                        _welcomeText(),
                        _subWelcomeText(),
                        const SizedBox(height: 20),
                        _phoneNumber(),
                        _passwordField(),
                        const SizedBox(height: 20),
                        _loginButton(),
                        _forgotPassword(),
                        const SizedBox(height: 40),
                        Container(
                          alignment: Alignment.center,
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue.shade200, Colors.blue.shade200], // Set gradient colors here
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Icon(Icons.fingerprint, size: 40, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _welcomeText() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: const Text(
        'Enter Phone Number',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }
  Widget _subWelcomeText() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 25.0),
      child: const Text(
        'Login with your\nregistered phone number',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _phoneNumber() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.call),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              // child: TextFormField(
              //   keyboardType: TextInputType.phone,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //     label: Text(phoneNumber),
              //     border: InputBorder.none,
              //   ),
              // ),
              child: IntlPhoneField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  // prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.phone,
                initialCountryCode: 'NG',
                onChanged: (phone) {
                  if (kDebugMode) {
                    print(phone.completeNumber);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 15
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: Constants.hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      Constants.hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Colors.grey,
                    ),
                  ),
                  label: const Text('Password'),
                  // border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      margin: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: ElevatedButton(
        onPressed: () async {

          _pref = await SharedPreferences.getInstance();

          print(_phoneNumberController.text);
          
          _login(LoginRequestModel(
              username: '0' + _phoneNumberController.text,
              password: _passwordController.text,
              device_identification: '1234',
              firebase_messaging_token: '1706')
          ).then((value) {
            print(value);

              Navigator.of(context).pushReplacement(
                PageTransition(
                  child: const LoadingDashboard(),
                  type: PageTransitionType.fade,
                ),
              );
            }
          );


        },
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.blue.shade200,
          shadowColor: Colors.grey,
          elevation: 3,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade200],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
