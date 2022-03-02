import 'package:flutter/material.dart';
import 'package:near_learning_app/models/models.dart';
import 'package:near_learning_app/providers/navigation_provider.dart';
import 'package:near_learning_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var safeArea = EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    final NavigationProvider provider =
        Provider.of<NavigationProvider>(context);
    final bool isCollapsed = provider.isCollapsed;
    final padding = EdgeInsets.symmetric(vertical: 20);
    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.3 : null,
      child: Drawer(
        backgroundColor: Color(0xFF98B4AA),
        elevation: 100,
        child: Column(
          children: [
            Container(
                padding: padding.add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: BuildHeader(isCollapsed: isCollapsed)),
            const SizedBox(height: 20),
            BuildList(
                items: itemsFirst, isCollapsed: isCollapsed, padding: padding),
            const SizedBox(height: 20),
            Divider(
              color: Colors.white70,
            ),
            const SizedBox(height: 20),
            BuildList(
                items: itemsSecond, isCollapsed: isCollapsed, padding: padding),
            Spacer(),
            BuildCollapseIcon(buildContext: context, isCollapsed: isCollapsed),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BuildList extends StatelessWidget {
  final bool isCollapsed;
  final List<DrawerItem> items;
  final EdgeInsets padding;
  const BuildList(
      {Key? key,
      required this.isCollapsed,
      required this.items,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      Navigator.of(context).pop();
    }

    return ListView.separated(
      padding: isCollapsed ? EdgeInsets.zero : padding,
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = items[index];
        return BuildMenuItem(
          isCollapsed: isCollapsed,
          text: item.title,
          icon: item.icon,
          onTap: () {
            _launchURL(item.url);
          },
        );
      },
    );
  }
}

class BuildMenuItem extends StatelessWidget {
  final bool isCollapsed;
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  const BuildMenuItem(
      {Key? key,
      required this.isCollapsed,
      required this.text,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    final leading = Icon(icon, color: color);
    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onTap,
            )
          : ListTile(
              leading: leading,
              title: Text(text, style: TextStyle(color: color)),
              onTap: onTap,
            ),
    );
  }
}

class BuildCollapseIcon extends StatelessWidget {
  final bool isCollapsed;
  final BuildContext buildContext;
  BuildCollapseIcon(
      {Key? key, required this.buildContext, required this.isCollapsed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final Alignment alignment =
        isCollapsed ? Alignment.center : Alignment.centerRight;
    final EdgeInsets margin = EdgeInsets.only(right: isCollapsed ? 0 : 20);
    final double width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);
            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }
}

class BuildHeader extends StatelessWidget {
  final bool isCollapsed;

  BuildHeader({required this.isCollapsed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCollapsed
        ? FlutterLogo(
            size: 48,
          )
        : Row(
            children: [
              const SizedBox(width: 24),
              FlutterLogo(
                size: 48,
              ),
              const SizedBox(width: 24),
              Text(
                "Flutter",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          );
  }
}
