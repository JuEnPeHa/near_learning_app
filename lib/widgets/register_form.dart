import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'widgets.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  final FocusNode nameFocusNode = FocusNode(); //nombre
  final FocusNode emailFocusNode = FocusNode(); //email
  final FocusNode passwordFocusNode = FocusNode(); //password

  final FocusNode passwordConfirmFocusNode = FocusNode(); //pin
  final FocusNode submitFocusNode = FocusNode(); //confirm password

  Map<String, String> formValues = {
    'first_name': '',
    'email': '',
    'password': '',
    'repeat_password': '',
    //'role': ''
  };

  _submit() {
    final isOk = _formRegisterKey.currentState?.validate();
    print(isOk);
  }

  String _password = "";
  double _strength = 0;
  String _displayText = 'Please enter a password';
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  void _checkPassword(String value) {
    _password = value.trim();

    // if (_password.isEmpty) {
    //   setState(() {
    //     _strength = 0;
    //     _displayText = 'Please enter your password';
    //   });
    // } else
    if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Your password is too short';
      });
    } else if ((_password.length <= 8 &&
            _password.length >= 6 &&
            (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password))) ||
        (_password.length >= 6 &&
            !numReg.hasMatch(_password) &&
            !letterReg.hasMatch(_password))) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Your password is acceptable but not strong';
      });
    } else if ((_password.length > 8 && !letterReg.hasMatch(_password)) ||
        (_password.length > 8 && numReg.hasMatch(_password))) {
      setState(() {
        // Password length >= 8
        // But doesn't contain both letter and digit characters
        _strength = 3 / 4;
        _displayText = 'Your password is strong';
      });
    } else {
      // Password length >= 8
      // Password contains both letter and digit characters
      setState(() {
        _strength = 1;
        _displayText = 'Your password is great';
      });
    }
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: _formRegisterKey,
          child: Column(
            children: [
              CustomInputField(
                isPassword: false,
                labelText: 'Nombre',
                hintText: 'Nombre del usuario',
                formProperty: 'first_name',
                focusNode: nameFocusNode,
                nextFocusNode: emailFocusNode,
                formValues: formValues,
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CustomInputField(
                isPassword: false,
                labelText: 'Correo',
                hintText: 'Correo del usuario',
                keyboardType: TextInputType.emailAddress,
                formProperty: 'email',
                focusNode: emailFocusNode,
                nextFocusNode: passwordFocusNode,
                formValues: formValues,
                validator: (text) {
                  if (text != null) {
                    if (!text.contains('@') && !text.contains('.')) {
                      return 'El correo no es valido';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CustomInputField(
                isPassword: true,
                labelText: 'Contraseña',
                hintText: 'Contraseña del usuario',
                obscureText: _obscureText,
                formProperty: 'password',
                focusNode: passwordFocusNode,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? Icon(Icons.lock)
                        : Icon(Icons.lock_open)),
                nextFocusNode: passwordConfirmFocusNode,
                formValues: formValues,
                validator: (text) {
                  SchedulerBinding.instance!.addPostFrameCallback((duration) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 15,
                  child: LinearProgressIndicator(
                    value: _strength,
                    backgroundColor: Colors.grey[300],
                    color: _strength <= 1 / 4
                        ? Colors.red
                        : _strength == 2 / 4
                            ? Colors.yellow
                            : _strength == 3 / 4
                                ? Colors.blue
                                : Colors.green,
                    minHeight: 15,
                  ),
                ),
              ),
              Text(
                _displayText,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomInputField(
                  isPassword: true,
                  labelText: 'Password',
                  hintText: 'Repeat Password',
                  formProperty: 'repeat_password',
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: _obscureText
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open)),
                  focusNode: passwordConfirmFocusNode,
                  nextFocusNode: submitFocusNode,
                  formValues: formValues),
              formValues['repeat_password'] == ''
                  ? const SizedBox()
                  : (formValues['password'] != formValues['repeat_password'])
                      ? const Text(
                          'Las contraseñas no coinciden',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
              ElevatedButton(
                focusNode: submitFocusNode,
                child: const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Guardar'))),
                onPressed: _strength < 1 / 2
                    ? null
                    : () {
                        _submit();
                        //* imprimir valores del formulario
                        print(formValues);
                      },
              )
            ],
          ),
        ),
      ),
    );
  }
}
