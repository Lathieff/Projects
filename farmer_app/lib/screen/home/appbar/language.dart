import 'package:farmer_app/main.dart';
import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';
// Import MyApp to access setLocale

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // Logic to get the current locale would ideally come from a provider or inherited widget,
  // but based on main.dart, we'll maintain local state for selection and update global state on change.
  // Defaulting to English for initial state or we could read from MyApp if we had a way.
  // For now, I'll initialize with English.
  Locale _selectedLocale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    // Determine the current locale from context if possible, otherwise use local state
    // In this simple app structure, we rely on the user selection.

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Language",
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppBackground.mainGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Header Image
              Image.asset(
                "assets/language_header.png",
                height: 150,
              ),

              const SizedBox(height: 30),

              const Text(
                "Select Language",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Smartscore supports multiple languages to enhance your experience. Please select your preferred language to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Language Options
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildLanguageTile(
                      context: context,
                      locale: const Locale('en'),
                      name: "English",
                      nativeName: "English",
                      iconPath: "assets/lang_english.png",
                      groupValue: _selectedLocale,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLocale = value;
                          });
                          MyApp.setLocale(context, value);
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildLanguageTile(
                      context: context,
                      locale: const Locale('ta'),
                      name: "தமிழ்",
                      nativeName: "Tamil",
                      iconPath: "assets/lang_tamil.png",
                      groupValue: _selectedLocale,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLocale = value;
                          });
                          MyApp.setLocale(context, value);
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildLanguageTile(
                      context: context,
                      locale: const Locale('hi'),
                      name: "हिंदी",
                      nativeName: "Hindi",
                      iconPath: "assets/lang_hindi.png",
                      groupValue: _selectedLocale,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLocale = value;
                          });
                          MyApp.setLocale(context, value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required Locale locale,
    required String name,
    required String nativeName,
    required String iconPath,
    required Locale groupValue,
    required ValueChanged<Locale?> onChanged,
  }) {
    bool isSelected = groupValue == locale;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(
            50), // This will be updated after viewing the file.
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : Colors.transparent, // Border handled by shape or clean look
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            onChanged(locale);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              children: [
                // Icon
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(iconPath),
                ),

                const SizedBox(width: 20),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        nativeName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Radio Button
                Radio<Locale>(
                  value: locale,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  activeColor:
                      const Color(0xFF2E7D32), // Green color for selection
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
