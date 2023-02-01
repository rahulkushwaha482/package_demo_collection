import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon(
      {Key? key,
      required this.iconPath,
      required this.linkPath,
      required this.width,
      required this.height})
      : super(key: key);
  final String iconPath;
  final String linkPath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){_launchUrl();},
      child: SizedBox(
        height: height,
        width: width,

        child: Image.asset(iconPath),
      ),
    );
  }

  Future<void> _launchUrl() async {

    final Uri url = Uri.parse(linkPath);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
