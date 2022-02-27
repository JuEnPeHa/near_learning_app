import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 20,
        ),
        userTile(),
        divider(),
        colorTiles(),
        divider(),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: circularIndicator(MediaQuery.of(context).size.height / 2, 10, context)),
        divider(),
        bwTiles(),
      ],
    );
  }
}

Widget userTile() {
  return ListTile(
    leading: CircleAvatar(
      radius: 50,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.face_outlined,
        size: 50,
      ),
    ),
    title: Text(
      "\$\{user.FirstName\} + \$\{user.LastName\}",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget divider() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Divider(
      thickness: 2,
    ),
  );
}

Widget colorTiles() {
  return Column(
    children: [
      colorTile(
          Icons.person_outline_outlined, Colors.green, "Datos Personales"),
      colorTile(
          Icons.settings_outlined, Colors.red, "Ajustes de la Aplicación"),
      //colorTile(Icons.person_outline_outlined, yellowNEAR, "Datos Personales"),
      //colorTile(Icons.person_outline_outlined, orangeNEAR, "Datos Personales"),
    ],
  );
}

Widget bwTiles() {
  Color color = Colors.black;
  return Column(
    children: [
      colorTile(Icons.info_outline, color, "Preguntas Frecuentes",
          blackAndWhite: true),
      colorTile(Icons.auto_fix_normal, color, "Conocer Más",
          blackAndWhite: true),
      //colorTile(Icons.info_outline, color, "Preguntas Frecuentes",
      //    blackAndWhite: true),
    ],
  );
}

Widget colorTile(IconData icon, Color color, String text,
    {bool blackAndWhite = false}) {
  return ListTile(
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

Widget circularIndicator(double radius, double width, BuildContext context) {
  return Column(
    children: [
      const SizedBox(
        height: 8.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircularPercentIndicator(
          radius: radius / 4,
          lineWidth: width,
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
      const SizedBox(
        height: 8.0,
      ),
    ],
  );
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
