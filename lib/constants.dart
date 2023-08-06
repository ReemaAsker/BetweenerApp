import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//==========endpoints==========================
const baseUrl = 'http://www.osamapro.online/api';
const loginUrl = '$baseUrl/login';
const linksUrl = '$baseUrl/links';
const searchkUrl = '$baseUrl/search';
const followUrl = '$baseUrl/follow';
const registerUrl = '$baseUrl/register';
// ============= STYLE CONSTS ==============

const kScaffoldColor = Color(0xffFDFDFD);
const kRedColor = Color(0xffA90606);

const kPrimaryColor = Color(0xff2D2B4E);
const kSecondaryColor = Color(0xffFFD465);
const kOnSecondaryColor = Color(0xff784E00);
const kDangerColor = Color(0xffF56C61);

// Low Opacity Colors
const kLinksColor = Color(0xff807D99);
const kLightPrimaryColor = Color(0xffE7E5F1);
const kLightSecondaryColor = Color(0xffFFE6A6);
const kLightDangerColor = Color(0xffFEE2E7);
const kOnLightDangerColor = Color(0xff783341);

//popular social media icons
const Map<String, IconData> socialMediaIcons = {
  'facebook': FontAwesomeIcons.facebook,
  'twitter': FontAwesomeIcons.twitter,
  'instagram': FontAwesomeIcons.instagram,
  'linkedin': FontAwesomeIcons.linkedin,
  'youtube': FontAwesomeIcons.youtube,
  'pinterest': FontAwesomeIcons.pinterest,
  'snapchat': FontAwesomeIcons.snapchat,
  'tiktok': FontAwesomeIcons.tiktok,
  'whatsapp': FontAwesomeIcons.whatsapp,
  'telegram': FontAwesomeIcons.telegram,
  'discord': FontAwesomeIcons.discord,
  'reddit': FontAwesomeIcons.reddit,
  'tumblr': FontAwesomeIcons.tumblr,
  'twitch': FontAwesomeIcons.twitch,
  'spotify': FontAwesomeIcons.spotify,
  'soundcloud': FontAwesomeIcons.soundcloud,
  'github': FontAwesomeIcons.github,
  'yahoo': FontAwesomeIcons.yahoo,
  // Add more social media icons as needed
};
