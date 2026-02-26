import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'localName': 'English', 'code': 'en', 'iconChar': 'A'},
    {'name': 'Tamil', 'localName': 'தமிழ்', 'code': 'ta', 'iconChar': 'த'},
    {'name': 'Hindi', 'localName': 'हिंदी', 'code': 'hi', 'iconChar': 'आ'},
    {'name': 'Telugu', 'localName': 'తెలుగు', 'code': 'te', 'iconChar': 'తె'},
    {'name': 'Malayalam', 'localName': 'മലയാളം', 'code': 'ml', 'iconChar': 'മ'},
    {'name': 'Kannada', 'localName': 'ಕನ್ನಡ', 'code': 'kn', 'iconChar': 'ಕ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Language',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor:
            Colors.transparent, // Transparent to show gradient container
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Smooth gradient with more white at top
            stops: [0.3, 1.0],
            colors: [Color(0xFFFFFFFF), Color(0xFFA3D0F5)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100, // Space for AppBar
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Use Image.asset as requested, with fallback to Icon
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  'assets/images/lang.png',
                  height: 100, // Adjusted size based on design
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/images/lang.png'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Smartscore supports multiple languages to enhance your experience. Please select your preferred language to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 0),
              // Language List containing Expanded to take available space
              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _languages.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    return RadioListTile<String>(
                      value: language['name']!,
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                      activeColor: const Color(0xFF4134CA),
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          Container(
                            width: 50, // Slightly larger avatar
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFEAECF9,
                              ), // Avatar background white
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              language['iconChar']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language['localName']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                language['name']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}