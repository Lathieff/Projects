import 'package:flutter/material.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool _is2FAEnabled = false;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70 * scale,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          'Two Factor Authentications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20 * scale,
            fontFamily: 'Nunito',
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20 * scale),
            Center(
              child: Container(
                padding: EdgeInsets.all(10* scale),
                decoration: const BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icon/Frame.png',
                  width: 40 * scale,
                  height: 40 * scale,
                ),
              ),
            ),
            SizedBox(height: 25 * scale),
            Text(
              'Secure Your Account',
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 10 * scale),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40 * scale),
              child: Text(
                'Add an extra layer of security to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey[600],
                  fontFamily: 'Nunito',
                ),
              ),
            ),
            SizedBox(height: 35 * scale),
            // Toggle Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * scale),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * scale,
                  vertical: 4 * scale,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enable 2FA',
                      style: TextStyle(
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Switch(
                      value: _is2FAEnabled,
                      onChanged: (value) {
                        setState(() {
                          _is2FAEnabled = value;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF2196F3),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
