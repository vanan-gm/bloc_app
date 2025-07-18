import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don/\'t have an account'**
  String get dontHaveAnAccount;

  /// No description provided for @createAccountSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Create account successfully'**
  String get createAccountSuccessfully;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Password confirm'**
  String get passwordConfirm;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get alreadyHaveAnAccount;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalidPassword;

  /// No description provided for @invalidName.
  ///
  /// In en, this message translates to:
  /// **'Invalid name'**
  String get invalidName;

  /// No description provided for @passwordConfirmDoesNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password confirm does not match'**
  String get passwordConfirmDoesNotMatch;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @myFavoriteBlogs.
  ///
  /// In en, this message translates to:
  /// **'My Favorite Blogs'**
  String get myFavoriteBlogs;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @mins.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get mins;

  /// No description provided for @searchBlogsHere.
  ///
  /// In en, this message translates to:
  /// **'Search blogs here...'**
  String get searchBlogsHere;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @posts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get views;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @pictures.
  ///
  /// In en, this message translates to:
  /// **'Pictures'**
  String get pictures;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// About section with the user's name.
  ///
  /// In en, this message translates to:
  /// **'Hi, I\'m {name}, a passionate traveler, storyteller, and blogger with an insatiable curiosity for exploring the world. Traveling isn\'t just a hobby for me—it\'s a way of life. From wandering through ancient streets filled with history to relaxing on pristine, untouched beaches, every journey fuels my desire to discover and share.'**
  String aboutDescription1(String name);

  /// No description provided for @aboutDescription2.
  ///
  /// In en, this message translates to:
  /// **'Through my blog, I bring my experiences to life with vivid storytelling, stunning photography, and practical travel tips. I love uncovering hidden gems, immersing myself in diverse cultures, and capturing the essence of each place I visit. Whether it\'s solo adventures, cultural deep dives, food explorations, or road trips to breathtaking landscapes, I believe every journey has a story worth telling.'**
  String get aboutDescription2;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @changePasswordDescription1.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previous password'**
  String get changePasswordDescription1;

  /// No description provided for @changePasswordDescription2.
  ///
  /// In en, this message translates to:
  /// **'The new password must satisfy the password policy'**
  String get changePasswordDescription2;

  /// No description provided for @changePasswordDescription3.
  ///
  /// In en, this message translates to:
  /// **'The password must have at least 08 characters.'**
  String get changePasswordDescription3;

  /// No description provided for @changePasswordDescription4.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least 1 special character, such as @, &, %, TM,…'**
  String get changePasswordDescription4;

  /// No description provided for @changePasswordDescription5.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least 3 different kinds of characters, such as uppercase letters, lowercase letter, numeric digits, and punctuation marks.'**
  String get changePasswordDescription5;

  /// No description provided for @confirmChange.
  ///
  /// In en, this message translates to:
  /// **'Confirm Change'**
  String get confirmChange;

  /// No description provided for @failedToChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get failedToChangePassword;

  /// No description provided for @changePasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Change password successfully'**
  String get changePasswordSuccessMessage;

  /// No description provided for @preference.
  ///
  /// In en, this message translates to:
  /// **'Preference'**
  String get preference;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @enableFingerPrint.
  ///
  /// In en, this message translates to:
  /// **'Enable Finger-Print'**
  String get enableFingerPrint;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutOfYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Log Out of Your Account'**
  String get logoutOfYourAccount;

  /// No description provided for @logoutWarning.
  ///
  /// In en, this message translates to:
  /// **'Logging out will temporarily hide all blogs. To see them again, log back in to your account.'**
  String get logoutWarning;

  /// No description provided for @signOutSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Signout successfully'**
  String get signOutSuccessMessage;

  /// No description provided for @encounterError.
  ///
  /// In en, this message translates to:
  /// **'Encounter errors!!'**
  String get encounterError;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @featureInProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature is currently in progress, please comeback later.'**
  String get featureInProgressMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get by;

  /// No description provided for @selectYourImage.
  ///
  /// In en, this message translates to:
  /// **'Select your image'**
  String get selectYourImage;

  /// No description provided for @technology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get technology;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @programming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get programming;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @planetary.
  ///
  /// In en, this message translates to:
  /// **'Planetary'**
  String get planetary;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @travelling.
  ///
  /// In en, this message translates to:
  /// **'Travelling'**
  String get travelling;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get communication;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @selfImprovement.
  ///
  /// In en, this message translates to:
  /// **'Self Improvement'**
  String get selfImprovement;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @cultureAndTraditions.
  ///
  /// In en, this message translates to:
  /// **'Culture & Traditions'**
  String get cultureAndTraditions;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @photography.
  ///
  /// In en, this message translates to:
  /// **'Photography'**
  String get photography;

  /// No description provided for @moviesAndTvShows.
  ///
  /// In en, this message translates to:
  /// **'Movies & TV Shows'**
  String get moviesAndTvShows;

  /// No description provided for @spaceAndAstronomy.
  ///
  /// In en, this message translates to:
  /// **'Space & Astronomy'**
  String get spaceAndAstronomy;

  /// No description provided for @aiAndMachineLearning.
  ///
  /// In en, this message translates to:
  /// **'AI & Machine Learning'**
  String get aiAndMachineLearning;

  /// No description provided for @blogTitle.
  ///
  /// In en, this message translates to:
  /// **'Blog title'**
  String get blogTitle;

  /// No description provided for @blogContent.
  ///
  /// In en, this message translates to:
  /// **'Blog content'**
  String get blogContent;

  /// No description provided for @failedToUploadBlog.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload blog'**
  String get failedToUploadBlog;

  /// No description provided for @fieldMustBeNonEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field must be non-empty'**
  String get fieldMustBeNonEmpty;

  /// No description provided for @fieldMustBeOver6Char.
  ///
  /// In en, this message translates to:
  /// **'Field must be over 6 characters'**
  String get fieldMustBeOver6Char;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @aboutAppSlogan.
  ///
  /// In en, this message translates to:
  /// **'Write your story, share your world'**
  String get aboutAppSlogan;

  /// No description provided for @build.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get build;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get platform;

  /// No description provided for @minOsVersion.
  ///
  /// In en, this message translates to:
  /// **'Min OS Version'**
  String get minOsVersion;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @designedBy.
  ///
  /// In en, this message translates to:
  /// **'Designed by'**
  String get designedBy;

  /// No description provided for @footerContent.
  ///
  /// In en, this message translates to:
  /// **'© 2025 BlogApp. All rights reserved.'**
  String get footerContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
