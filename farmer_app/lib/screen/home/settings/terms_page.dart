import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});
  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppBackground.mainGradient,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Terms of Service',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----- MAIN HEADING -----
                  const Text(
                    "Farm Equipment Rental",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "By using this platform, you agree to these terms. If not, please don't use the service.",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "The platform connects equipment owners with renters for agricultural equipment rentals.",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Users must be 18+ and are responsible for their account activity.",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 15),

                  // ----- RENTERS SECTION -----
                  const Text(
                    "Renters must:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  bulletPoint("Use equipment safely"),
                  bulletPoint("Return it in good condition"),
                  bulletPoint("Pay rental fees"),
                  bulletPoint("Hold required licenses"),
                  bulletPoint("Report damages immediately"),

                  const SizedBox(height: 15),

                  // ----- OWNERS SECTION -----
                  const Text(
                    "Owners must:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  bulletPoint("Provide accurate equipment details"),
                  bulletPoint("Ensure equipment is safe and working"),
                  bulletPoint("Respond within 24 hours"),
                  bulletPoint("Honor confirmed bookings"),

                  const SizedBox(height: 15),

                  // ----- FEES -----
                  const Text(
                    "Fees:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  bulletPoint("Renters: 5% service fee"),
                  bulletPoint("Owners: 10% service fee"),
                  bulletPoint("Payment processing fees may apply"),

                  const SizedBox(height: 15),

                  // ----- CANCELLATIONS -----
                  const Text(
                    "Cancellations:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  bulletPoint("24+ hrs before: Full refund (minus fee)"),
                  bulletPoint("12–24 hrs: 50% refund"),
                  bulletPoint("No-show: No refund"),
                  bulletPoint("Owner cancellation: Full refund to renter"),

                  const SizedBox(height: 15),

                  // ----- LIABILITY -----
                  const Text(
                    "Liability & Insurance:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  bulletPoint("Basic insurance included"),
                  bulletPoint(
                      "Platform not responsible for damage, injury, theft, or losses"),
                ],
              ),
            ),
          )),
    );
  }
}
