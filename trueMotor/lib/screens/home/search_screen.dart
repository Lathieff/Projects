import 'dart:async';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const Color tealColor = Color(0xFF2A7C76);

  // ── Animated placeholder words ──────────────────────────────────
  final List<String> _placeholderWords = [
    '"Price"',
    '"Brand"',
    '"Model"',
    '"Year"',
    '"Body Type"',
    '"Kms Driven"',
    '"Owner Count"',
    '"Transmission"',
    '"Fuel Type"',
  ];
  int _placeholderIndex = 0;
  Timer? _placeholderTimer;

  final List<String> _recentSearches = [
    'Car', 'Bike', 'KIA', 'Honda', 'EV Car'
  ];
  final List<String> _trendingSearches = [
    'EV Car', 'Test Drive', 'KIA', 'BIKE'
  ];

  @override
  void initState() {
    super.initState();
    _startPlaceholderTimer();
  }

  // ✅ Timer every 2 sec → next placeholder word
  void _startPlaceholderTimer() {
    _placeholderTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (mounted) {
        setState(() {
          _placeholderIndex =
              (_placeholderIndex + 1) % _placeholderWords.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _placeholderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App Bar ────────────────────────────────────────
              Container(
                color: const Color(0x0ffbf8f8),
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04,
                  vertical: sw * 0.04,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: tealColor,
                        size: sw * 0.06,
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Text(
                      'Search',
                      style: TextStyle(
                        fontSize: sw * 0.055,
                        fontWeight: FontWeight.w600,
                        color: tealColor,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Body ───────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.05,
                    vertical: sh * 0.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Search Bar ─────────────────────────────
                      Container(
                        height: sh * 0.065,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(sw * 0.05),
                          border: Border.all(color: tealColor, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: sw * 0.04),
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                              size: sw * 0.06,
                            ),
                            SizedBox(width: sw * 0.02),

                            // Static hint
                            Text(
                              'Search  Cars by  ',
                              style: TextStyle(
                                fontSize: sw * 0.038,
                                color: Colors.grey.shade500,
                              ),
                            ),

                            // ✅ Animated cycling placeholder
                            ClipRect(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: (child, animation) {
                                  final inAnim = Tween<Offset>(
                                    begin: const Offset(0, -1.0),
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  ));
                                  final outAnim = Tween<Offset>(
                                    begin: Offset.zero,
                                    end: const Offset(0, 1.0),
                                  ).animate(CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeIn,
                                  ));
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: child.key ==
                                          ValueKey<int>(_placeholderIndex)
                                          ? inAnim
                                          : outAnim,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Text(
                                  _placeholderWords[_placeholderIndex],
                                  key: ValueKey<int>(_placeholderIndex),
                                  style: TextStyle(
                                    fontSize: sw * 0.038,
                                    color: tealColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: sh * 0.028),

                      // ── Recent Searches ─────────────────────────
                      Text(
                        'Recent Searches',
                        style: TextStyle(
                          fontSize: sw * 0.042,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: sh * 0.012),

                      // ✅ Compact chips
                      Wrap(
                        spacing: sw * 0.025,
                        runSpacing: sh * 0.008,
                        children: _recentSearches
                            .map((tag) => _SearchChip(
                          label: tag,
                          sw: sw,
                          tealColor: tealColor,
                        ))
                            .toList(),
                      ),

                      SizedBox(height: sh * 0.022),

                      const Divider(color: Color(0xFFDDDDDD), thickness: 1),

                      SizedBox(height: sh * 0.022),

                      // ── Trending Searches ───────────────────────
                      Text(
                        'Trending Searches',
                        style: TextStyle(
                          fontSize: sw * 0.042,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: sh * 0.012),

                      // ✅ Compact chips
                      Wrap(
                        spacing: sw * 0.025,
                        runSpacing: sh * 0.008,
                        children: _trendingSearches
                            .map((tag) => _SearchChip(
                          label: tag,
                          sw: sw,
                          tealColor: tealColor,
                        ))
                            .toList(),
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

// ─── Compact Search Chip ──────────────────────────────────────────────────────
class _SearchChip extends StatelessWidget {
  final String label;
  final double sw;
  final Color tealColor;

  const _SearchChip({
    required this.label,
    required this.sw,
    required this.tealColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: handle chip tap
      },
        child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sw * 0.03,
          vertical: sw * 0.015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(sw * 0.08),
          border: Border.all(color: tealColor, width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: sw * 0.033,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: sw * 0.015),
            Icon(
              Icons.trending_up,
              size: sw * 0.038,
              color: Colors.black87,
            ),
          ],
        ),
      ),
      );
  }
}

