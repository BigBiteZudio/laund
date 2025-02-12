import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'OtpScreen.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String _selectedCountryCode = "+91"; // Default country code

  final List<Map<String, String>> _countries = [
    {"name": "Afghanistan", "code": "+93", "short": "AF"},
    {"name": "Albania", "code": "+355", "short": "AL"},
    {"name": "Algeria", "code": "+213", "short": "DZ"},
    {"name": "Andorra", "code": "+376", "short": "AD"},
    {"name": "Angola", "code": "+244", "short": "AO"},
    {"name": "Argentina", "code": "+54", "short": "AR"},
    {"name": "Armenia", "code": "+374", "short": "AM"},
    {"name": "Australia", "code": "+61", "short": "AU"},
    {"name": "Austria", "code": "+43", "short": "AT"},
    {"name": "Azerbaijan", "code": "+994", "short": "AZ"},
    {"name": "Bahamas", "code": "+1-242", "short": "BS"},
    {"name": "Bahrain", "code": "+973", "short": "BH"},
    {"name": "Bangladesh", "code": "+880", "short": "BD"},
    {"name": "Barbados", "code": "+1-246", "short": "BB"},
    {"name": "Belarus", "code": "+375", "short": "BY"},
    {"name": "Belgium", "code": "+32", "short": "BE"},
    {"name": "Belize", "code": "+501", "short": "BZ"},
    {"name": "Benin", "code": "+229", "short": "BJ"},
    {"name": "Bhutan", "code": "+975", "short": "BT"},
    {"name": "Bolivia", "code": "+591", "short": "BO"},
    {"name": "Bosnia and Herzegovina", "code": "+387", "short": "BA"},
    {"name": "Botswana", "code": "+267", "short": "BW"},
    {"name": "Brazil", "code": "+55", "short": "BR"},
    {"name": "Brunei", "code": "+673", "short": "BN"},
    {"name": "Bulgaria", "code": "+359", "short": "BG"},
    {"name": "Burkina Faso", "code": "+226", "short": "BF"},
    {"name": "Burundi", "code": "+257", "short": "BI"},
    {"name": "Cambodia", "code": "+855", "short": "KH"},
    {"name": "Cameroon", "code": "+237", "short": "CM"},
    {"name": "Canada", "code": "+1", "short": "CA"},
    {"name": "Cape Verde", "code": "+238", "short": "CV"},
    {"name": "Central African Republic", "code": "+236", "short": "CF"},
    {"name": "Chad", "code": "+235", "short": "TD"},
    {"name": "Chile", "code": "+56", "short": "CL"},
    {"name": "China", "code": "+86", "short": "CN"},
    {"name": "Colombia", "code": "+57", "short": "CO"},
    {"name": "Comoros", "code": "+269", "short": "KM"},
    {"name": "Congo", "code": "+242", "short": "CG"},
    {"name": "Costa Rica", "code": "+506", "short": "CR"},
    {"name": "Croatia", "code": "+385", "short": "HR"},
    {"name": "Cuba", "code": "+53", "short": "CU"},
    {"name": "Cyprus", "code": "+357", "short": "CY"},
    {"name": "Czech Republic", "code": "+420", "short": "CZ"},
    {"name": "Denmark", "code": "+45", "short": "DK"},
    {"name": "Djibouti", "code": "+253", "short": "DJ"},
    {"name": "Dominica", "code": "+1-767", "short": "DM"},
    {"name": "Dominican Republic", "code": "+1-809", "short": "DO"},
    {"name": "Ecuador", "code": "+593", "short": "EC"},
    {"name": "Egypt", "code": "+20", "short": "EG"},
    {"name": "El Salvador", "code": "+503", "short": "SV"},
    {"name": "Equatorial Guinea", "code": "+240", "short": "GQ"},
    {"name": "Eritrea", "code": "+291", "short": "ER"},
    {"name": "Estonia", "code": "+372", "short": "EE"},
    {"name": "Eswatini", "code": "+268", "short": "SZ"},
    {"name": "Ethiopia", "code": "+251", "short": "ET"},
    {"name": "Fiji", "code": "+679", "short": "FJ"},
    {"name": "Finland", "code": "+358", "short": "FI"},
    {"name": "France", "code": "+33", "short": "FR"},
    {"name": "Gabon", "code": "+241", "short": "GA"},
    {"name": "Gambia", "code": "+220", "short": "GM"},
    {"name": "Georgia", "code": "+995", "short": "GE"},
    {"name": "Germany", "code": "+49", "short": "DE"},
    {"name": "Ghana", "code": "+233", "short": "GH"},
    {"name": "Greece", "code": "+30", "short": "GR"},
    {"name": "Grenada", "code": "+1-473", "short": "GD"},
    {"name": "Guatemala", "code": "+502", "short": "GT"},
    {"name": "Guinea", "code": "+224", "short": "GN"},
    {"name": "Guinea-Bissau", "code": "+245", "short": "GW"},
    {"name": "Guyana", "code": "+592", "short": "GY"},
    {"name": "Haiti", "code": "+509", "short": "HT"},
    {"name": "Honduras", "code": "+504", "short": "HN"},
    {"name": "Hungary", "code": "+36", "short": "HU"},
    {"name": "Iceland", "code": "+354", "short": "IS"},
    {"name": "India", "code": "+91", "short": "IN"},
    {"name": "Indonesia", "code": "+62", "short": "ID"},
    {"name": "Iran", "code": "+98", "short": "IR"},
    {"name": "Iraq", "code": "+964", "short": "IQ"},
    {"name": "Ireland", "code": "+353", "short": "IE"},
    {"name": "Israel", "code": "+972", "short": "IL"},
    {"name": "Italy", "code": "+39", "short": "IT"},
    {"name": "Jamaica", "code": "+1-876", "short": "JM"},
    {"name": "Japan", "code": "+81", "short": "JP"},
    {"name": "Jordan", "code": "+962", "short": "JO"},
    {"name": "Kazakhstan", "code": "+7", "short": "KZ"},
    {"name": "Kenya", "code": "+254", "short": "KE"},
    {"name": "Kiribati", "code": "+686", "short": "KI"},
    {"name": "Kuwait", "code": "+965", "short": "KW"},
    {"name": "Kyrgyzstan", "code": "+996", "short": "KG"},
    {"name": "Laos", "code": "+856", "short": "LA"},
    {"name": "Latvia", "code": "+371", "short": "LV"},
    {"name": "Lebanon", "code": "+961", "short": "LB"},
    {"name": "Lesotho", "code": "+266", "short": "LS"},
    {"name": "Liberia", "code": "+231", "short": "LR"},
    {"name": "Libya", "code": "+218", "short": "LY"},
    {"name": "Liechtenstein", "code": "+423", "short": "LI"},
    {"name": "Lithuania", "code": "+370", "short": "LT"},
    {"name": "Luxembourg", "code": "+352", "short": "LU"},
    {"name": "Madagascar", "code": "+261", "short": "MG"},
    {"name": "Malawi", "code": "+265", "short": "MW"},
    {"name": "Malaysia", "code": "+60", "short": "MY"},
    {"name": "Maldives", "code": "+960", "short": "MV"},
    {"name": "Mali", "code": "+223", "short": "ML"},
    {"name": "Malta", "code": "+356", "short": "MT"},
    {"name": "Marshall Islands", "code": "+692", "short": "MH"},
    {"name": "Mauritania", "code": "+222", "short": "MR"},
    {"name": "Mauritius", "code": "+230", "short": "MU"},
    {"name": "Mexico", "code": "+52", "short": "MX"},
    {"name": "Micronesia", "code": "+691", "short": "FM"},
    {"name": "Moldova", "code": "+373", "short": "MD"},
    {"name": "Monaco", "code": "+377", "short": "MC"},
    {"name": "Mongolia", "code": "+976", "short": "MN"},
    {"name": "Montenegro", "code": "+382", "short": "ME"},
    {"name": "Morocco", "code": "+212", "short": "MA"},
    {"name": "Mozambique", "code": "+258", "short": "MZ"},
    {"name": "Myanmar", "code": "+95", "short": "MM"},
    {"name": "Namibia", "code": "+264", "short": "NA"},
    {"name": "Nauru", "code": "+674", "short": "NR"},
    {"name": "Nepal", "code": "+977", "short": "NP"},
    {"name": "Netherlands", "code": "+31", "short": "NL"},
    {"name": "New Zealand", "code": "+64", "short": "NZ"},
    {"name": "Nicaragua", "code": "+505", "short": "NI"},
    {"name": "Niger", "code": "+227", "short": "NE"},
    {"name": "Nigeria", "code": "+234", "short": "NG"},
    {"name": "North Macedonia", "code": "+389", "short": "MK"},
    {"name": "Norway", "code": "+47", "short": "NO"},
    {"name": "Oman", "code": "+968", "short": "OM"},
    {"name": "Pakistan", "code": "+92", "short": "PK"},
    {"name": "Palau", "code": "+680", "short": "PW"},
    {"name": "Palestine", "code": "+970", "short": "PS"},
    {"name": "Panama", "code": "+507", "short": "PA"},
    {"name": "Papua New Guinea", "code": "+675", "short": "PG"},
    {"name": "Paraguay", "code": "+595", "short": "PY"},
    {"name": "Peru", "code": "+51", "short": "PE"},
    {"name": "Philippines", "code": "+63", "short": "PH"},
    {"name": "Poland", "code": "+48", "short": "PL"},
    {"name": "Portugal", "code": "+351", "short": "PT"},
    {"name": "Qatar", "code": "+974", "short": "QA"},
    {"name": "Romania", "code": "+40", "short": "RO"},
    {"name": "Russia", "code": "+7", "short": "RU"},
    {"name": "Rwanda", "code": "+250", "short": "RW"},
    {"name": "Saint Kitts and Nevis", "code": "+1-869", "short": "KN"},
    {"name": "Saint Lucia", "code": "+1-758", "short": "LC"},
    {"name": "Saint Vincent and the Grenadines", "code": "+1-784", "short": "VC"},
    {"name": "Samoa", "code": "+685", "short": "WS"},
    {"name": "San Marino", "code": "+378", "short": "SM"},
    {"name": "Sao Tome and Principe", "code": "+239", "short": "ST"},
    {"name": "Saudi Arabia", "code": "+966", "short": "SA"},
    {"name": "Senegal", "code": "+221", "short": "SN"},
    {"name": "Serbia", "code": "+381", "short": "RS"},
    {"name": "Seychelles", "code": "+248", "short": "SC"},
    {"name": "Sierra Leone", "code": "+232", "short": "SL"},
    {"name": "Singapore", "code": "+65", "short": "SG"},
    {"name": "Slovakia", "code": "+421", "short": "SK"},
    {"name": "Slovenia", "code": "+386", "short": "SI"},
    {"name": "Solomon Islands", "code": "+677", "short": "SB"},
    {"name": "Somalia", "code": "+252", "short": "SO"},
    {"name": "South Africa", "code": "+27", "short": "ZA"},
    {"name": "South Korea", "code": "+82", "short": "KR"},
    {"name": "South Sudan", "code": "+211", "short": "SS"},
    {"name": "Spain", "code": "+34", "short": "ES"},
    {"name": "Sri Lanka", "code": "+94", "short": "LK"},
    {"name": "Sudan", "code": "+249", "short": "SD"},
    {"name": "Suriname", "code": "+597", "short": "SR"},
    {"name": "Sweden", "code": "+46", "short": "SE"},
    {"name": "Switzerland", "code": "+41", "short": "CH"},
    {"name": "Syria", "code": "+963", "short": "SY"},
    {"name": "Taiwan", "code": "+886", "short": "TW"},
    {"name": "Tajikistan", "code": "+992", "short": "TJ"},
    {"name": "Tanzania", "code": "+255", "short": "TZ"},
    {"name": "Thailand", "code": "+66", "short": "TH"},
    {"name": "Togo", "code": "+228", "short": "TG"},
    {"name": "Tonga", "code": "+676", "short": "TO"},
    {"name": "Trinidad and Tobago", "code": "+1-868", "short": "TT"},
    {"name": "Tunisia", "code": "+216", "short": "TN"},
    {"name": "Turkey", "code": "+90", "short": "TR"},
    {"name": "Turkmenistan", "code": "+993", "short": "TM"},
    {"name": "Tuvalu", "code": "+688", "short": "TV"},
    {"name": "Uganda", "code": "+256", "short": "UG"},
    {"name": "Ukraine", "code": "+380", "short": "UA"},
    {"name": "United Arab Emirates", "code": "+971", "short": "AE"},
    {"name": "United Kingdom", "code": "+44", "short": "GB"},
    {"name": "United States", "code": "+1", "short": "US"},
    {"name": "Uruguay", "code": "+598", "short": "UY"},
    {"name": "Uzbekistan", "code": "+998", "short": "UZ"},
    {"name": "Vanuatu", "code": "+678", "short": "VU"},
    {"name": "Vatican City", "code": "+379", "short": "VA"},
    {"name": "Venezuela", "code": "+58", "short": "VE"},
    {"name": "Vietnam", "code": "+84", "short": "VN"},
    {"name": "Yemen", "code": "+967", "short": "YE"},
    {"name": "Zambia", "code": "+260", "short": "ZM"},
    {"name": "Zimbabwe", "code": "+263", "short": "ZW"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number Verification"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedCountryCode,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCountryCode = newValue!;
                    });
                  },
                  items: _countries.map<DropdownMenuItem<String>>((Map<String, String> country) {
                    return DropdownMenuItem<String>(
                      value: country["code"],
                      child: Text("${country['short']} (${country['code']})"),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Enter the phone number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () async {
              String fullPhoneNumber = _selectedCountryCode + _phoneNumberController.text.trim();
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: fullPhoneNumber,
                verificationCompleted: (PhoneAuthCredential credential) {
                  // This will automatically be called on successful verification
                },
                verificationFailed: (FirebaseAuthException exception) {
                  // Print or log the exception
                  //print("Verification failed: ${exception.message}");
                  // Optionally show an alert to the user
                },
                codeSent: (String verificationID, int? resendCode) {
                  // Navigate to the OTP screen with verificationID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(verificationId: verificationID),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (String verificationID) {
                  // Optionally handle auto-retrieval timeout
                },
              );
            },

            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }
}