import 'package:flutter/material.dart';
import 'package:sales_erp/widgets/status_bar.dart';

class FieldAdvisorScreen extends StatelessWidget {
  const FieldAdvisorScreen({super.key});

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
                      padding: EdgeInsets.fromLTRB(20 * sw, 24 * sh, 20 * sw, 16 * sh),
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
                    _buildSlabCard(
                      '12 Months',
                      [_SlabChip('1-12 Months', '3%')],
                      sw,
                      sh,
                      sf,
                    ),
                    _buildSlabCard(
                      '24 Months',
                      [
                        _SlabChip('1-12 Months', '4%'),
                        _SlabChip('13-24 Months', '2%'),
                      ],
                      sw,
                      sh,
                      sf,
                    ),
                    _buildSlabCard(
                      '36 Months',
                      [
                        _SlabChip('1-12 Months', '5%'),
                        _SlabChip('13-24 Months', '2.5%'),
                        _SlabChip('25-36 Months', '1.25%'),
                      ],
                      sw,
                      sh,
                      sf,
                    ),
                    _buildSlabCard(
                      '48 Months',
                      [
                        _SlabChip('1-12 Months', '6%'),
                        _SlabChip('13-24 Months', '3%'),
                        _SlabChip('25-36 Months', '1.5%'),
                        _SlabChip('37-48 Months', '1%'),
                      ],
                      sw,
                      sh,
                      sf,
                    ),
                    _buildSlabCard(
                      '72 Months & Above',
                      [
                        _SlabChip('1-12 Months', '7%'),
                        _SlabChip('13-24 Months', '3.5%'),
                        _SlabChip('25-36 Months', '1.75%'),
                        _SlabChip('37-48 Months', '1.50%'),
                        _SlabChip('49+ Months', '0.50%'),
                      ],
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
    List<_SlabChip> chips,
    double sw,
    double sh,
    double sf,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * sw, vertical: 12 * sh),
      padding: EdgeInsets.all(20 * sw),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12 * sf),
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
                  height: 16 / 20,
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
                  fontSize: 12 * sf,
                  color: const Color(0xFF7F8C8D),
                  fontWeight: FontWeight.w500,
                  height: 16 / 12,
                ),
              ),
              SizedBox(width: 24 * sw),
              Text(
                'Commission (%)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12 * sf,
                  color: const Color(0xFF7F8C8D),
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * sh),
          Container(
            height: 1,
            color: const Color(0xFFE0E0E0),
            width: double.infinity,
          ),
          SizedBox(height: 16 * sh),
          Wrap(
            spacing: 12 * sw,
            runSpacing: 12 * sh,
            children: chips.map((chip) => _buildChip(chip, sw, sh, sf)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(_SlabChip chip, double sw, double sh, double sf) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * sw, vertical: 8 * sh),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F6),
        border: Border.all(color: _teal.withOpacity(0.8), width: 1.2),
        borderRadius: BorderRadius.circular(100 * sf),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chip.period,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14 * sf,
              fontWeight: FontWeight.w900,
              color: _teal,
              height: 16 / 12,
            ),
          ),
          SizedBox(width: 10 * sw),
          Text(
            chip.percentage,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14 * sf,
              fontWeight: FontWeight.w900,
              color: _teal,
              height: 16 / 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlabChip {
  final String period;
  final String percentage;
  _SlabChip(this.period, this.percentage);
}
