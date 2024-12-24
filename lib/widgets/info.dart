import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Infopage extends StatelessWidget {
  const Infopage({super.key});

  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    print('URL: $url');
    final canLaunchResult = await canLaunchUrl(url);
    print('Can launch: $canLaunchResult');
    if (canLaunchResult) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unable to call $phoneNumber")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white,),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 220,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 70,
              width: 70,
              child: Image.asset("images/Cubosquare-logo.png"),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Cubosquare is here to help you build your app or website. Let’s bring your ideas to life!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () async {
                    final url = 'https://www.cubosquare.com/';

                    _openUrl(url);
                  },
                  child: Image.asset(
                    "images/world-wide-web.png",
                    height: 40,
                  )),
              GestureDetector(
                  onTap: () async {
                    final url = 'https://x.com/cubosquare';

                    _openUrl(url);
                  },
                  child: Image.asset(
                    "images/twitter.png",
                    height: 40,
                  )),
              GestureDetector(
                  onTap: () async {
                    final url = 'https://www.facebook.com/CUBOSQUARE/';

                    _openUrl(url);
                  },
                  child: Image.asset(
                    "images/facebook.png",
                    height: 40,
                  )),
              GestureDetector(
                  onTap: () async {
                    final url = 'https://www.instagram.com/cubosquare/';

                    _openUrl(url);
                  },
                  child: Image.asset(
                    "images/instagram.png",
                    height: 40,
                  )),
              GestureDetector(
                  onTap: () {
                    dialNumber(phoneNumber: '+918652083868', context: context);
                  },
                  child: Image.asset(
                    "images/phone-call.png",
                    height: 40,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Future _openUrl(url) async {
    if (!await launchUrl(Uri.parse("$url"),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Page Not Found');
    }
  }
}
