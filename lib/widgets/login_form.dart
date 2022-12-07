import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  double numberFromWidth(
      double width, double lowerScreen, double higherScreen) {
    if (width <= 400) {
      return lowerScreen;
    } else {
      return higherScreen;
    }
  }

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    submitFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: numberFromWidth(size.width, 16, 32)),
      child: Form(
        key: _formLoginKey,
        child: Column(
          children: [
            SizedBox(height: numberFromWidth(size.width, 16, 32)),
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
                  icon:
                      _obscureText ? Icon(Icons.lock) : Icon(Icons.lock_open)),
              validator: (text) {
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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
                  : () async {
                      FocusScope.of(context).unfocus();
                      bool isOk = _formLoginKey.currentState!.validate();
                      String? email =
                          formData['email']?.replaceAll(" ", "").toLowerCase();
                      if (isOk != null && isOk) {
                        //_formRegisterKey.currentState.save();
                        await authenticationNotifier.login(
                            context: context,
                            email: email ?? "",
                            password: formData['password'] ?? "");
                        //* imprimir valores del formulario
                        print(formData.toString() + email!);
                      } else {}
                      print(formData);
                    },
              child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Guardar'))),
            ),
            CupertinoButton(
              child: Text("¿Olvidaste tu contraseña?"),
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text("¿Olvidaste tu contraseña?"),
                        content: Column(
                          children: [
                            Text("Por favor ingresa tu correo"),
                            Material(
                              elevation: 2,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white.withOpacity(0.8),
                              shadowColor: Colors.black.withOpacity(0.2),
                              child: TextField(
                                decoration: const InputDecoration(
                                    labelText: "Correo",
                                    hintText: "Correo del usuario",
                                    prefixIcon: Icon(Icons.email)),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  formData['email'] = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text("Enviar"),
                            onPressed: () {
                              print(formData['email']);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            // CupertinoButton(
            //     child: Text("Botón solo para desarrollo"),
            //     onPressed: () {
            //       Navigator.of(context).pushReplacementNamed('home');
            //     }),
            // SizedBox(
            //   height: numberFromWidth(size.width, 16, 32),
            // ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('register');
              },
              child: Text("¿No tienes cuenta? Registrate"),
            ),
          ],
        ),
      ),
    );
  }
}
