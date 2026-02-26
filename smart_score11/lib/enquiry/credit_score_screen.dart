import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '/app_image.dart';
import '../../../widgets/custom_bottom_nav.dart';


Future<void> generateAndOpenPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Smart Score Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),

              pw.Text('Agent ID : S11522'),
              pw.Text('Credit Score : 720'),
              pw.Text('Status : Verified'),
              pw.Text('Date : ${DateTime.now()}'),

              pw.SizedBox(height: 24),

              pw.Text(
                'This is a generated Smart Score report PDF.',
                style: const pw.TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    ),
  );

  // 🔹 Convert to bytes
  final Uint8List bytes = await pdf.save();

  // 🔹 Get device directory
  final Directory dir = await getApplicationDocumentsDirectory();

  // 🔹 Create file path
  final String filePath =
      '${dir.path}/Smart_Score_Report_${DateTime.now().millisecondsSinceEpoch}.pdf';

  // 🔹 Save file
  final File file = File(filePath);
  await file.writeAsBytes(bytes);

  // 🔹 Open / Preview / Share
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => bytes,
  );

  // 🔹 Optional: log path
  debugPrint('PDF saved at: $filePath');
}


class CreditScoreResultScreen extends StatelessWidget {
  const CreditScoreResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final bool isSmallScreen = width < 600;
    final bool isMediumScreen = width >= 600 && width < 900;

    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 AppBar
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white),
        title: Text(
          'Enquiry',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 18 : 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        toolbarHeight: isSmallScreen ? 56 : 64,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header with logo
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImage.experience,
                    height: isSmallScreen
                        ? 34
                        : isMediumScreen
                        ? 38
                        : 42,
                    fit: BoxFit.contain,
                  ),

                  // 🔹 UPDATED: Company Logo Container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Gray background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      border: Border.all(
                        color: Colors.grey.shade400, // Light gray border
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 25 : 30,
                      vertical: isSmallScreen ? 9 : 11,
                    ),
                    child: Text(
                      'Company Logo',
                      style: TextStyle(
                        color: Colors.black, // Black text color
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
              ),
              child: Text(
                'Your Experian Credit Report Is Summarized In The \n Form Of '
                'Experian Credit Score Which Ranges From \n 300 - 900.',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 16 : 20),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
              ),
              child: Text(
                'Credit Score',
                style: TextStyle(
                  color: const Color(0xff2672F5),
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 16 : 20),

            // 🔹 Circular Score Indicator (UI replica)
            Center(
              child: Image.asset(
                AppImage.score,
                width: isSmallScreen
                    ? width * 0.9
                    : isMediumScreen
                    ? width * 0.8
                    : width * 0.8,
                height: isSmallScreen
                    ? width * 0.9
                    : isMediumScreen
                    ? width * 0.8
                    : width * 0.9,
                fit: BoxFit.contain,
              ),
            ),

            // 🔹 NEW: Added "✔️ ⬆ +5 points from last check" text below score image
            SizedBox(height: isSmallScreen ? 8 : 10),
            Center(
              child: Text(
                '✔️ ⬆ +5 points from last check',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff00AA5B),
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 16 : 20),

            // 🔹 Status banner
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  color: const Color(0xffD9FBE8), // Background color
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xff00AA5B), // Border color #00AA5B
                    width: 2, // You can adjust border width (1, 2, or 3)
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImage.pop,
                      width: isSmallScreen ? 24 : 28,
                      height: isSmallScreen ? 24 : 28,
                    ),
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    Expanded(
                      child: Text(
                        'Your Score is in the Excellent Range!',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 12 : 14),

            Center(
              child: Text(
                'Last Updated: 09 Oct 2025',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 17,
                  color: Color(0xff09004E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 18 : 22),

            // 🔹 Application info - FULL WIDTH (NO HORIZONTAL PADDING)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              color: const Color(0xff2672F5),
              child: Text(
                'CURRENT APPLICATION INFORMATION',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ),

            // 🔹 Info rows - FULL WIDTH (NO HORIZONTAL PADDING)
            _infoRow('Name', 'Akhil', isSmallScreen, 0),
            _infoRow('Mobile Number', '9876543210', isSmallScreen, 1),
            _infoRow('D.O.B', '12-12-12', isSmallScreen, 2),
            _infoRow('Aadhaar Number', '9876543210', isSmallScreen, 3),
            _infoRow('PAN Number', 'ABCDE1234F', isSmallScreen, 4),
            _infoRow('Address', 'Coimbatore', isSmallScreen, 5),

            SizedBox(height: isSmallScreen ? 8 : 12),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
              ),
              child: Text(
                'Powered by experian',
                style: TextStyle(
                  color: Color(0xff9E0000),
                  fontSize: isSmallScreen ? 12 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 20 : 24),

            // 🔹 Buttons - Responsive layout - FIXED VERSION
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 24,
              ),
              child: isSmallScreen
                  ? // Row buttons for small screens
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await generateAndOpenPdf();
                            },
                            icon: Icon(
                              Icons.picture_as_pdf,
                              size: isSmallScreen ? 18 : 20,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Export PDF',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2E6CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 14,
                              ),
                              minimumSize: const Size(0, 48),
                            ),
                          ),
                        ),

                        SizedBox(width: isSmallScreen ? 10 : 14),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Share.share(
                                'Smart Score Report\n\n'
                                'Agent ID: S11522\n'
                                'Credit Score: 720\n'
                                'Check more details in the Smart Score app.',
                              );
                            },

                            icon: Icon(
                              Icons.share,
                              size: isSmallScreen ? 18 : 20,
                            ),
                            label: Text(
                              'Share',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: const BorderSide(
                                color: Color(0xFF2E6CFF),
                              ),
                              minimumSize: const Size(0, 48),
                            ),
                          ),
                        ),
                      ],
                    )
                  : // Side by side buttons for larger screens
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.picture_as_pdf,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Export PDF',
                              style: TextStyle(
                                fontSize: isMediumScreen ? 14 : 16,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2E6CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: isMediumScreen ? 14 : 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: isMediumScreen ? 12 : 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.share, size: 20),
                            label: Text(
                              'Share',
                              style: TextStyle(
                                fontSize: isMediumScreen ? 14 : 16,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: isMediumScreen ? 14 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: const BorderSide(
                                color: Color(0xFF2E6CFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16, // 👈 left & right gap
              ),
              decoration: BoxDecoration(
                color: const Color(0xffE8E8E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 16,
                    vertical: 10,
                  ),
                  child: Text(
                    'Score sourced from Experian — updated monthly',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: const Color(0xff2672F5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNav(currentIndex: 1),
    );
  }

  // 🔹 Info row widget with responsive styling - FULL WIDTH
  static Widget _infoRow(
    String label,
    String value,
    bool isSmallScreen,
    int index,
  ) {
    final bool isEvenRow = index % 2 == 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: isSmallScreen ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: isEvenRow ? Colors.white : const Color(0xFFF2F2F2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label - $value',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}


