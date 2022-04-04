import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class CustomNotificationAlertDialog extends StatelessWidget {
  const CustomNotificationAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Allow Notifications'),
      content: Text('Sparkz would like to send you notifications'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Don\'t Allow',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            AwesomeNotifications()
                .requestPermissionToSendNotifications()
                .then((_) => Navigator.pop(context));
          },
          child: Text('Allow',
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
