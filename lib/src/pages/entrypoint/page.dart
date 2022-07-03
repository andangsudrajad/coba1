import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/src/components/index.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/auth/auth_state.dart';
import 'package:map/map.dart' as map;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:auth_buttons/auth_buttons.dart';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:tcard/tcard.dart';
import 'package:collection/collection.dart';
import 'package:myapp/src/pages/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:latlng/latlng.dart';
import 'package:badges/badges.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:teta_cms/teta_cms.dart';
import 'package:webviewx/webviewx.dart';

class PageEntryPoint extends StatefulWidget {
  const PageEntryPoint({
    Key? key,
    this.param1 = '''0''',
  }) : super(key: key);

  final String param1;

  @override
  _StateEntryPoint createState() => _StateEntryPoint();
}

class _StateEntryPoint extends AuthState<PageEntryPoint>
    with SingleTickerProviderStateMixin {
  String state1 = '0';

  var datasets = <String, dynamic>{};
  int index = 0;

  @override
  void initState() {
    super.initState();

    TetaCMS.instance.analytics.insertEvent(
      TetaAnalyticsType.usage,
      'App usage: view page',
      <String, dynamic>{
        'name': "EntryPoint",
      },
      isUserIdPreferableIfExists: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Color(0xFF30A283).withOpacity(1),
              border: Border(
                left: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
                top: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
                right: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
                bottom: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                    color: Color(0xFF000000).withOpacity(1)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: TetaFutureBuilder(
                  future: TetaCMS.instance.auth.user.get,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final user = snapshot.data as Map<String, dynamic>?;
                    final data = <String, dynamic>{
                      'isLogged': user?.keys.isNotEmpty,
                      'uid': user?['uid'],
                      'name': user?['name'],
                      'email': user?['email'],
                      'locale': user?['locale'],
                      'provider': user?['provider'],
                    };
                    datasets['Teta Auth User'] = [
                      if (data != null) data,
                    ];
                    var index = 0;
                    return (('''${this.datasets['Teta Auth User']?[0]?['isLogged']?.toString() ?? ''}''') ==
                            '''true''')
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                r'''You have already logged...''',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Color(0xFFFFFFFF).withOpacity(1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 32,
                                ),
                                child: Text(
                                  r'''Go to your tasks''',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Color(0xFFFFFFFF).withOpacity(1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageHomePage(),
                                    ),
                                  );
                                },
                                onDoubleTap: () async {},
                                onLongPress: () async {},
                                child: Container(
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    top: 16,
                                    right: 16,
                                    bottom: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF).withOpacity(1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                      bottomRight: Radius.circular(32),
                                      bottomLeft: Radius.circular(32),
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          color:
                                              Color(0xFF000000).withOpacity(1)),
                                      top: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          color:
                                              Color(0xFF000000).withOpacity(1)),
                                      right: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          color:
                                              Color(0xFF000000).withOpacity(1)),
                                      bottom: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          color:
                                              Color(0xFF000000).withOpacity(1)),
                                    ),
                                  ),
                                  child: Icon(
                                    MdiIcons.fromString('arrow-right'),
                                    size: 32,
                                    color: Color(0xFF30A283).withOpacity(1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 220,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r'''Welcome to
our Template''',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color:
                                              Color(0xFFFFFFFF).withOpacity(1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 40,
                                          fontStyle: FontStyle.normal,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                      ),
                                      child: Text(
                                        r'''Create in few steps a to do list for all your events!''',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: Color(0xFFFFFFFF)
                                                .withOpacity(1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        textAlign: TextAlign.left,
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                height: 56,
                                child: AppleAuthButton(
                                  onPressed: () async {
                                    await TetaCMS.instance.auth.signIn(
                                        provider: TetaProvider.apple,
                                        onSuccess: () async {
                                          await Navigator.push<void>(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PageHomePage(),
                                            ),
                                          );
                                        });
                                  },
                                  onLongPress: () async {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  height: 56,
                                  child: GoogleAuthButton(
                                    onPressed: () async {
                                      await TetaCMS.instance.auth.signIn(
                                          provider: TetaProvider.google,
                                          onSuccess: () async {
                                            await Navigator.push<void>(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PageHomePage(),
                                              ),
                                            );
                                          });
                                    },
                                    onLongPress: () async {},
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 48,
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  height: 56,
                                  child: GithubAuthButton(
                                    onPressed: () async {
                                      await TetaCMS.instance.auth.signIn(
                                          provider: TetaProvider.github,
                                          onSuccess: () async {
                                            await Navigator.push<void>(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PageHomePage(),
                                              ),
                                            );
                                          });
                                    },
                                    onLongPress: () async {},
                                  ),
                                ),
                              ),
                            ],
                          );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
