import 'package:flutter/material.dart';
import 'terms_conditions.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final List<int> _expandedFaqs = [];

  final List<Map<String, String>> faqs = [
    {'q': 'How long does it take to service vehicle?'},
    {'q': 'How long does it take to service vehicle?'},
    {'q': 'How long does it take to service vehicle?'},
    {'q': 'How long does it take to service vehicle?'},
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final w = media.width;
    final h = media.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Booking Summary'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0D4D3A),
        elevation: 1,
      ),
        body: Column(
          children: [

            /// 🔹 Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner
                    Container(
                      width: double.infinity,
                      height: h * 0.25,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/sevice_image2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.025),

                    const Text(
                      'Service Booking Confirmed',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF4CAF50),
                      ),
                    ),

                    SizedBox(height: h * 0.005),

                    const Text(
                      'Our executive will contact you shortly.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A148C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: h * 0.025),

                    _buildSummaryCard(),

                    SizedBox(height: h * 0.02),

                    /// Terms & Conditions Button
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TermsConditionsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: w * 0.04),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE57373).withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Terms & Conditions For Service Vehicle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.025),

                    _buildFAQ(),

                    SizedBox(height: h * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildSummaryCard() {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04),
      padding: EdgeInsets.all(w * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow('🚗', 'Vehicle', 'Hyundai Creta (Petrol)'),
          _buildDetailRow(
            '🔧',
            'Services Selected',
            'General Service, AC Repair',
          ),
          _buildDetailRow('📍', 'Pickup', '123, Main Road, Chennai'),
          _buildDetailRow('🗓️', 'Scheduled', 'Aug 3, 2025 | 10:00 AM'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$label : ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ() {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(w * 0.04, 4, w * 0.04, w * 0.04),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          ...List.generate(
            faqs.length,
            (index) => _buildFAQTile(index + 1, faqs[index]['q']!),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQTile(int number, String question) {
    bool isExpanded = _expandedFaqs.contains(number);

    return InkWell(
      onTap: () {
        setState(() {
          isExpanded ? _expandedFaqs.remove(number) : _expandedFaqs.add(number);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$number. $question',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
            if (isExpanded)
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 24),
                child: Text(
                  'Typically, a standard service takes 4-6 hours.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


