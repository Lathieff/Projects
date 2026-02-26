import 'package:flutter/material.dart';
import 'dart:math';

class EnquiryCibil extends StatelessWidget {
  final Map<String, String> applicationData;
  final int cibilScore;

  const EnquiryCibil({
    super.key,
    required this.applicationData,
    this.cibilScore = 612, // Default score from screenshot
  });

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
        title: Text(
          'Enquiry',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 20 * scale,
            color: Colors.white,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20 * scale),
            // Header with Logo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Experian',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20 * scale,
                      color: const Color(0xFF003186),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      'Company Logo',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20 * scale),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
              child: Text(
                'Your Experian Credit Report Is Summarized In The Form Of Experian Credit Score Which Ranges From 300 - 900.',
                style: TextStyle(fontSize: 14 * scale, color: Colors.black87),
              ),
            ),
            SizedBox(height: 10 * scale),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
                child: Text(
                  'Credit Score',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * scale,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Gauge Score
            SizedBox(
              height: 400,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular background with border
                  Container(
                    width: 360,
                    height: 360,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFF5F5F5),
                        width: 40,
                      ),
                    ),
                  ),
                  CustomPaint(
                    size: const Size(360, 360),
                    painter: ScoreGaugePainter(score: cibilScore),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your Cibil Score',
                        style: TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$cibilScore',
                        style: const TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                        ),
                      ),
                      const Text(
                        'Excellent',
                        style: TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  // Labels positioned around the gauge - matching screenshot
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: const Text(
                        'Excellent',
                        style: TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 25,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: const Text(
                        'Low',
                        style: TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 30,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: const Text(
                        'Fair',
                        style: TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 30,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: const Text(
                        'Good',
                        style: TextStyle(
                          color: Color(0xFF003186),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.check, color: Colors.black, size: 16),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.blue,
                  size: 16,
                ), // Boxed arrow in screenshot
                SizedBox(width: 5),
                Text(
                  '+5 points from last check',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFA5F3C9), // Light Green
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                children: [
                  const Icon(Icons.celebration, color: Colors.green, size: 24),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Your Score is in the Excellent Range!',
                      style: TextStyle(
                        color: Color(0xFF006400),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Last Updated: 09 Oct 2025',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF003186),
              ),
            ),
            const SizedBox(height: 20),

            // Application Info Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: const Color(0xFF3B82F6),
              child: const Text(
                'CURRENT APPLICATION INFORMATION',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Info List
            _buildInfoRow(
              'Name - ${applicationData['Name'] ?? 'Akhil'}',
              isGrey: false,
            ),
            _buildInfoRow(
              'Mobile Number - ${applicationData['Mobile'] ?? '9876543210'}',
              isGrey: true,
            ),
            _buildInfoRow(
              'D.O.B - ${applicationData['DOB'] ?? '12-12-12'}',
              isGrey: false,
            ), // Placeholder logic if unused
            _buildInfoRow(
              '${applicationData['ID_Type'] ?? 'Aadhaar'} Number - ${applicationData['ID_Number'] ?? '9876543210'}',
              isGrey: true,
            ),
            if (applicationData.containsKey('PAN'))
              _buildInfoRow(
                'PAN Number - ${applicationData['PAN'] ?? '9876543210'}',
                isGrey: false,
              ),
            _buildInfoRow(
              'Address - ${applicationData['Address'] ?? 'Coimbatore'}',
              isGrey: true,
            ),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Powered by experian',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download, color: Colors.white),
                      label: const Text(
                        'Export PDF',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: Colors.black),
                      label: const Text(
                        'Share',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Score sourced from Experian - updated monthly',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00AA5B),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String text, {required bool isGrey}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isGrey ? const Color(0xFFF3F4F6) : Colors.white,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ScoreGaugePainter extends CustomPainter {
  final int score;
  final double minScore = 300;
  final double maxScore = 900;

  ScoreGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 20; // Padding
    const strokeWidth = 16.0;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Segments:
    // Usually Experian: 300-550 (Poor), 550-650 (Fair), 650-750 (Good), 750-900 (Excellent)
    // The gauge spans roughly 240 degrees (from 150 deg to 390 deg or something similar)
    // Or 270 degrees. Screenshot looks like a partial circle open at bottom.
    // Let's assume start angle = 135 degrees (3pi/4) and sweep = 270 degrees (3pi/2)

    // Screenshot has 4 distinct colors: Green, Orange-Red, Orange, Yellow (Actually Green->Red->Orange->Yellow is weird ordering)
    // The screenshot has: Green (Left Top), Red (Right Top), Orange (Right Bottom), Yellow (Left Bottom) ?
    // No, standard gauges usually go Left->Right: Red, Orange, Yellow, Green.
    // BUT the SCREENSHOT shows: "Excellent" (Top Left), "Low" (Top Right), "Fair" (Bot Right), "Good" (Bot Left).
    // This is a COUNTER-CLOCKWISE or specific layout?
    // Let's look closer at description: "Good" (Bot Left), "Excellent" (Top Left), "Low" (Top Right), "Fair" (Bot Right).
    // The colors are likely: Green (Excellent-TopLeft), Red (Low-TopRight), Orange (Fair-BotRight), Yellow (Good-BotLeft).
    // This implies a full circle with segments? No, screenshot usually open at bottom?
    // Actually, "Excellent" is at 10-11 o'clock. "Low" is at 1-2 o'clock.
    // This looks like a circle.
    // Let's draw 4 segments.
    // Segment 1 (Top Left - Excellent): Green
    // Segment 2 (Top Right - Low): Red
    // Segment 3 (Bottom Right - Fair): Orange
    // Segment 4 (Bottom Left - Good): Yellow

    // Angles (Clockwise from standard 0 at Right):
    // Top Right (Red): -90 to 0 ? No.
    // Let's use drawing logic. 0 is Right.
    // Low (Top Right): 270 to 360 (or -90 to 0)
    // Fair (Bot Right): 0 to 90
    // Good (Bot Left): 90 to 180
    // Excellent (Top Left): 180 to 270

    // Gaps between segments as in screenshot (white separators)

    double gap = 0.1; // radians gap

    // Top Left (Excellent) - Green Gradient
    paint.shader = const LinearGradient(
      colors: [Color(0xFF10B981), Color(0xFF34D399)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(rect);
    canvas.drawArc(rect, pi + gap, pi / 2 - 2 * gap, false, paint);

    // Top Right (Low) - Red Gradient
    paint.shader = const LinearGradient(
      colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ).createShader(rect);
    canvas.drawArc(rect, 1.5 * pi + gap, pi / 2 - 2 * gap, false, paint);

    // Bot Right (Fair) - Orange Gradient
    paint.shader = const LinearGradient(
      colors: [Color(0xFFEA580C), Color(0xFFFB923C)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(rect);
    canvas.drawArc(rect, 0 + gap, pi / 2 - 2 * gap, false, paint);

    // Bot Left (Good) - Yellow Gradient
    paint.shader = const LinearGradient(
      colors: [Color(0xFFCA8A04), Color(0xFFFBBF24)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ).createShader(rect);
    canvas.drawArc(rect, 0.5 * pi + gap, pi / 2 - 2 * gap, false, paint);

    // Draw Dot
    // We need to map score 300-900 to the angle.
    // BUT the segments are distinct categories.
    // And the ordering "Excellent, Low, Fair, Good" around the circle is non-linear/non-standard?
    // Wait, "Excellent" -> "Good" -> "Fair" -> "Low" is usually descending order.
    // If Excellent is Top-Left and Low is Top-Right...
    // Maybe it goes Counter-Clockwise from Top Left?
    // Excellent (300?) No.
    // Let's assume standard Logic: Score increases.
    // Where is 900? Excellent. Where is 300? Low.
    // IF Low is Top-Right and Excellent is Top-Left...
    // Maybe start is Top-Right (Low) -> Bot-Right (Fair) -> Bot-Left (Good) -> Top-Left (Excellent).
    // This is C-shape path?
    // Let's assume this path:
    // Low (300-500) -> Fair (500-650) -> Good (650-750) -> Excellent (750-900).
    // Angles:
    // Low (Top Right): 3*pi/2 (270) to 2*pi (360/0). Or -pi/2 to 0.
    // Fair: 0 to pi/2.
    // Good: pi/2 to pi.
    // Excellent: pi to 3*pi/2.

    // This matches the labels in the screenshot description!
    // Low (Top Right), Fair (Bot Right), Good (Bot Left), Excellent (Top Left).
    // So the path is CLOCKWISE starting from Top (270deg / -90deg).

    // Start Angle = -pi/2 (Top)
    // Sweep = 2*pi (Full Circle) check? visible gaps imply 4 quadrants.

    // Mapping 735:
    // Range 300-900 = 600 points span.
    // 735 is (735-300)/600 = 435/600 = 0.725 (72.5%) of the way.
    // Total angle = 2*pi (approx, minus gaps).
    // Angle = -pi/2 + (0.725 * 2*pi).
    // 0.725 * 360 = 261 degrees.
    // Start at -90. -90 + 261 = 171 degrees.
    // 171 deg is roughly Left Side (near 180).
    // Top Left quadrant is 180 to 270.
    // This puts it in "Good" (Bot Left, 90-180) or near Excellent?
    // Wait, Good is Bot Left (90-180). Excellent is Top Left (180-270).
    // 735 is High Good or Low Excellent.
    // Experian 735 might be "Good".
    // The screenshot says "735 Excellent".
    // Maybe ranges are different or my quadrant mapping is slightly off.
    // If 735 is Excellent, it should be in Top Left quadrant (180-270).
    // 171 is close to 180.

    // Let's stick to the visual quadrants:
    // Top Right: Low
    // Bot Right: Fair
    // Bot Left: Good
    // Bot Left -> Top Left: Excellent?
    // Actually, usually Cibil is 750+ Excellent.
    // 735 might be Good/Excellent boundary.
    // Visual placement of dot in screenshot?
    // "center circle... dot should move"
    // Screenshot has dot at Top Left (Green zone).

    // Dot drawing
    // Angle based on score.
    double normalizedScore =
        (score - minScore) / (maxScore - minScore); // 0.0 to 1.0
    // Total sweep is 2pi minus gaps?
    // Let's ignore gaps for angle calculation to simplify.
    double totalAngle = 2 * pi;
    double startAngle = -pi / 2; // Top

    double indicatorAngle = startAngle + (normalizedScore * totalAngle);

    final dotCenter = Offset(
      center.dx + radius * cos(indicatorAngle),
      center.dy + radius * sin(indicatorAngle),
    );

    // Determine dot color based on score zone
    Color dotColor;
    if (score >= 750) {
      dotColor = const Color(0xFF10B981); // Excellent - Green
    } else if (score >= 650) {
      dotColor = const Color(0xFFEAB308); // Good - Yellow
    } else if (score >= 500) {
      dotColor = const Color(0xFFF97316); // Fair - Orange
    } else {
      dotColor = const Color(0xFFEF4444); // Low - Red
    }

    // Draw White dot with Shadow/Border
    paint.style = PaintingStyle.fill;
    paint.shader = null;
    paint.color = Colors.white;
    // Shadow
    canvas.drawCircle(dotCenter, 16, paint..color = Colors.black26); // Shadow
    paint.color = Colors.white;
    canvas.drawCircle(dotCenter, 14, paint);

    // Dynamic colored border for dot based on score zone
    paint.style = PaintingStyle.stroke;
    paint.color = dotColor;
    paint.strokeWidth = 3;
    canvas.drawCircle(dotCenter, 14, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
