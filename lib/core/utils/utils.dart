import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sparkz/core/global/app_globals.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index.dart';

class Utils {
  void showException({required String? message}) {
    assert(message != null);
    showSimpleNotification(
      Row(
        children: <Widget>[
          Icon(CupertinoIcons.exclamationmark_triangle, color: Colors.white),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              message ?? "",
              style: (TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat')),
            ),
          ),
        ],
      ),
      background: const Color(0xFFFF4F01),
      autoDismiss: true,
      slideDismissDirection: DismissDirection.horizontal,
      key: const ValueKey('exception'),
      duration: const Duration(seconds: 5),
    );
  }

  OverlaySupportEntry downloadContent({@required String? message}) {
    assert(message != null);
    return showOverlayNotification(
      (_) {
        return Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            height: AppGlobals.extendedAppbar - 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                LinearProgressIndicator(
                  backgroundColor: AppGlobals.roseColor,
                ),
                Text(
                  message ?? "",
                  style: AppGlobals.subtitle2,
                ),
              ],
            ),
          ),
        );
      },
      key: const ValueKey('downloading'),
      duration: Duration.zero,
    );
  }

  void showMessage({@required String? message}) {
    assert(message != null);
    showSimpleNotification(
      Row(
        children: <Widget>[
          const Icon(Icons.check_circle_rounded, color: Colors.white),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              message ?? "",
              style: AppGlobals.subtitle2.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      background: Colors.green,
      autoDismiss: true,
      slideDismissDirection: DismissDirection.horizontal,
      key: const ValueKey('message'),
      duration: const Duration(seconds: 5),
    );
  }

  void showToast({@required String? message}) {
    toast(message ?? "");
  }

  void showCustomAnimation({@required String? message, @required double? val}) {
    CustomAnimationToast(
      message: message ?? "",
      value: val ?? 0,
    );
  }

  void showIosStyle({@required String? message, @required double? opacity}) {
    showOverlay((context, opacity) {
      return Opacity(
        opacity: opacity,
        child: IosStyleToast(message: message ?? ""),
      );
    });
  }

  Future<void> launchInBrowser(String url) async {
    try {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } catch (_) {
      showException(message: 'URL inválida');
    }
  }
}
