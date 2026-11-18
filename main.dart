import 'package:flutter/material.dart';

void main() => runApp(const FlameMiningApp());

const flame = Color(0xFFFF6A00);
const bg = Color(0xFF090B10);
const panel = Color(0xFF151923);
const muted = Color(0xFF9AA3B2);

class FlameMiningApp extends StatelessWidget {
  const FlameMiningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLAME MINING',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: flame, brightness: Brightness.dark,
          surface: panel,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: bg, foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: panel,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int tab = 0;
  final pages = const [DashboardPage(), MiningPage(), WalletPage(), GuidePage(), AdminPage()];
  final titles = ['Overview', 'Mining', 'Wallet', 'User guide', 'Admin'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Icon(Icons.local_fire_department, color: flame, size: 27),
          const SizedBox(width: 8),
          Text('FLAME MINING', style: const TextStyle(
            fontWeight: FontWeight.w900, letterSpacing: 1.1, fontSize: 16)),
        ]),
        actions: [
          IconButton(onPressed: () => _notice(context,
            'Notifications will be connected to the live backend in a later build.'),
            icon: const Icon(Icons.notifications_none)),
        ],
      ),
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        backgroundColor: const Color(0xFF11151D),
        indicatorColor: flame.withOpacity(.18),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.speed), label: 'Mining'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Guide'),
          NavigationDestination(icon: Icon(Icons.admin_panel_settings_outlined), label: 'Admin'),
        ],
      ),
    );
  }
}

class PagePad extends StatelessWidget {
  final Widget child;
  const PagePad({super.key, required this.child});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(18, 12, 18, 26), child: child);
}

class Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const Panel({super.key, required this.child, this.padding = const EdgeInsets.all(16)});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity, padding: padding,
    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white.withOpacity(.055))),
    child: child);
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) => PagePad(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(colors: [Color(0xFF4B1D0A), Color(0xFF1B1514), Color(0xFF151923)]),
          border: Border.all(color: flame.withOpacity(.35))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('WELCOME TO THE FLAME', style: TextStyle(color: Colors.white70, letterSpacing: 1.2, fontSize: 11)),
          const SizedBox(height: 10),
          const Text('Mining, made\nmore transparent.', style: TextStyle(fontSize: 27, height: 1.12, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          const Text('Track verified mining activity and manage your connected operations.', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 18),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: flame, foregroundColor: Colors.black),
            onPressed: () => _notice(context, 'Demo mode: connect a verified mining provider to activate mining.'),
            icon: const Icon(Icons.bolt), label: const Text('Explore mining')),
        ]),
      ),
      const SizedBox(height: 18),
      const Text('YOUR OVERVIEW', style: sectionStyle),
      const SizedBox(height: 10),
      const Row(children: [
        Expanded(child: MetricCard(label: 'Mining status', value: 'Not connected', icon: Icons.sensors_off)),
        SizedBox(width: 10),
        Expanded(child: MetricCard(label: 'Verified rewards', value: '0.000000 BTC', icon: Icons.currency_bitcoin)),
      ]),
      const SizedBox(height: 10),
      const Row(children: [
        Expanded(child: MetricCard(label: 'Hash rate', value: '—', icon: Icons.memory)),
        SizedBox(width: 10),
        Expanded(child: MetricCard(label: 'Uptime', value: '—', icon: Icons.timer_outlined)),
      ]),
      const SizedBox(height: 18),
      const Text('GET STARTED', style: sectionStyle),
      const SizedBox(height: 10),
      const Panel(child: Column(children: [
        StepLine(number: '01', title: 'Create and verify your account', detail: 'Register with your phone number and verify your OTP.'),
        Divider(color: Colors.white10),
        StepLine(number: '02', title: 'Wait for administrator approval', detail: 'Your account stays pending until the platform owner approves it.'),
        Divider(color: Colors.white10),
        StepLine(number: '03', title: 'Connect a verified mining provider', detail: 'Mining data appears only after a real provider is connected.'),
      ])),
      const SizedBox(height: 14),
      const Text('Prototype data only · No real mining or payouts are active.', style: TextStyle(color: muted, fontSize: 12)),
    ]));
}

const sectionStyle = TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.0, fontSize: 12, color: Colors.white70);

class MetricCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const MetricCard({super.key, required this.label, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) => Panel(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: flame),
      const SizedBox(height: 12),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: muted, fontSize: 11)),
    ]));
}

class StepLine extends StatelessWidget {
  final String number, title, detail;
  const StepLine({super.key, required this.number, required this.title, required this.detail});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 34, height: 34, alignment: Alignment.center,
      decoration: BoxDecoration(color: flame.withOpacity(.16), borderRadius: BorderRadius.circular(10)),
      child: Text(number, style: const TextStyle(color: flame, fontWeight: FontWeight.w900))),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text(detail, style: const TextStyle(color: muted, fontSize: 12, height: 1.4)),
    ])),
  ]);
}

class MiningPage extends StatelessWidget {
  const MiningPage({super.key});
  @override
  Widget build(BuildContext context) => PagePad(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('MINING OPERATIONS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      const Text('Choose a coin to view its supported mining setup.', style: TextStyle(color: muted)),
      const SizedBox(height: 16),
      const CoinTile(name: 'Bitcoin', ticker: 'BTC', detail: 'SHA-256 · ASIC hardware typically required', icon: Icons.currency_bitcoin),
      const CoinTile(name: 'Litecoin', ticker: 'LTC', detail: 'Scrypt · Compatible mining hardware required', icon: Icons.currency_exchange),
      const CoinTile(name: 'Dogecoin', ticker: 'DOGE', detail: 'Scrypt · Often merge-mined with Litecoin', icon: Icons.pets),
      const CoinTile(name: 'Bitcoin Cash', ticker: 'BCH', detail: 'SHA-256 · ASIC hardware typically required', icon: Icons.currency_bitcoin),
      const SizedBox(height: 12),
      const Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('15-MINUTE SESSION MODE', style: sectionStyle),
        SizedBox(height: 8),
        Text('A timed monitoring view can refresh provider statistics every 15 minutes. It does not make proof-of-work mining 100× faster or guarantee rewards.', style: TextStyle(color: muted, height: 1.45)),
      ])),
      const SizedBox(height: 12),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: flame, foregroundColor: Colors.black),
        onPressed: () => _notice(context, 'No mining provider is connected in this prototype.'),
        child: const Text('Connect mining provider')),
    ]));
}

class CoinTile extends StatelessWidget {
  final String name, ticker, detail;
  final IconData icon;
  const CoinTile({super.key, required this.name, required this.ticker, required this.detail, required this.icon});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Panel(child: Row(children: [
      CircleAvatar(backgroundColor: flame.withOpacity(.15), child: Icon(icon, color: flame)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$name ($ticker)', style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 3), Text(detail, style: const TextStyle(color: muted, fontSize: 11)),
      ])),
      const Icon(Icons.chevron_right, color: muted),
    ])));
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) => PagePad(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('WALLET', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      const Text('Connect a wallet you own. Never share your recovery phrase or private keys.', style: TextStyle(color: muted)),
      const SizedBox(height: 16),
      const Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.account_balance_wallet_outlined, color: flame, size: 32),
        SizedBox(height: 12),
        Text('No wallet connected', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        SizedBox(height: 5),
        Text('Wallet connection will be enabled after a vetted wallet connector and supported networks are configured.', style: TextStyle(color: muted, height: 1.4)),
      ])),
      const SizedBox(height: 12),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: flame, foregroundColor: Colors.black),
        onPressed: () => _notice(context, 'Wallet connector is not configured. This prototype never requests seed phrases or private keys.'),
        child: const Text('Wallet connection setup')),
      const SizedBox(height: 18),
      const Text('SUPPORTED COINS (PLANNED)', style: sectionStyle),
      const SizedBox(height: 10),
      const Wrap(spacing: 8, runSpacing: 8, children: [
        Chip(label: Text('BTC')), Chip(label: Text('LTC')), Chip(label: Text('DOGE')), Chip(label: Text('BCH')),
      ]),
      const SizedBox(height: 12),
      const Text('Withdrawals are not active in this demo. A production release needs verified balances, transaction signing, compliance checks and clear network fees.', style: TextStyle(color: muted, fontSize: 12, height: 1.5)),
    ]));
}

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});
  @override
  Widget build(BuildContext context) => PagePad(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('FLAME USER GUIDE', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      const Text('A simple guide to using the platform safely.', style: TextStyle(color: muted)),
      const SizedBox(height: 16),
      const GuideCard(number: '01', title: 'Register', body: 'Enter your name, country code and mobile number. Create a strong password. The live release will send a one-time verification code (OTP).'),
      const GuideCard(number: '02', title: 'Verify your phone', body: 'Enter the OTP sent to your number. Never share an OTP with another person, including anyone claiming to be support.'),
      const GuideCard(number: '03', title: 'Wait for owner approval', body: 'Your account will show Pending until the sole platform administrator approves it. Approval does not guarantee mining rewards.'),
      const GuideCard(number: '04', title: 'Connect a wallet safely', body: 'Use a supported wallet you control. Verify the network and address. Never give the app your seed phrase, private key or wallet password.'),
      const GuideCard(number: '05', title: 'Choose a real mining operation', body: 'Connect only a legitimate mining pool, hardware device or cloud-mining provider with clear fees and independently verifiable terms.'),
      const GuideCard(number: '06', title: 'Understand your dashboard', body: 'Hash rate measures computational work rate; uptime measures availability; power usage and pool fees affect profitability. Rewards can vary and are never guaranteed.'),
      const GuideCard(number: '07', title: 'Withdraw safely', body: 'Check the coin, network, destination address, minimum amount and network fee before confirming. Start with a small test transaction.'),
      const GuideCard(number: '08', title: 'Get help', body: 'Use only support contacts shown inside the verified official app. Beware of fake support accounts, guaranteed returns and requests for upfront unlock fees.'),
      const SizedBox(height: 10),
      const Panel(child: Text('Important: FLAME MINING in this build is a visual prototype. Registration, SMS, administrator approval, wallet connection, mining feeds and payouts are not yet connected to production services.', style: TextStyle(color: Colors.amber, height: 1.5))),
    ]));
}

class GuideCard extends StatelessWidget {
  final String number, title, body;
  const GuideCard({super.key, required this.number, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Panel(child: StepLine(number: number, title: title, detail: body)));
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}
class _AdminPageState extends State<AdminPage> {
  String status = 'Pending';
  @override
  Widget build(BuildContext context) => PagePad(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('OWNER ADMIN', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      const Text('Sole-administrator control concept', style: TextStyle(color: muted)),
      const SizedBox(height: 16),
      const Panel(child: Row(children: [
        Icon(Icons.verified_user, color: flame, size: 30),
        SizedBox(width: 12),
        Expanded(child: Text('Production access must be restricted by server-side role permissions. Never rely on a hidden button or a role stored only on the phone.', style: TextStyle(height: 1.4))),
      ])),
      const SizedBox(height: 14),
      const Text('SAMPLE ACCESS REQUEST', style: sectionStyle),
      const SizedBox(height: 10),
      Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Demo Applicant', style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        const Text('+263 ••• ••• •••  ·  Zimbabwe', style: TextStyle(color: muted, fontSize: 12)),
        const SizedBox(height: 12),
        Row(children: [
          const Text('Status', style: TextStyle(color: muted)),
          const Spacer(),
          Text(status, style: TextStyle(color: status == 'Approved' ? Colors.greenAccent : status == 'Rejected' ? Colors.redAccent : Colors.amber, fontWeight: FontWeight.w800)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () => setState(() => status = 'Rejected'), child: const Text('Reject'))),
          const SizedBox(width: 10),
          Expanded(child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: flame, foregroundColor: Colors.black),
            onPressed: () => setState(() => status = 'Approved'),
            child: const Text('Approve'))),
        ]),
      ])),
      const SizedBox(height: 14),
      const Text('The controls above change demo state only. A live admin panel requires owner identity verification, MFA, audit logs and backend-enforced authorization.', style: TextStyle(color: muted, fontSize: 12, height: 1.5)),
    ]));
}

void _notice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message), backgroundColor: const Color(0xFF252B36)));
}
