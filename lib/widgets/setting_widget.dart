import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Widget settingWidget(model, BuildContext context) {
  const String shareText = 'newt_life';
  Icon arrowIcon = const Icon(Icons.arrow_forward_ios_sharp, size: 16);

  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['Michael.Schenker2020@gmail.com'],
    isHTML: false,
  );

  Widget widget = ListView(
    children: [
      // Stack(
      //   alignment: Alignment.center,
      //   children: [
      //     Container(width: 150, height: 120, color: Colors.grey[200], child: const Center(child: Icon(Icons.person_outline_outlined, size: 52, color: Colors.grey,))),
      //   ],
      // ),
      //
      // const Center(child: Text('Hongnak', style: TextStyle(fontSize: 16))),
      // const Divider(),
      ListTile(
        leading: const Icon(Icons.notification_important_outlined),
        title: const Text('お知らせ'),
        trailing: arrowIcon,
        onTap: () {
          // settingKind = SettingKind.notice;
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingDetailPage()));
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.mail_outline),
        title: const Text('お問い合わせ'),
        trailing: arrowIcon,
        onTap: () async {
          await FlutterEmailSender.send(email);
        },
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.rate_review_outlined),
          title: const Text('アプリをレビュー'),
          trailing: arrowIcon
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.ios_share),
          title: const Text('友達に教える'),
          trailing: arrowIcon,
          onTap: () {
            // Share.share(shareText);
          }
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.rule_outlined),
        title: const Text('利用規約'),
        trailing: arrowIcon,
        onTap: () async {
          // Uri url = Uri(scheme: 'https', host: 'newt-life.web.app', path: '/terms.html');
          // if (await canLaunchUrl(url)) {
          //   await launchUrl(url);
          // } else {
          //   throw 'このURLにはアクセスできません';
          // }
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.privacy_tip_outlined),
        title: const Text('プライバシーポリシー'),
        trailing: arrowIcon,
        onTap: () async {
          // Uri url = Uri(scheme: 'https', host: 'newt-life.web.app', path: '/privacy-policy.html');
          // if (await canLaunchUrl(url)) {
          //   await launchUrl(url);
          // } else {
          //   throw 'このURLにはアクセスできません';
          // }
        },
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.numbers_outlined),
          title: const Text('アプリバージョン'),
          trailing: Text(model.packageInfo.version)
      ),
      const Divider(),
    ],
  );
  return widget;
}