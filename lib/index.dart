//import 'dart:io';
import 'login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher_string.dart';
//import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => IndexPageState();

  //return Scaffold(body: WebTabBar());
}

class IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
//--------------------------------- Appbar -------------------------------------
        appBar: AppBar(
          title: Wrap(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'lib/assets/images/Logo-top.png',
                      fit: BoxFit.contain,
                      height: 38,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'ABC Finance Company',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily:
                                'Arial', /* fontWeight: FontWeight.bold */
                          ),
                        ))
                  ],
                ),

//------------------------------ Actions Widget --------------------------------
                SizedBox(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyLoginPage(
                                    title: '',
                                  )));
                    },
                    icon: const Icon(Icons.person,
                        size: 22.0, color: Colors.white),
                    label: const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.underline,
                          fontFamily: 'Roboto_Light'),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
//----------------------------------- Body Part --------------------------------
        body: SingleChildScrollView(
          child: Container(
            //color: Colors.lightBlue[50],
            margin: const EdgeInsets.only(
              top: 50.0, /* left: 40.0,  right: 40.0 */
            ),
            /* decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ), */
            child: Column(
              children: [
                ImageSlideshow(
                  indicatorColor: Colors.blue,
                  autoPlayInterval: 5000,
                  isLoop: true,
                  onPageChanged: (value) {
                    debugPrint('Page changed: $value');
                  },
                  children: <Widget>[
                    Image.asset(
                      'lib/assets/images/Main_Sld.png',
                      fit: BoxFit.fitHeight,
                    ),
                    Image.asset(
                      'lib/assets/images/SA.png',
                      fit: BoxFit.fitHeight,
                    ),
                    Image.asset(
                      'lib/assets/images/SM.png',
                      fit: BoxFit.fitHeight,
                    ),
                    Image.asset(
                      'lib/assets/images/SE.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Container(
                  color: Colors.lightBlue[50],
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'What We Do',
                          /* style: TextStyle(
                            fontSize: 50,
                          ), */
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.transparent,
                              decorationColor: Colors.black54,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -7))
                              ],
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.5),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  //width: width * 1.0,
                  padding: const EdgeInsets.only(bottom: 120),
                  color: Colors.lightBlue[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        //color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'lib/assets/images/MF.png',
                                  height: 250.0,
                                  width: 430.0,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text('Mutual Funds',
                                /* style: TextStyle(
                                fontSize: 25,
                                //fontFamily: 'Roboto',
                              ), */
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Roboto',
                                    color: Colors.transparent,
                                    decorationColor: Colors.grey,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, -5))
                                    ],
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 0.5)),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 5.0,
                                  right: 15.0,
                                  bottom: 30.0),
                              child: const Text(
                                'Mutual funds let you pool your money with other \n'
                                'investors to mutually buy stocks, bonds & other\n'
                                'investments. They are run by professional money\n'
                                'managers who decide which securities to buy &\n'
                                'when to sell them.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto_Light',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        //color: Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'lib/assets/images/In.png',
                                  height: 250.0,
                                  width: 445.0,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text('Insurence',
                                /* style: TextStyle(
                                  fontSize: 25,
                                  //fontFamily: 'Roboto',
                                ), */
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Roboto',
                                    color: Colors.transparent,
                                    decorationColor: Colors.grey,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, -5))
                                    ],
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 0.5)),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 5.0,
                                  right: 15.0,
                                  bottom: 30.0),
                              child: const Text(
                                'Insurance is a legal agreement between two parties, \n'
                                'the insurer and the insured, also known as insurance \n'
                                'coverage or insurance policy. The insurer provides \n'
                                'financial coverage for the losses of the insured that\n'
                                's/he may bear under certain circumstances.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto_Light',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        //color: Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'lib/assets/images/Bnd.png',
                                  height: 250.0,
                                  width: 447.0,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text('Financial Bonds',
                                /* style: TextStyle(
                            fontSize: 25,
                            //fontFamily: 'Roboto',
                          ), */
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Roboto',
                                    color: Colors.transparent,
                                    decorationColor: Colors.grey,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, -5))
                                    ],
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 0.5)),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 5.0,
                                  right: 15.0,
                                  bottom: 30.0),
                              child: const Text(
                                'Bond is loan from an investor to a borrower such as\n'
                                'a company or government. The borrower uses the\n'
                                'money to fund its operations, and the investor\n'
                                'receives interest on the investment. The market value\n'
                                'of a bond can change over time.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto_Light',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /* const SizedBox(
                  height: 30.0,
                ), */
                Container(
                    /* padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), */
                    padding: const EdgeInsets.only(
                      top: 80.0,
                      bottom: 100.0,
                    ),
                    // color: Colors.lightBlue[50],
                    color: Colors.blueGrey[900],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
//---------------------- Adress Column ------------------------------
                        Wrap(
                          spacing: 200.0,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            Column(
                              //margin: const EdgeInsets.only(top: 10.0),
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: const [
                                        Center(
                                            child: Text('Address',
                                                /* style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ), */
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.transparent,
                                                    decorationColor:
                                                        Colors.grey,
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.white,
                                                          offset: Offset(0, -7))
                                                    ],
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationThickness: 1.0))),
                                        SizedBox(
                                          height: 20.0,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'lib/assets/images/Logo-btm.png',
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Link(
                                                  uri: Uri.parse(
                                                      'https://shorturl.at/jmBH4'),
                                                  target: LinkTarget.self,
                                                  builder:
                                                      (context, followLink) {
                                                    return RichText(
                                                      text: TextSpan(
                                                          text: 'Address : ',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            //fontWeight: FontWeight.bold,
                                                          ),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text:
                                                                  'Plot No. 153, Green Park Avenue,\n'
                                                                  'Medchal Road, Jeedimetla village,\n'
                                                                  'Secunderabad - 500055, Telangana, INDIA.',
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Roboto_Light'),
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        followLink,
                                                            )
                                                          ]),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          /* mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start, */
                                          children: [
                                            const Icon(Icons.phone,
                                                size: 27.0,
                                                color: Colors.white),
                                            TextButton(
                                              onPressed: _makingPhoneCall,
                                              style: ButtonStyle(
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                  const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              child: const Text(
                                                '040-40196324',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto_Light'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.mail,
                                                size: 27.0,
                                                color: Colors.white),
                                            const SizedBox(
                                              width: 7.0,
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  String email =
                                                      Uri.encodeComponent(
                                                          "admin@serveen.com");
                                                  String subject =
                                                      Uri.encodeComponent("");
                                                  String body =
                                                      Uri.encodeComponent(
                                                          "Hello! Sir/Madam,");
                                                  // print(subject);
                                                  debugPrint(subject);
                                                  Uri mail = Uri.parse(
                                                      "mailto:$email?subject=$subject&body=$body");
                                                  if (await launchUrl(mail)) {
                                                    //email app opened
                                                  } else {
                                                    throw 'Could not launch $mail'; //email app is not opened
                                                  }
                                                },
                                                child: const Text(
                                                  "admin@serveen.com",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'Roboto_Light'),
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.public,
                                                size: 27.0,
                                                color: Colors.white),
                                            const SizedBox(
                                              width: 7.0,
                                            ),
                                            InkWell(
                                              onTap: () => launchUrl(
                                                Uri.parse(
                                                    'https://www.serveen.com/nai/serveen/index.php'),
                                              ),
                                              child: const Text(
                                                'www.abcfinances.com',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontFamily: 'Roboto_Light'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
//-------------------------- Working Hours Column ------------------------------
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Working Hours',
                                    /* style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ), */
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.transparent,
                                        decorationColor: Colors.grey,
                                        shadows: [
                                          Shadow(
                                              color: Colors.white,
                                              offset: Offset(0, -7))
                                        ],
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.0)),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                            Icons
                                                .access_time_rounded, //location_on
                                            size: 27.0,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          'Monday  8:50 am-5:10 pm',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto_Light'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                            Icons
                                                .access_time_rounded, //location_on
                                            size: 27.0,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          'Tuesday  8:50 am-5:10 pm',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto_Light'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                            Icons
                                                .access_time_rounded, //location_on
                                            size: 27.0,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          'Wednesday  8:50 am-5:10 pm',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto_Light'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                            Icons
                                                .access_time_rounded, //location_on
                                            size: 27.0,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          'Thursday  8:50 am-5:10 pm',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto_Light'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                            Icons
                                                .access_time_rounded, //location_on
                                            size: 27.0,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          'Friday  8:50 am-5:10 pm',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto_Light'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
//-------------------------- Further Info Column -------------------------------
                            Column(
                              children: [
                                const Center(
                                  child: Text('Further Info',
                                      /* style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ), */
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.transparent,
                                          decorationColor: Colors.grey,
                                          shadows: [
                                            Shadow(
                                                color: Colors.white,
                                                offset: Offset(0, -7))
                                          ],
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 1.0)),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Center(
                                  child: Link(
                                      uri: Uri.parse(
                                          'https://www.serveen.com/nai/serveen/index.php'),
                                      target: LinkTarget.self,
                                      builder: (context, followLink) {
                                        return RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Home',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = followLink,
                                            ),
                                          ]),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Link(
                                      uri: Uri.parse(
                                          'https://www.serveen.com/nai/serveen/projects.php'),
                                      target: LinkTarget.self,
                                      builder: (context, followLink) {
                                        return RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Team',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = followLink,
                                            ),
                                          ]),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Link(
                                      uri: Uri.parse(
                                          'https://www.serveen.com/nai/serveen/services.php'),
                                      target: LinkTarget.self,
                                      builder: (context, followLink) {
                                        return RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Services',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = followLink,
                                            ),
                                          ]),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Link(
                                      uri: Uri.parse(
                                          'https://www.serveen.com/nai/serveen/contact.php'),
                                      target: LinkTarget.self,
                                      builder: (context, followLink) {
                                        return RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'About Us',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = followLink,
                                            ),
                                          ]),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
//-------------------------- Copyrights Watermark ------------------------------
        bottomNavigationBar: const BottomAppBar(
            color: Colors.grey,
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: Center(
                  child: Text(
                "All rights are reserved @SSS - 2022",
                textAlign: TextAlign.center,
              )),
            )),
      ),
    );
  }
}

_makingPhoneCall() async {
  var url = Uri.parse("tel:9848022338");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
