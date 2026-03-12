import 'package:flutter/material.dart';
import 'package:sales_erp/widgets/status_bar.dart';

class FieldAdvisorScreen2 extends StatelessWidget {
  const FieldAdvisorScreen2({super.key});

  static const _teal = Color(0xFF1F6F66);
  static const _cardBg = Color(0xFFF4F7F6);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);

    return StatusBarWrapper(
      statusBarColor: _teal,
      iconBrightness: Brightness.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStatusBar(
              backgroundColor: _teal,
              iconBrightness: Brightness.light,
            ),
            Container(
              height: 64 * sh,
              color: _teal,
              padding: EdgeInsets.symmetric(horizontal: 8 * sw),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.white, size: 32 * sf),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Field Advisor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23 * sf,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        20 * sw,
                        24 * sh,
                        20 * sw,
                        16 * sh,
                      ),
                      child: Text(
                        'You earn commission based on plan duration and contribution slabs.',
                        style: TextStyle(
                          fontSize: 13 * sf,
                          color: Colors.black87,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    _buildSlabCard('12 Months', '12 Months', '2.5%', sw, sh, sf),
                    _buildSlabCard('12 Months', '24 Months', '3%', sw, sh, sf),
                    _buildSlabCard('36 Months', '36 Months', '3.5%', sw, sh, sf),
                    _buildSlabCard('48 Months', '48 Months', '5%', sw, sh, sf),
                    _buildSlabCard(
                      '60 Months & Above',
                      '60 Months',
                      '6.5%',
                      sw,
                      sh,
                      sf,
                    ),
                    SizedBox(height: 32 * sh),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlabCard(
    String title,
    String period,
    String percentage,
    double sw,
    double sh,
    double sf,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * sw, vertical: 12 * sh),
      padding: EdgeInsets.all(20 * sw),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16 * sf),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/commision_module/calendar.png',
                width: 24 * sf,
                height: 24 * sf,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.calendar_month, color: _teal, size: 24 * sf),
              ),
              SizedBox(width: 10 * sw),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20 * sf,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF232323),
                  height: 1.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * sh),
          Row(
            children: [
              Text(
                'Contribution Period',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11 * sf,
                  color: const Color(0xFF95A5A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 20 * sw),
              Text(
                'Commission (%)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11 * sf,
                  color: const Color(0xFF95A5A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * sh),
          Container(height: 1, color: const Color(0xFFE0E0E0)),
          SizedBox(height: 16 * sh),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * sw, vertical: 8 * sh),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7F6),
              border: Border.all(color: _teal.withOpacity(0.5), width: 1),
              borderRadius: BorderRadius.circular(100 * sf),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  period,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14 * sf,
                    fontWeight: FontWeight.w900,
                    color: _teal,
                  ),
                ),
                SizedBox(width: 8 * sw),
                Text(
                  percentage,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14 * sf,
                    fontWeight: FontWeight.w900,
                    color: _teal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16 * sh),
          Container(height: 1, color: const Color(0xFFE0E0E0)),
          SizedBox(height: 16 * sh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'G6 - Pension Benifits',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16 * sf,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5D6D7E),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * sw,
                  vertical: 6 * sh,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5B55A).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(100 * sf),
                ),
                child: Text(
                  '10%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14 * sf,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
