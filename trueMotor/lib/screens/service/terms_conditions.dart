import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final w = media.width;
    final h = media.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0D4D3A),
        elevation: 1,
      ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Booking – Terms & Conditions',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: h * 0.015),
                    const Text(
                      'Thank you for booking your vehicle service with TrueMotors. Please read and acknowledge the following terms:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: h * 0.025),

                    _buildTermSection('1. Booking Confirmation', [
                      'Your booking is confirmed based on the details provided.',
                      'Changes in booking (reschedule/cancellation) can be done up to 2 hours before your scheduled time.',
                    ]),
                    _buildTermSection('2. Vehicle Pickup & Drop', [
                      'Ensure your vehicle is ready at the pickup time and location if you have chosen home pickup & drop.',
                      'Remove all valuables from the vehicle before handing it over to our service partner.',
                    ]),
                    _buildTermSection('3. Service Scope', [
                      'The final service charges may vary based on actual inspection and service requirements.',
                      'Only genuine parts or manufacturer-approved alternatives will be used for replacements.',
                    ]),
                    _buildTermSection('4. Payments', [
                      'Full payment must be completed before the vehicle is released post-service.',
                      'Any additional services or part replacements will be informed and charged separately.',
                    ]),
                    _buildTermSection('5. Liability', [
                      'TrueMotors is not responsible for pre-existing damages or mechanical failures unrelated to the service performed.',
                      'Warranty on parts and service is as per the manufacturer\'s or service partner\'s policy.',
                    ]),
                    _buildTermSection('6. Cancellation Policy', [
                      'Cancellations within 2 hours of scheduled time may attract cancellation charges as per our policy.',
                    ]),
                    _buildTermSection('7. Disputes', [
                      'For any concerns or disputes regarding your service, please contact our support team for resolution.',
                    ]),
                    SizedBox(height: h * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildTermSection(String title, List<String> bullets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ...bullets.map(
            (bullet) => Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16, height: 1.4)),
                  Expanded(
                    child: Text(
                      bullet,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


