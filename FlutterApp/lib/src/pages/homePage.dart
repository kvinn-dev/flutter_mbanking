import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:flutter_wallet_app/src/widgets/bottom_navigation_bar.dart';
import 'package:flutter_wallet_app/src/widgets/top_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import '../providers/wallet_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _pageController1 = PageController();

  Timer? _autoSlideTimer;

  late PageController _bannerController;
  int _currentBanner = 0;

  final List<String> _banners = [
    "Banner 1",
    "Banner 2",
    "Banner 3",
    "Banner 4",
    "Banner 5",
  ];

// Buat virtual list (3x panjang asli)
  List<String> get _loopedBanners =>
      List<String>.from(_banners + _banners + _banners);

  @override
  void initState() {
    super.initState();

    _bannerController = PageController(
      initialPage: _banners.length, // start di tengah list virtual
      viewportFraction: 0.92,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();

    _autoSlideTimer = Timer.periodic(
      const Duration(seconds: 8),
      (timer) async {
        if (!mounted || !_bannerController.hasClients) return;

        int nextPage = _bannerController.page!.toInt() + 1;

        await _bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  // =======================
  // HEADER CARD UTAMA
  // =======================
  Widget _mainHeaderCard() {
    // Watch wallet state for real data
    final walletState = ref.watch(walletProvider);
    
    // Formatting helper
    // Assuming balance is double, basic formatting:
    final balanceString = walletState.balance.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ===============================
          /// SECTION ATAS (GRADIENT)
          /// ===============================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 84, 152, 231),
                  Color(0xFF26A69A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// BCA ID PILL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.credit_card,
                          size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        "BCA ID",
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios,
                          size: 10, color: Colors.white),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                /// ACCOUNT NUMBER
                Row(
                  children: [
                    Text(
                      "Account: ${walletState.accountNumber}",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.copy, size: 13, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),

          /// ===============================
          /// SECTION BAWAH (PUTIH)
          /// ===============================
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Active Balance",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                          ])
                    ]),

                const SizedBox(height: 3),

                /// ACTIVE BALANCE + EYE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IDR $balanceString",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.visibility_off_outlined,
                        color: const Color.fromARGB(255, 5, 87, 168),
                        size: 20,
                      ),
                    )
                  ],
                ),

                /// DIVIDER
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),

                /// ACCOUNT TRANSACTIONS
                Row(
                  children: [
                    const Icon(Icons.receipt_long,
                        size: 18, color: const Color.fromARGB(255, 5, 87, 168)),
                    const SizedBox(width: 5),
                    Text(
                      "Account Transactions",
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 5, 87, 168)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D47A1),
              Color(0xFF26A69A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT TEXT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "The New",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Gebyar Hadiah BCA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            /// RIGHT CTA
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                SizedBox(height: 8), // geser turun supaya sejajar
                Row(
                  children: [
                    Text(
                      "Click to Win",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.chevron_right, color: Colors.white, size: 18),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainMenu() {
    final List<Map<String, dynamic>> menuItems = [
      {"icon": Icons.swap_horiz, "label": "Transfer", "route": "/transfer"},
      {
        "icon": Icons.phone_android,
        "label": "Payment &\nTop Up",
        "route": "/payment"
      },
      {
        "icon": Icons.trending_up,
        "label": "Investment",
        "route": "/investment"
      },
      {"icon": Icons.shopping_bag, "label": "Lifestyle", "route": "/lifestyle"},
      {"icon": Icons.store, "label": "e-Store", "route": "/estore"},
      {"icon": Icons.qr_code, "label": "Flazz", "route": "/flazz"},
      {"icon": Icons.credit_card, "label": "Cardless", "route": "/cardless"},
      {
        "icon": Icons.account_balance,
        "label": "Bank\nProducts",
        "route": "/bank"
      },
      {"icon": Icons.security, "label": "Protection", "route": "/protection"},
      {"icon": Icons.savings, "label": "Savings", "route": "/savings"},
      {"icon": Icons.request_page, "label": "Bills", "route": "/bills"},
      {"icon": Icons.card_giftcard, "label": "Rewards", "route": "/rewards"},
      {"icon": Icons.support_agent, "label": "Support", "route": "/support"},
      {"icon": Icons.more_horiz, "label": "All", "route": "/all"},
    ];

    int itemsPerPage = 8;
    int totalPages = (menuItems.length / itemsPerPage).ceil();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 249, 251, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Main Menu",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: LightColor.bcaDarkBlue,
                ),
              ),
              Text(
                "Edit",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 5, 87, 168),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// PAGEVIEW GRID
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController1,
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              padEnds: false,
              itemCount: totalPages,
              itemBuilder: (context, pageIndex) {
                final startIndex = pageIndex * itemsPerPage;
                final endIndex =
                    (startIndex + itemsPerPage).clamp(0, menuItems.length);

                final pageItems = menuItems.sublist(startIndex, endIndex);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 6),
                  itemCount: pageItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final item = pageItems[index];

                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (item["route"] != null) {
                          Navigator.pushNamed(context, item["route"]);
                        }
                      },
                      child: _buildMenuItem(
                        item["icon"],
                        item["label"],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SmoothPageIndicator(
              controller: _pageController1,
              count: totalPages,
              effect: ExpandingDotsEffect(
                dotHeight: 5,
                dotWidth: 10,
                activeDotColor: const Color.fromARGB(255, 5, 87, 168),
                dotColor: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.rotate(
          angle: 0.785398,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 66, 149, 233).withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Transform.rotate(
              angle: -0.785398,
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 5, 87, 168),
                size: 24,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// AREA TEXT FIX HEIGHT
        SizedBox(
          height: 32,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _bannerSlider() {
    return Column(
      children: [
        SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _bannerController,
              itemCount: _loopedBanners.length,
              onPageChanged: (index) {
                int realIndex = index % _banners.length;
                setState(() {
                  _currentBanner = realIndex;
                });

                if (index == 0) {
                  _bannerController.jumpToPage(_banners.length);
                } else if (index == _loopedBanners.length - 1) {
                  _bannerController.jumpToPage(_banners.length * 2 - 1);
                }
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _loopedBanners[index],
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
        const SizedBox(height: 20),
        AnimatedSmoothIndicator(
          activeIndex: _currentBanner,
          count: _banners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 8,
            activeDotColor: const Color.fromARGB(255, 5, 87, 168),
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  // =======================
  // TRANSACTIONS
  // =======================
  Widget _transectionList() {
    return Column(
      children: [
        _buildTransactionItem(
          "The New Gcbwal",
          "Thadiah BCA",
          "150.000",
          Icons.shopping_bag,
          isCredit: false,
        ),
        const SizedBox(height: 8),
        _buildTransactionItem(
          "Transfer",
          "KEVIN YULIAN PAMUNGKAS",
          "500.000",
          Icons.swap_horiz,
          isCredit: true,
        ),
        const SizedBox(height: 8),
        _buildTransactionItem(
          "Flazz Top Up",
          "17 Feb 2026",
          "200.000",
          Icons.qr_code,
          isCredit: false,
        ),
        const SizedBox(height: 8),
        _buildTransactionItem(
          "Payment",
          "PLN Postpaid",
          "250.000",
          Icons.bolt,
          isCredit: false,
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
      String title, String subtitle, String amount, IconData icon,
      {bool isCredit = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 66, 149, 233).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 5, 87, 168),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: LightColor.bcaDarkBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isCredit ? '+Rp$amount' : '-Rp$amount',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isCredit
                      ? const Color.fromARGB(255, 59, 137, 68)
                      : const Color.fromARGB(255, 220, 41, 41),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =======================
  // BUILD
  // =======================
  @override
  Widget build(BuildContext context) {
    // Watch wallet provider (which contains name)
    final walletState = ref.watch(walletProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 249, 251, 255),
      bottomNavigationBar: BottomNavigation(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// SLIVER APPBAR UNTUK NAV TOP
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 7, 73, 139),
            automaticallyImplyLeading: false,
            toolbarHeight: 35,
            collapsedHeight: 35,
            flexibleSpace: Container(
              color: const Color.fromARGB(255, 7, 73, 139),
              child: SafeArea(
                bottom: false,
                child: const TopNav(),
              ),
            ),
          ),

          /// ================= HEADER SECTION =================
          SliverToBoxAdapter(
            child: Column(
              children: [
                /// ===== BACKGROUND BIRU DENGAN PROMO =====
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 7, 73, 139),
                        Color.fromARGB(255, 6, 52, 95),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "HELLO, ",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: walletState.name.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _mainHeaderCard(),
                      ),
                      const SizedBox(height: 30),
                      _promoBanner(),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),

                // ===== MAIN MENU FULL WIDTH =====
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Column(
                    children: [
                      _mainMenu(),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _bannerSlider(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// ================= TITLE =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Text(
                "Account Transactions",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: LightColor.bcaDarkBlue,
                ),
              ),
            ),
          ),

          /// ================= TRANSACTION LIST =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _transectionList(),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
