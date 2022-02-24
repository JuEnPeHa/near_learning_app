import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode(); //email
  final FocusNode passwordFocusNode = FocusNode(); //password
  final FocusNode submitFocusNode = FocusNode(); //confirm password

  Map<String, String> formData = {
    'email': '',
    'password': '',
  };
  String _password = "";
  bool _passwordValid = false;
  bool _obscureText = true;

  void _checkPassword(String value) {
    _password = value.trim();
    if (_password.length < 6) {
      setState(() {
        _passwordValid = false;
      });
    } else {
      setState(() {
        _passwordValid = true;
      });
    }
  }

  void _submitForm() {
    final isOk = _formLoginKey.currentState?.validate();
    print(isOk);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
            key: _formLoginKey,
            child: Column(
              children: [
                SizedBox(height: 32),
                CustomInputField(
                  isPassword: false,
                  labelText: 'Correo',
                  hintText: 'Correo del usuario',
                  keyboardType: TextInputType.emailAddress,
                  formProperty: 'email',
                  focusNode: emailFocusNode,
                  nextFocusNode: passwordFocusNode,
                  formValues: formData,
                  validator: (text) {
                    if (text != null) {
                      if (!text.contains('@') && !text.contains('.')) {
                        return 'El correo no es valido';
                      }
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  isPassword: true,
                  formProperty: 'password',
                  formValues: formData,
                  obscureText: _obscureText,
                  labelText: 'Contraseña',
                  hintText: 'Contraseña del usuario',
                  focusNode: passwordFocusNode,
                  nextFocusNode: submitFocusNode,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: _obscureText
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open)),
                  validator: (text) {
                    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                      //para que se ejecute despues de que se haya renderizado el widget
                      _checkPassword(text!);
                    });
                    if (text != null) {
                      if (text.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: !_passwordValid
                      ? null
                      : () {
                          _submitForm();
                          print(formData);
                        },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(child: Text('Guardar'))),
                ),
              ],
            )),
      ),
    );
  }
}
