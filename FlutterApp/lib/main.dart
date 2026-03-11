import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/pages/homePage.dart';
import 'src/pages/transferPage.dart';
import 'src/pages/paymentPage.dart';
import 'src/pages/transfer/bca_account_page.dart';
import 'src/pages/transfer/other_banks_page.dart';
import 'src/pages/transfer/forex_page.dart';
import 'src/pages/transfer/proxy_address_page.dart';
import 'src/pages/transfer/virtual_account_page.dart';
import 'src/pages/transfer/sakuku_page.dart';
import 'src/pages/transfer/bagibagi_page.dart';
import 'src/pages/transfer/import_beneficiary_page.dart';
import 'src/pages/transfer/underlying_documents_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/transfer':
            return MaterialPageRoute(builder: (_) => TransferPage());
          case '/transfer/bca-account':
            return MaterialPageRoute(
              builder: (_) => BcaAccountPage(),
              settings: settings,
            );
          case '/transfer/other-banks':
            return MaterialPageRoute(
              builder: (_) => OtherBanksPage(),
              settings: settings,
            );
          case '/transfer/forex':
            return MaterialPageRoute(
              builder: (_) => ForexPage(),
              settings: settings,
            );
          case '/transfer/proxy-address':
            return MaterialPageRoute(
              builder: (_) => ProxyAddressPage(),
              settings: settings,
            );
          case '/transfer/virtual-account':
            return MaterialPageRoute(
              builder: (_) => VirtualAccountPage(),
              settings: settings,
            );
          case '/transfer/sakuku':
            return MaterialPageRoute(
              builder: (_) => SakukuPage(),
              settings: settings,
            );
          case '/transfer/bagi-bagi':
            return MaterialPageRoute(
              builder: (_) => BagiBagiPage(),
              settings: settings,
            );
          case '/transfer/import-beneficiary':
            return MaterialPageRoute(
              builder: (_) => ImportBeneficiaryPage(),
              settings: settings,
            );
          case '/transfer/underlying-documents':
            return MaterialPageRoute(
              builder: (_) => UnderlyingDocumentsPage(),
              settings: settings,
            );
          case '/payment':
            return MaterialPageRoute(builder: (_) => const PaymentPage());
          // case '/investment':
          //   return MaterialPageRoute(builder: (_) => const InvestmentPage());
          // case '/lifestyle':
          //   return MaterialPageRoute(builder: (_) => const LifestylePage());
          // case '/estore':
          //   return MaterialPageRoute(builder: (_) => const EStorePage());
          // case '/flazz':
          //   return MaterialPageRoute(builder: (_) => const FlazzPage());
          // case '/cardless':
          //   return MaterialPageRoute(builder: (_) => const CardlessPage());
          // case '/bank':
          //   return MaterialPageRoute(builder: (_) => const BankProductsPage());
          // case '/protection':
          //   return MaterialPageRoute(builder: (_) => const ProtectionPage());
          // case '/savings':
          //   return MaterialPageRoute(builder: (_) => const SavingsPage());
          // case '/bills':
          //   return MaterialPageRoute(builder: (_) => const BillsPage());
          // case '/rewards':
          //   return MaterialPageRoute(builder: (_) => const RewardsPage());
          // case '/support':
          //   return MaterialPageRoute(builder: (_) => const SupportPage());
          // case '/all':
          //   return MaterialPageRoute(builder: (_) => const AllMenuPage());
          default:
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
    );
  }
}
