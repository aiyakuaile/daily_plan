// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Project Name`
  String get project_name {
    return Intl.message(
      'Project Name',
      name: 'project_name',
      desc: '',
      args: [],
    );
  }

  /// `Task Process`
  String get task_process {
    return Intl.message(
      'Task Process',
      name: 'task_process',
      desc: '',
      args: [],
    );
  }

  /// `Create Time`
  String get project_create_time {
    return Intl.message(
      'Create Time',
      name: 'project_create_time',
      desc: '',
      args: [],
    );
  }

  /// `(eg: Waiting,Doing,Done)`
  String get process_example {
    return Intl.message(
      '(eg: Waiting,Doing,Done)',
      name: 'process_example',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Theme Settings`
  String get theme_settings {
    return Intl.message(
      'Theme Settings',
      name: 'theme_settings',
      desc: '',
      args: [],
    );
  }

  /// `Updates`
  String get check_update {
    return Intl.message(
      'Updates',
      name: 'check_update',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get dialog_title {
    return Intl.message(
      'Warning',
      name: 'dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete it?`
  String get delete_project_content {
    return Intl.message(
      'Are you sure to delete it?',
      name: 'delete_project_content',
      desc: '',
      args: [],
    );
  }

  /// `content`
  String get content {
    return Intl.message(
      'content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `Tags(use '、，,.' split tags)`
  String get tags {
    return Intl.message(
      'Tags(use \'、，,.\' split tags)',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `remark`
  String get remark {
    return Intl.message(
      'remark',
      name: 'remark',
      desc: '',
      args: [],
    );
  }

  /// `Mask Opacity`
  String get mask_opacity {
    return Intl.message(
      'Mask Opacity',
      name: 'mask_opacity',
      desc: '',
      args: [],
    );
  }

  /// `Wallpaper`
  String get select_bg {
    return Intl.message(
      'Wallpaper',
      name: 'select_bg',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get default_bg {
    return Intl.message(
      'Default',
      name: 'default_bg',
      desc: '',
      args: [],
    );
  }

  /// `Bing`
  String get bing {
    return Intl.message(
      'Bing',
      name: 'bing',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom_bg {
    return Intl.message(
      'Custom',
      name: 'custom_bg',
      desc: '',
      args: [],
    );
  }

  /// `go star`
  String get star {
    return Intl.message(
      'go star',
      name: 'star',
      desc: '',
      args: [],
    );
  }

  /// `go issue`
  String get issue {
    return Intl.message(
      'go issue',
      name: 'issue',
      desc: '',
      args: [],
    );
  }

  /// `Already the latest version`
  String get latest_version {
    return Intl.message(
      'Already the latest version',
      name: 'latest_version',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get update_version {
    return Intl.message(
      'Update Now',
      name: 'update_version',
      desc: '',
      args: [],
    );
  }

  /// `Release version note`
  String get version_note {
    return Intl.message(
      'Release version note',
      name: 'version_note',
      desc: '',
      args: [],
    );
  }

  /// `New version update content`
  String get new_version_note {
    return Intl.message(
      'New version update content',
      name: 'new_version_note',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get language_item {
    return Intl.message(
      'Select Language',
      name: 'language_item',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
