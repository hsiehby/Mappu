import 'package:google_maps_flutter/google_maps_flutter.dart';

class Country {
  late String name;
  late LatLng latlng;
  late String continent;

  Country({required this.name, required this.latlng, required this.continent});
}

final countryList = countryDetails.entries.map((c) => c.value.name).toList();

var countryDetails = {
  "AL": Country(name: "Albania", latlng: LatLng(41, 20), continent: "Europe"),
  "DZ": Country(name: "Algeria", latlng: LatLng(28, 3), continent: "Africa"),
  "AS": Country(
      name: "American Samoa",
      latlng: LatLng(-14.3333, -170),
      continent: "Oceania"),
  "AD":
      Country(name: "Andorra", latlng: LatLng(42.5, 1.6), continent: "Europe"),
  "AO":
      Country(name: "Angola", latlng: LatLng(-12.5, 18.5), continent: "Africa"),
  "AI": Country(
      name: "Anguilla",
      latlng: LatLng(18.25, -63.1667),
      continent: "North America"),
  "AQ": Country(
      name: "Antarctica", latlng: LatLng(-90, 0), continent: "Antarctica"),
  "AG": Country(
      name: "Antigua and Barbuda",
      latlng: LatLng(17.05, -61.8),
      continent: "North America"),
  "AR": Country(
      name: "Argentina", latlng: LatLng(-34, -64), continent: "South America"),
  "AM": Country(name: "Armenia", latlng: LatLng(40, 45), continent: "Europe"),
  "AW": Country(
      name: "Aruba",
      latlng: LatLng(12.5, -69.9667),
      continent: "North America"),
  "AU": Country(
      name: "Australia", latlng: LatLng(-27, 133), continent: "Oceania"),
  "AT": Country(
      name: "Austria", latlng: LatLng(47.3333, 13.3333), continent: "Europe"),
  "AZ": Country(
      name: "Azerbaijan", latlng: LatLng(40.5, 47.5), continent: "Europe"),
  "BS": Country(
      name: "Bahamas", latlng: LatLng(24.25, -76), continent: "North America"),
  "BH": Country(name: "Bahrain", latlng: LatLng(26, 50.55), continent: "Asia"),
  "BD": Country(name: "Bangladesh", latlng: LatLng(24, 90), continent: "Asia"),
  "BB": Country(
      name: "Barbados",
      latlng: LatLng(13.1667, -59.5333),
      continent: "North America"),
  "BY": Country(name: "Belarus", latlng: LatLng(53, 28), continent: "Europe"),
  "BE":
      Country(name: "Belgium", latlng: LatLng(50.8333, 4), continent: "Europe"),
  "BZ": Country(
      name: "Belize",
      latlng: LatLng(17.25, -88.75),
      continent: "North America"),
  "BJ": Country(name: "Benin", latlng: LatLng(9.5, 2.25), continent: "Africa"),
  "BM": Country(
      name: "Bermuda",
      latlng: LatLng(32.3333, -64.75),
      continent: "North America"),
  "BT": Country(name: "Bhutan", latlng: LatLng(27.5, 90.5), continent: "Asia"),
  "BO": Country(
      name: "Bolivia, Plurinational State of",
      latlng: LatLng(-17, -65),
      continent: "South America"),
  "BA": Country(
      name: "Bosnia and Herzegovina",
      latlng: LatLng(44, 18),
      continent: "Europe"),
  "BW": Country(name: "Botswana", latlng: LatLng(-22, 24), continent: "Africa"),
  "BV": Country(
      name: "Bouvet Island",
      latlng: LatLng(-54.4333, 3.4),
      continent: "Antarctica"),
  "BR": Country(
      name: "Brazil", latlng: LatLng(-10, -55), continent: "South America"),
  "IO": Country(
      name: "British Indian Ocean Territory",
      latlng: LatLng(-6, 71.5),
      continent: "Asia"),
  "BN": Country(
      name: "Brunei Darussalam",
      latlng: LatLng(4.5, 114.6667),
      continent: "Asia"),
  "BG": Country(name: "Bulgaria", latlng: LatLng(43, 25), continent: "Europe"),
  "BF": Country(
      name: "Burkina Faso", latlng: LatLng(13, -2), continent: "Africa"),
  "BI": Country(name: "Burundi", latlng: LatLng(-3.5, 30), continent: "Africa"),
  "KH": Country(name: "Cambodia", latlng: LatLng(13, 105), continent: "Asia"),
  "CM": Country(name: "Cameroon", latlng: LatLng(6, 12), continent: "Africa"),
  "CA": Country(
      name: "Canada", latlng: LatLng(60, -95), continent: "North America"),
  "CV":
      Country(name: "Cape Verde", latlng: LatLng(16, -24), continent: "Africa"),
  "KY": Country(
      name: "Cayman Islands",
      latlng: LatLng(19.5, -80.5),
      continent: "North America"),
  "CF": Country(
      name: "Central African Republic",
      latlng: LatLng(7, 21),
      continent: "Africa"),
  "TD": Country(name: "Chad", latlng: LatLng(15, 19), continent: "Africa"),
  "CL": Country(
      name: "Chile", latlng: LatLng(-30, -71), continent: "South America"),
  "CN": Country(name: "China", latlng: LatLng(35, 105), continent: "Asia"),
  "CX": Country(
      name: "Christmas Island",
      latlng: LatLng(-10.5, 105.6667),
      continent: "Asia"),
  "CC": Country(
      name: "Cocos (Keeling) Islands",
      latlng: LatLng(-12.5, 96.8333),
      continent: "Asia"),
  "CO": Country(
      name: "Colombia", latlng: LatLng(4, -72), continent: "South America"),
  "KM": Country(
      name: "Comoros", latlng: LatLng(-12.1667, 44.25), continent: "Africa"),
  "CG": Country(name: "Congo", latlng: LatLng(-1, 15), continent: "Africa"),
  "CD": Country(
      name: "Congo, the Democratic Republic of the",
      latlng: LatLng(0, 25),
      continent: "Africa"),
  "CK": Country(
      name: "Cook Islands",
      latlng: LatLng(-21.2333, -159.7667),
      continent: "Oceania"),
  "CR": Country(
      name: "Costa Rica", latlng: LatLng(10, -84), continent: "North America"),
  "CI": Country(
      name: "C\u00f4te d'Ivoire", latlng: LatLng(8, -5), continent: "Africa"),
  "HR": Country(
      name: "Croatia", latlng: LatLng(45.1667, 15.5), continent: "Europe"),
  "CU": Country(
      name: "Cuba", latlng: LatLng(21.5, -80), continent: "North America"),
  "CY": Country(name: "Cyprus", latlng: LatLng(35, 33), continent: "Europe"),
  "CZ": Country(
      name: "Czech Republic", latlng: LatLng(49.75, 15.5), continent: "Europe"),
  "DK": Country(name: "Denmark", latlng: LatLng(56, 10), continent: "Europe"),
  "DJ":
      Country(name: "Djibouti", latlng: LatLng(11.5, 43), continent: "Africa"),
  "DM": Country(
      name: "Dominica",
      latlng: LatLng(15.4167, -61.3333),
      continent: "North America"),
  "DO": Country(
      name: "Dominican Republic",
      latlng: LatLng(19, -70.6667),
      continent: "North America"),
  "EC": Country(
      name: "Ecuador", latlng: LatLng(-2, -77.5), continent: "South America"),
  "EG": Country(name: "Egypt", latlng: LatLng(27, 30), continent: "Africa"),
  "SV": Country(
      name: "El Salvador",
      latlng: LatLng(13.8333, -88.9167),
      continent: "North America"),
  "GQ": Country(
      name: "Equatorial Guinea", latlng: LatLng(2, 10), continent: "Africa"),
  "ER": Country(name: "Eritrea", latlng: LatLng(15, 39), continent: "Africa"),
  "EE": Country(name: "Estonia", latlng: LatLng(59, 26), continent: "Europe"),
  "ET": Country(name: "Ethiopia", latlng: LatLng(8, 38), continent: "Africa"),
  "FK": Country(
      name: "Falkland Islands (Malvinas)",
      latlng: LatLng(-51.75, -59),
      continent: "South America"),
  "FO": Country(
      name: "Faroe Islands", latlng: LatLng(62, -7), continent: "Europe"),
  "FJ": Country(name: "Fiji", latlng: LatLng(-18, 175), continent: "Oceania"),
  "FI": Country(name: "Finland", latlng: LatLng(64, 26), continent: "Europe"),
  "FR": Country(name: "France", latlng: LatLng(46, 2), continent: "Europe"),
  "GF": Country(
      name: "French Guiana",
      latlng: LatLng(4, -53),
      continent: "South America"),
  "PF": Country(
      name: "French Polynesia",
      latlng: LatLng(-15, -140),
      continent: "Oceania"),
  "TF": Country(
      name: "French Southern Territories",
      latlng: LatLng(-43, 67),
      continent: "Antarctica"),
  "GA": Country(name: "Gabon", latlng: LatLng(-1, 11.75), continent: "Africa"),
  "GM": Country(
      name: "Gambia", latlng: LatLng(13.4667, -16.5667), continent: "Africa"),
  "GE": Country(name: "Georgia", latlng: LatLng(42, 43.5), continent: "Europe"),
  "DE": Country(name: "Germany", latlng: LatLng(51, 9), continent: "Europe"),
  "GH": Country(name: "Ghana", latlng: LatLng(8, -2), continent: "Africa"),
  "GI": Country(
      name: "Gibraltar", latlng: LatLng(36.1833, -5.3667), continent: "Europe"),
  "GR": Country(name: "Greece", latlng: LatLng(39, 22), continent: "Europe"),
  "GL": Country(
      name: "Greenland", latlng: LatLng(72, -40), continent: "North America"),
  "GD": Country(
      name: "Grenada",
      latlng: LatLng(12.1167, -61.6667),
      continent: "North America"),
  "GP": Country(
      name: "Guadeloupe",
      latlng: LatLng(16.25, -61.5833),
      continent: "North America"),
  "GU": Country(
      name: "Guam", latlng: LatLng(13.4667, 144.7833), continent: "Oceania"),
  "GT": Country(
      name: "Guatemala",
      latlng: LatLng(15.5, -90.25),
      continent: "North America"),
  "GG": Country(
      name: "Guernsey", latlng: LatLng(49.5, -2.56), continent: "Europe"),
  "GN": Country(name: "Guinea", latlng: LatLng(11, -10), continent: "Africa"),
  "GW": Country(
      name: "Guinea-Bissau", latlng: LatLng(12, -15), continent: "Africa"),
  "GY": Country(
      name: "Guyana", latlng: LatLng(5, -59), continent: "South America"),
  "HT": Country(
      name: "Haiti", latlng: LatLng(19, -72.4167), continent: "North America"),
  "HM": Country(
      name: "Heard Island and McDonald Islands",
      latlng: LatLng(-53.1, 72.5167),
      continent: "Antarctica"),
  "VA": Country(
      name: "Holy See (Vatican City State)",
      latlng: LatLng(41.9, 12.45),
      continent: "Europe"),
  "HN": Country(
      name: "Honduras", latlng: LatLng(15, -86.5), continent: "North America"),
  "HK": Country(
      name: "Hong Kong", latlng: LatLng(22.25, 114.1667), continent: "Asia"),
  "HU": Country(name: "Hungary", latlng: LatLng(47, 20), continent: "Europe"),
  "IS": Country(name: "Iceland", latlng: LatLng(65, -18), continent: "Europe"),
  "IN": Country(name: "India", latlng: LatLng(20, 77), continent: "Asia"),
  "ID": Country(name: "Indonesia", latlng: LatLng(-5, 120), continent: "Asia"),
  "IR": Country(
      name: "Iran, Islamic Republic of",
      latlng: LatLng(32, 53),
      continent: "Asia"),
  "IQ": Country(name: "Iraq", latlng: LatLng(33, 44), continent: "Asia"),
  "IE": Country(name: "Ireland", latlng: LatLng(53, -8), continent: "Europe"),
  "IM": Country(
      name: "Isle of Man", latlng: LatLng(54.23, -4.55), continent: "Europe"),
  "IL": Country(name: "Israel", latlng: LatLng(31.5, 34.75), continent: "Asia"),
  "IT": Country(
      name: "Italy", latlng: LatLng(42.8333, 12.8333), continent: "Europe"),
  "JM": Country(
      name: "Jamaica",
      latlng: LatLng(18.25, -77.5),
      continent: "North America"),
  "JP": Country(name: "Japan", latlng: LatLng(36, 138), continent: "Asia"),
  "JE": Country(
      name: "Jersey", latlng: LatLng(49.21, -2.13), continent: "Europe"),
  "JO": Country(name: "Jordan", latlng: LatLng(31, 36), continent: "Asia"),
  "KZ":
      Country(name: "Kazakhstan", latlng: LatLng(48, 68), continent: "Europe"),
  "KE": Country(name: "Kenya", latlng: LatLng(1, 38), continent: "Africa"),
  "KI": Country(
      name: "Kiribati", latlng: LatLng(1.4167, 173), continent: "Oceania"),
  "KP": Country(
      name: "Korea, Democratic People's Republic of",
      latlng: LatLng(40, 127),
      continent: "Asia"),
  "KR": Country(
      name: "Korea, Republic of", latlng: LatLng(37, 127.5), continent: "Asia"),
  "KW": Country(
      name: "Kuwait", latlng: LatLng(29.3375, 47.6581), continent: "Asia"),
  "KG": Country(name: "Kyrgyzstan", latlng: LatLng(41, 75), continent: "Asia"),
  "LA": Country(
      name: "Lao People's Democratic Republic",
      latlng: LatLng(18, 105),
      continent: "Asia"),
  "LV": Country(name: "Latvia", latlng: LatLng(57, 25), continent: "Europe"),
  "LB": Country(
      name: "Lebanon", latlng: LatLng(33.8333, 35.8333), continent: "Asia"),
  "LS": Country(
      name: "Lesotho", latlng: LatLng(-29.5, 28.5), continent: "Africa"),
  "LR":
      Country(name: "Liberia", latlng: LatLng(6.5, -9.5), continent: "Africa"),
  "LY": Country(
      name: "Libyan Arab Jamahiriya",
      latlng: LatLng(25, 17),
      continent: "Africa"),
  "LI": Country(
      name: "Liechtenstein",
      latlng: LatLng(47.1667, 9.5333),
      continent: "Europe"),
  "LT": Country(name: "Lithuania", latlng: LatLng(56, 24), continent: "Europe"),
  "LU": Country(
      name: "Luxembourg", latlng: LatLng(49.75, 6.1667), continent: "Europe"),
  "MO": Country(
      name: "Macao", latlng: LatLng(22.1667, 113.55), continent: "Asia"),
  "MK": Country(
      name: "Macedonia, the former Yugoslav Republic of",
      latlng: LatLng(41.8333, 22),
      continent: "Europe"),
  "MG":
      Country(name: "Madagascar", latlng: LatLng(-20, 47), continent: "Africa"),
  "MW": Country(name: "Malawi", latlng: LatLng(-13.5, 34), continent: "Africa"),
  "MY":
      Country(name: "Malaysia", latlng: LatLng(2.5, 112.5), continent: "Asia"),
  "MV": Country(name: "Maldives", latlng: LatLng(3.25, 73), continent: "Asia"),
  "ML": Country(name: "Mali", latlng: LatLng(17, -4), continent: "Africa"),
  "MT": Country(
      name: "Malta", latlng: LatLng(35.8333, 14.5833), continent: "Europe"),
  "MH": Country(
      name: "Marshall Islands", latlng: LatLng(9, 168), continent: "Oceania"),
  "MQ": Country(
      name: "Martinique",
      latlng: LatLng(14.6667, -61),
      continent: "North America"),
  "MR":
      Country(name: "Mauritania", latlng: LatLng(20, -12), continent: "Africa"),
  "MU": Country(
      name: "Mauritius", latlng: LatLng(-20.2833, 57.55), continent: "Africa"),
  "YT": Country(
      name: "Mayotte", latlng: LatLng(-12.8333, 45.1667), continent: "Africa"),
  "MX": Country(
      name: "Mexico", latlng: LatLng(23, -102), continent: "North America"),
  "FM": Country(
      name: "Micronesia, Federated States of",
      latlng: LatLng(6.9167, 158.25),
      continent: "Oceania"),
  "MD": Country(
      name: "Moldova, Republic of",
      latlng: LatLng(47, 29),
      continent: "Europe"),
  "MC": Country(
      name: "Monaco", latlng: LatLng(43.7333, 7.4), continent: "Europe"),
  "MN": Country(name: "Mongolia", latlng: LatLng(46, 105), continent: "Asia"),
  "ME":
      Country(name: "Montenegro", latlng: LatLng(42, 19), continent: "Europe"),
  "MS": Country(
      name: "Montserrat",
      latlng: LatLng(16.75, -62.2),
      continent: "North America"),
  "MA": Country(name: "Morocco", latlng: LatLng(32, -5), continent: "Africa"),
  "MZ": Country(
      name: "Mozambique", latlng: LatLng(-18.25, 35), continent: "Africa"),
  "MM": Country(name: "Myanmar", latlng: LatLng(22, 98), continent: "Asia"),
  "NR": Country(
      name: "Nauru", latlng: LatLng(-0.5333, 166.9167), continent: "Oceania"),
  "NP": Country(name: "Nepal", latlng: LatLng(28, 84), continent: "Asia"),
  "NL": Country(
      name: "Netherlands", latlng: LatLng(52.5, 5.75), continent: "Europe"),
  "AN": Country(
      name: "Netherlands Antilles",
      latlng: LatLng(12.25, -68.75),
      continent: "North America"),
  "NC": Country(
      name: "New Caledonia",
      latlng: LatLng(-21.5, 165.5),
      continent: "Oceania"),
  "NZ": Country(
      name: "New Zealand", latlng: LatLng(-41, 174), continent: "Oceania"),
  "NI": Country(
      name: "Nicaragua", latlng: LatLng(13, -85), continent: "North America"),
  "NE": Country(name: "Niger", latlng: LatLng(16, 8), continent: "Africa"),
  "NG": Country(name: "Nigeria", latlng: LatLng(10, 8), continent: "Africa"),
  "NU": Country(
      name: "Niue", latlng: LatLng(-19.0333, -169.8667), continent: "Oceania"),
  "NF": Country(
      name: "Norfolk Island",
      latlng: LatLng(-29.0333, 167.95),
      continent: "Oceania"),
  "MP": Country(
      name: "Northern Mariana Islands",
      latlng: LatLng(15.2, 145.75),
      continent: "Oceania"),
  "NO": Country(name: "Norway", latlng: LatLng(62, 10), continent: "Europe"),
  "OM": Country(name: "Oman", latlng: LatLng(21, 57), continent: "Asia"),
  "PK": Country(name: "Pakistan", latlng: LatLng(30, 70), continent: "Asia"),
  "PW":
      Country(name: "Palau", latlng: LatLng(7.5, 134.5), continent: "Oceania"),
  "PS": Country(
      name: "Palestinian Territory, Occupied",
      latlng: LatLng(32, 35.25),
      continent: "Asia"),
  "PA": Country(
      name: "Panama", latlng: LatLng(9, -80), continent: "North America"),
  "PG": Country(
      name: "Papua New Guinea", latlng: LatLng(-6, 147), continent: "Oceania"),
  "PY": Country(
      name: "Paraguay", latlng: LatLng(-23, -58), continent: "South America"),
  "PE": Country(
      name: "Peru", latlng: LatLng(-10, -76), continent: "South America"),
  "PH":
      Country(name: "Philippines", latlng: LatLng(13, 122), continent: "Asia"),
  "PN": Country(
      name: "Pitcairn", latlng: LatLng(-24.7, -127.4), continent: "Oceania"),
  "PL": Country(name: "Poland", latlng: LatLng(52, 20), continent: "Europe"),
  "PT":
      Country(name: "Portugal", latlng: LatLng(39.5, -8), continent: "Europe"),
  "PR": Country(
      name: "Puerto Rico",
      latlng: LatLng(18.25, -66.5),
      continent: "North America"),
  "QA": Country(name: "Qatar", latlng: LatLng(25.5, 51.25), continent: "Asia"),
  "RE": Country(
      name: "R\u00e9union", latlng: LatLng(-21.1, 55.6), continent: "Africa"),
  "RO": Country(name: "Romania", latlng: LatLng(46, 25), continent: "Europe"),
  "RU": Country(
      name: "Russian Federation", latlng: LatLng(60, 100), continent: "Europe"),
  "RW": Country(name: "Rwanda", latlng: LatLng(-2, 30), continent: "Africa"),
  "SH": Country(
      name: "Saint Helena, Ascension and Tristan da Cunha",
      latlng: LatLng(-15.9333, -5.7),
      continent: "Africa"),
  "KN": Country(
      name: "Saint Kitts and Nevis",
      latlng: LatLng(17.3333, -62.75),
      continent: "North America"),
  "LC": Country(
      name: "Saint Lucia",
      latlng: LatLng(13.8833, -61.1333),
      continent: "North America"),
  "PM": Country(
      name: "Saint Pierre and Miquelon",
      latlng: LatLng(46.8333, -56.3333),
      continent: "North America"),
  "VC": Country(
      name: "Saint Vincent and the Grenadines",
      latlng: LatLng(13.25, -61.2),
      continent: "North America"),
  "WS": Country(
      name: "Samoa", latlng: LatLng(-13.5833, -172.3333), continent: "Oceania"),
  "SM": Country(
      name: "San Marino",
      latlng: LatLng(43.7667, 12.4167),
      continent: "Europe"),
  "ST": Country(
      name: "Sao Tome and Principe", latlng: LatLng(1, 7), continent: "Africa"),
  "SA":
      Country(name: "Saudi Arabia", latlng: LatLng(25, 45), continent: "Asia"),
  "SN": Country(name: "Senegal", latlng: LatLng(14, -14), continent: "Africa"),
  "RS": Country(name: "Serbia", latlng: LatLng(44, 21), continent: "Europe"),
  "SC": Country(
      name: "Seychelles",
      latlng: LatLng(-4.5833, 55.6667),
      continent: "Africa"),
  "SL": Country(
      name: "Sierra Leone", latlng: LatLng(8.5, -11.5), continent: "Africa"),
  "SG": Country(
      name: "Singapore", latlng: LatLng(1.3667, 103.8), continent: "Asia"),
  "SK": Country(
      name: "Slovakia", latlng: LatLng(48.6667, 19.5), continent: "Europe"),
  "SI": Country(name: "Slovenia", latlng: LatLng(46, 15), continent: "Europe"),
  "SB": Country(
      name: "Solomon Islands", latlng: LatLng(-8, 159), continent: "Oceania"),
  "SO": Country(name: "Somalia", latlng: LatLng(10, 49), continent: "Africa"),
  "ZA": Country(
      name: "South Africa", latlng: LatLng(-29, 24), continent: "Africa"),
  "GS": Country(
      name: "South Georgia and the South Sandwich Islands",
      latlng: LatLng(-54.5, -37),
      continent: "Antarctica"),
  "ES": Country(name: "Spain", latlng: LatLng(40, -4), continent: "Europe"),
  "LK": Country(name: "Sri Lanka", latlng: LatLng(7, 81), continent: "Asia"),
  "SD": Country(name: "Sudan", latlng: LatLng(15, 30), continent: "Africa"),
  "SR": Country(
      name: "Suriname", latlng: LatLng(4, -56), continent: "South America"),
  "SJ": Country(
      name: "Svalbard and Jan Mayen",
      latlng: LatLng(78, 20),
      continent: "Europe"),
  "SZ": Country(
      name: "Swaziland", latlng: LatLng(-26.5, 31.5), continent: "Africa"),
  "SE": Country(name: "Sweden", latlng: LatLng(62, 15), continent: "Europe"),
  "CH":
      Country(name: "Switzerland", latlng: LatLng(47, 8), continent: "Europe"),
  "SY": Country(
      name: "Syrian Arab Republic", latlng: LatLng(35, 38), continent: "Asia"),
  "TW": Country(
      name: "Taiwan, Province of China",
      latlng: LatLng(23.5, 121),
      continent: "Asia"),
  "TJ": Country(name: "Tajikistan", latlng: LatLng(39, 71), continent: "Asia"),
  "TZ": Country(
      name: "Tanzania, United Republic of",
      latlng: LatLng(-6, 35),
      continent: "Africa"),
  "TH": Country(name: "Thailand", latlng: LatLng(15, 100), continent: "Asia"),
  "TL": Country(
      name: "Timor-Leste", latlng: LatLng(-8.55, 125.5167), continent: "Asia"),
  "TG": Country(name: "Togo", latlng: LatLng(8, 1.1667), continent: "Africa"),
  "TK":
      Country(name: "Tokelau", latlng: LatLng(-9, -172), continent: "Oceania"),
  "TO": Country(name: "Tonga", latlng: LatLng(-20, -175), continent: "Oceania"),
  "TT": Country(
      name: "Trinidad and Tobago",
      latlng: LatLng(11, -61),
      continent: "North America"),
  "TN": Country(name: "Tunisia", latlng: LatLng(34, 9), continent: "Africa"),
  "TR": Country(name: "Turkey", latlng: LatLng(39, 35), continent: "Europe"),
  "TM":
      Country(name: "Turkmenistan", latlng: LatLng(40, 60), continent: "Asia"),
  "TC": Country(
      name: "Turks and Caicos Islands",
      latlng: LatLng(21.75, -71.5833),
      continent: "North America"),
  "TV": Country(name: "Tuvalu", latlng: LatLng(-8, 178), continent: "Oceania"),
  "UG": Country(name: "Uganda", latlng: LatLng(1, 32), continent: "Africa"),
  "UA": Country(name: "Ukraine", latlng: LatLng(49, 32), continent: "Europe"),
  "AE": Country(
      name: "United Arab Emirates", latlng: LatLng(24, 54), continent: "Asia"),
  "GB": Country(
      name: "United Kingdom", latlng: LatLng(54, -2), continent: "Europe"),
  "US": Country(
      name: "United States",
      latlng: LatLng(38, -97),
      continent: "North America"),
  "UM": Country(
      name: "United States Minor Outlying Islands",
      latlng: LatLng(19.2833, 166.6),
      continent: "Oceania"),
  "UY": Country(
      name: "Uruguay", latlng: LatLng(-33, -56), continent: "South America"),
  "UZ": Country(name: "Uzbekistan", latlng: LatLng(41, 64), continent: "Asia"),
  "VU":
      Country(name: "Vanuatu", latlng: LatLng(-16, 167), continent: "Oceania"),
  "VE": Country(
      name: "Venezuela, Bolivarian Republic of",
      latlng: LatLng(8, -66),
      continent: "South America"),
  "VN": Country(name: "Viet Nam", latlng: LatLng(16, 106), continent: "Asia"),
  "VG": Country(
      name: "Virgin Islands, British",
      latlng: LatLng(18.5, -64.5),
      continent: "North America"),
  "VI": Country(
      name: "Virgin Islands, U.S.",
      latlng: LatLng(18.3333, -64.8333),
      continent: "North America"),
  "WF": Country(
      name: "Wallis and Futuna",
      latlng: LatLng(-13.3, -176.2),
      continent: "Oceania"),
  "EH": Country(
      name: "Western Sahara", latlng: LatLng(24.5, -13), continent: "Africa"),
  "YE": Country(name: "Yemen", latlng: LatLng(15, 48), continent: "Asia"),
  "ZM": Country(name: "Zambia", latlng: LatLng(-15, 30), continent: "Africa"),
  "ZW": Country(name: "Zimbabwe", latlng: LatLng(-20, 30), continent: "Africa"),
  "AF": Country(name: "Afghanistan", latlng: LatLng(33, 65), continent: "Asia"),
  "Unknown Country": Country(name: "Unknown Country", latlng: LatLng(0,0), continent: "Unknown Country")
};

var countryToCode = {
  "Albania": "AL",
  "Algeria": "DZ",
  "American Samoa": "AS",
  "Andorra": "AD",
  "Angola": "AO",
  "Anguilla": "AI",
  "Antarctica": "AQ",
  "Antigua and Barbuda": "AG",
  "Argentina": "AR",
  "Armenia": "AM",
  "Aruba": "AW",
  "Australia": "AU",
  "Austria": "AT",
  "Azerbaijan": "AZ",
  "Bahamas": "BS",
  "Bahrain": "BH",
  "Bangladesh": "BD",
  "Barbados": "BB",
  "Belarus": "BY",
  "Belgium": "BE",
  "Belize": "BZ",
  "Benin": "BJ",
  "Bermuda": "BM",
  "Bhutan": "BT",
  "Bolivia, Plurinational State of": "BO",
  "Bosnia and Herzegovina": "BA",
  "Botswana": "BW",
  "Bouvet Island": "BV",
  "Brazil": "BR",
  "British Indian Ocean Territory": "IO",
  "Brunei Darussalam": "BN",
  "Bulgaria": "BG",
  "Burkina Faso": "BF",
  "Burundi": "BI",
  "Cambodia": "KH",
  "Cameroon": "CM",
  "Canada": "CA",
  "Cape Verde": "CV",
  "Cayman Islands": "KY",
  "Central African Republic": "CF",
  "Chad": "TD",
  "Chile": "CL",
  "China": "CN",
  "Christmas Island": "CX",
  "Cocos (Keeling) Islands": "CC",
  "Colombia": "CO",
  "Comoros": "KM",
  "Congo": "CG",
  "Congo, the Democratic Republic of the": "CD",
  "Cook Islands": "CK",
  "Costa Rica": "CR",
  "C\u00f4te d'Ivoire": "CI",
  "Croatia": "HR",
  "Cuba": "CU",
  "Cyprus": "CY",
  "Czech Republic": "CZ",
  "Denmark": "DK",
  "Djibouti": "DJ",
  "Dominica": "DM",
  "Dominican Republic": "DO",
  "Ecuador": "EC",
  "Egypt": "EG",
  "El Salvador": "SV",
  "Equatorial Guinea": "GQ",
  "Eritrea": "ER",
  "Estonia": "EE",
  "Ethiopia": "ET",
  "Falkland Islands (Malvinas)": "FK",
  "Faroe Islands": "FO",
  "Fiji": "FJ",
  "Finland": "FI",
  "France": "FR",
  "French Guiana": "GF",
  "French Polynesia": "PF",
  "French Southern Territories": "TF",
  "Gabon": "GA",
  "Gambia": "GM",
  "Georgia": "GE",
  "Germany": "DE",
  "Ghana": "GH",
  "Gibraltar": "GI",
  "Greece": "GR",
  "Greenland": "GL",
  "Grenada": "GD",
  "Guadeloupe": "GP",
  "Guam": "GU",
  "Guatemala": "GT",
  "Guernsey": "GG",
  "Guinea": "GN",
  "Guinea-Bissau": "GW",
  "Guyana": "GY",
  "Haiti": "HT",
  "Heard Island and McDonald Islands": "HM",
  "Holy See (Vatican City State)": "VA",
  "Honduras": "HN",
  "Hong Kong": "HK",
  "Hungary": "HU",
  "Iceland": "IS",
  "India": "IN",
  "Indonesia": "ID",
  "Iran, Islamic Republic of": "IR",
  "Iraq": "IQ",
  "Ireland": "IE",
  "Isle of Man": "IM",
  "Israel": "IL",
  "Italy": "IT",
  "Jamaica": "JM",
  "Japan": "JP",
  "Jersey": "JE",
  "Jordan": "JO",
  "Kazakhstan": "KZ",
  "Kenya": "KE",
  "Kiribati": "KI",
  "Korea, Democratic People's Republic of": "KP",
  "Korea, Republic of": "KR",
  "Kuwait": "KW",
  "Kyrgyzstan": "KG",
  "Lao People's Democratic Republic": "LA",
  "Latvia": "LV",
  "Lebanon": "LB",
  "Lesotho": "LS",
  "Liberia": "LR",
  "Libyan Arab Jamahiriya": "LY",
  "Liechtenstein": "LI",
  "Lithuania": "LT",
  "Luxembourg": "LU",
  "Macao": "MO",
  "Macedonia, the former Yugoslav Republic of": "MK",
  "Madagascar": "MG",
  "Malawi": "MW",
  "Malaysia": "MY",
  "Maldives": "MV",
  "Mali": "ML",
  "Malta": "MT",
  "Marshall Islands": "MH",
  "Martinique": "MQ",
  "Mauritania": "MR",
  "Mauritius": "MU",
  "Mayotte": "YT",
  "Mexico": "MX",
  "Micronesia, Federated States of": "FM",
  "Moldova, Republic of": "MD",
  "Monaco": "MC",
  "Mongolia": "MN",
  "Montenegro": "ME",
  "Montserrat": "MS",
  "Morocco": "MA",
  "Mozambique": "MZ",
  "Myanmar": "MM",
  "Namibia": "NA",
  "Nauru": "NR",
  "Nepal": "NP",
  "Netherlands": "NL",
  "Netherlands Antilles": "AN",
  "New Caledonia": "NC",
  "New Zealand": "NZ",
  "Nicaragua": "NI",
  "Niger": "NE",
  "Nigeria": "NG",
  "Niue": "NU",
  "Norfolk Island": "NF",
  "Northern Mariana Islands": "MP",
  "Norway": "NO",
  "Oman": "OM",
  "Pakistan": "PK",
  "Palau": "PW",
  "Palestinian Territory, Occupied": "PS",
  "Panama": "PA",
  "Papua New Guinea": "PG",
  "Paraguay": "PY",
  "Peru": "PE",
  "Philippines": "PH",
  "Pitcairn": "PN",
  "Poland": "PL",
  "Portugal": "PT",
  "Puerto Rico": "PR",
  "Qatar": "QA",
  "R\u00e9union": "RE",
  "Romania": "RO",
  "Russian Federation": "RU",
  "Rwanda": "RW",
  "Saint Helena, Ascension and Tristan da Cunha": "SH",
  "Saint Kitts and Nevis": "KN",
  "Saint Lucia": "LC",
  "Saint Pierre and Miquelon": "PM",
  "Saint Vincent and the Grenadines": "VC",
  "Samoa": "WS",
  "San Marino": "SM",
  "Sao Tome and Principe": "ST",
  "Saudi Arabia": "SA",
  "Senegal": "SN",
  "Serbia": "RS",
  "Seychelles": "SC",
  "Sierra Leone": "SL",
  "Singapore": "SG",
  "Slovakia": "SK",
  "Slovenia": "SI",
  "Solomon Islands": "SB",
  "Somalia": "SO",
  "South Africa": "ZA",
  "South Georgia and the South Sandwich Islands": "GS",
  "Spain": "ES",
  "Sri Lanka": "LK",
  "Sudan": "SD",
  "Suriname": "SR",
  "Svalbard and Jan Mayen": "SJ",
  "Swaziland": "SZ",
  "Sweden": "SE",
  "Switzerland": "CH",
  "Syrian Arab Republic": "SY",
  "Taiwan, Province of China": "TW",
  "Tajikistan": "TJ",
  "Tanzania, United Republic of": "TZ",
  "Thailand": "TH",
  "Timor-Leste": "TL",
  "Togo": "TG",
  "Tokelau": "TK",
  "Tonga": "TO",
  "Trinidad and Tobago": "TT",
  "Tunisia": "TN",
  "Turkey": "TR",
  "Turkmenistan": "TM",
  "Turks and Caicos Islands": "TC",
  "Tuvalu": "TV",
  "Uganda": "UG",
  "Ukraine": "UA",
  "United Arab Emirates": "AE",
  "United Kingdom": "GB",
  "United States": "US",
  "United States Minor Outlying Islands": "UM",
  "Uruguay": "UY",
  "Uzbekistan": "UZ",
  "Vanuatu": "VU",
  "Venezuela, Bolivarian Republic of": "VE",
  "Viet Nam": "VN",
  "Virgin Islands, British": "VG",
  "Virgin Islands, U.S.": "VI",
  "Wallis and Futuna": "WF",
  "Western Sahara": "EH",
  "Yemen": "YE",
  "Zambia": "ZM",
  "Zimbabwe": "ZW",
  "Afghanistan": "AF"
};
