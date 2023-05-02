import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants.dart';

final Uri _url = Uri.parse('https://muvp.mans.edu.eg/');

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('About Us'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.go("/startpage")),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                // image: DecorationImage(
                //   image: AssetImage('assets/images/muvp_logo.png'),
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Mansoura University Vertebrate Paleontology (MUVP)',
                style: TextStyle(
                  color: kTextColor,
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'MUVP is a research group that studies the paleobiology and evolution of vertebrates. Our team of researchers includes scientists from various disciplines, including paleontology, anatomy, and genetics. We conduct fieldwork in various locations around the world, including Egypt, Morocco, and the United States.',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            // Center(
            //   child: ElevatedButton(
            //     child: Text('Visit our website'),
            //     onPressed: _launchURL,
            //   ),
            // ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // static void _launchURL() async {
  //   if (await launchUrl(_url)) {
  //     await launchUrl(_url);
  //   } else {
  //     throw 'Could not launch $_url';
  //   }
  // }
}
