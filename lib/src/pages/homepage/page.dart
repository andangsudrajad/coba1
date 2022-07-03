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

class PageHomePage extends StatefulWidget {
  const PageHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _StateHomePage createState() => _StateHomePage();
}

class _StateHomePage extends AuthState<PageHomePage>
    with SingleTickerProviderStateMixin {
  var datasets = <String, dynamic>{};
  int index = 0;

  @override
  void initState() {
    super.initState();

    TetaCMS.instance.analytics.insertEvent(
      TetaAnalyticsType.usage,
      'App usage: view page',
      <String, dynamic>{
        'name': "HomePage",
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
              color: Color(0xFFFFFFFF).withOpacity(1),
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
            child: Stack(
              children: [
                SafeArea(
                  left: false,
                  top: true,
                  right: false,
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          top: 24,
                        ),
                        child: Text(
                          r'''Your Task''',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xFF30A283).withOpacity(1),
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      TetaFutureBuilder(
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
                            return TetaStreamBuilder(
                                stream:
                                    TetaCMS.instance.realtime.streamCollection(
                                  '''62aff225115478c782ccfd2e''',
                                  filters: [
                                    Filter('''''',
                                        '''${this.datasets['Teta Auth User']?[0]?['uid']?.toString() ?? ''}''')
                                  ],
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final list = snapshot.data as List<dynamic>?;
                                  datasets['Cms stream'] =
                                      list ?? const <dynamic>[];
                                  var index = 0;

                                  return SizedBox(
                                    width: double.maxFinite,
                                    height: 800,
                                    child: Builder(
                                      builder: (context) {
                                        return ListView.builder(
                                          reverse: true,
                                          shrinkWrap: true,
                                          itemCount: this
                                                      .datasets['Cms stream']
                                                      .length >
                                                  0
                                              ? this
                                                  .datasets['Cms stream']
                                                  .length
                                              : 0,
                                          itemBuilder: (context, index) {
                                            return PageTask(
                                              name: datasets['Cms stream']
                                                      ?[index]?['name'] ??
                                                  '',
                                              id: datasets['Cms stream']?[index]
                                                      ?['_id'] ??
                                                  '',
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                });
                          }),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageCreateTask(),
                              ),
                            );
                          },
                          onDoubleTap: () async {},
                          onLongPress: () async {},
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 32,
                              bottom: 56,
                            ),
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF30A283).withOpacity(1),
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
                            child: Icon(
                              MdiIcons.fromString('plus'),
                              size: 32,
                              color: Color(0xFFFFFFFF).withOpacity(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
