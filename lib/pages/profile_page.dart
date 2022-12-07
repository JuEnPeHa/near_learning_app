import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_learning_app/models/user_model.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  final AuthenticationNotifier authenticationNotifier;
  final UserApp user;

  ProfilePage({
    Key? key,
    required this.authenticationNotifier,
    required this.user,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImageProvider logoColumn =
      const AssetImage('assets/logos_app/complete_logo_column.png');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          userTile(widget.user.name),
          divider(),
          colorTiles(() {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                        "Por el momento puedes actualizar tus datos cerrando y volviendo a abrir sesión"),
                    content: Column(
                      children: [],
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text("Regresar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("Continuar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }, () {}),
          divider(),
          SizedBox(
              height: size.width / 2 + 20,
              width: size.width,
              child: CustomCircularIndicator(
                radius: size.width,
                lineWidth: 10,
              )),
          divider(),
          bwTiles(
              () => showAboutDialog(
                    context: context,
                    applicationVersion: "0.0.1",
                    applicationIcon: Image(
                      image: logoColumn,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    applicationName: "Near Learning App",
                    children: [
                      ClipRRect(
                        child: Container(
                          height: size.height * 0.075,
                          width: size.width * 0.075,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                "https://gateway.pinata.cloud/ipfs/QmQRbL5GuwuDAiza1S2riRgbSC7DxEFFduHbkCtDPRZrUN",
                                scale: 0.5),
                          )),
                        ),
                      ),
                      "Desarrollado por: JEPH.near junto con NEAR y NEAR Education"
                          .text
                          .bold
                          .make()
                          .box
                          .width(size.width * 0.45)
                          .height(size.height * 0.055)
                          .make(),
                      "Agradecimiento especial a Sherif por la oportunidad,"
                          .text
                          .bold
                          .make()
                          .box
                          .width(size.width * 0.45)
                          .height(size.height * 0.055)
                          .make(),
                      "a Aleida y a Nacho por sus contribuciones,"
                          .text
                          .bold
                          .make()
                          .box
                          .width(size.width * 0.45)
                          .height(size.height * 0.055)
                          .make(),
                      "a Alexis por su trabajo y esfuerzo,"
                          .text
                          .bold
                          .make()
                          .box
                          .width(size.width * 0.45)
                          .height(size.height * 0.055)
                          .make(),
                      "y a Aeryn por ser mi inspiración, aunque no lo sepa."
                          .text
                          .bold
                          .make()
                          .box
                          .width(size.width * 0.45)
                          .height(size.height * 0.055)
                          .make(),
                    ],
                  ),
              () => widget.authenticationNotifier.logout(context: context)),
        ],
      ),
    );
  }
}

Widget userTile(String name) {
  return ListTile(
    leading: const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.face_outlined,
        size: 50,
      ),
    ),
    title: Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Divider(
      thickness: 2,
    ),
  );
}

Widget colorTiles(void Function()? onTap1, onTap2) {
  return Column(
    children: [
      colorTile(Icons.person_outline_outlined, Colors.green, "Datos Personales",
          onTap: onTap1),
      colorTile(Icons.settings_outlined, Colors.red, "Ajustes de la Aplicación",
          onTap: onTap2),
      //colorTile(Icons.person_outline_outlined, yellowNEAR, "Datos Personales"),
      //colorTile(Icons.person_outline_outlined, orangeNEAR, "Datos Personales"),
    ],
  );
}

Widget bwTiles(void Function()? onTap1, onTap2) {
  Color color = Colors.black;
  return Column(
    children: [
      colorTile(Icons.info_outline, color, "Acerca de:",
          blackAndWhite: true, onTap: onTap1),
      colorTile(Icons.handshake, color, "Cerrar Sesión - Logout",
          blackAndWhite: true, onTap: onTap2),
      //colorTile(Icons.info_outline, color, "Preguntas Frecuentes",
      //    blackAndWhite: true),
    ],
  );
}

Widget colorTile(IconData icon, Color color, String text,
    {bool blackAndWhite = false, onTap = null}) {
  return ListTile(
    onTap: onTap,
    leading: Container(
      child: Icon(
        icon,
        color: color,
      ),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: blackAndWhite ? Color(0xfff3f4fe) : color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(15)),
    ),
    title: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
      size: 24,
    ),
  );
}

class CustomCircularIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  const CustomCircularIndicator(
      {Key? key, required this.radius, required this.lineWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Center(
                child: CircularPercentIndicator(
                  radius: radius / 4,
                  lineWidth: lineWidth,
                  percent: getChapterCompleted() / 100,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _percentText(context),
                      _subtitleText(context, "Capitulos Completados")
                    ],
                  ),
                  backgroundColor: Colors.grey[300]!,
                  progressColor: Theme.of(context).primaryColor.withBlue(100),
                ),
              ),
              Center(
                child: Text(
                  "soon",
                  style: TextStyle(
                      fontSize: radius / 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius / 2),
                  child: Container(
                    color: Colors.black87,
                    height: radius / 2,
                    width: radius / 1,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

double getChapterCompleted() {
  var completedChapters = 15;
  var restantChapters = 35;
  int _totalChapters = completedChapters + restantChapters;
  return (completedChapters / _totalChapters) * 100;
}

Widget _percentText(BuildContext context) {
  return Text(
    "${getChapterCompleted().toInt()}%",
    style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor),
  );
}

Widget _subtitleText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
  );
}
