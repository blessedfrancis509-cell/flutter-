# ZenCash — Flutter Banking UI

A pixel-focused recreation of the ZenCash banking app dashboard, built with
Flutter 3.24, Material 3 and null safety. The UI includes a glassmorphic
"Total Net Worth" card with a custom-painted metallic border and light
reflections, animated quick-action buttons, a scrollable accounts/services
list, and a bottom navigation bar.

## ✨ Features

- **Pixel-matched dashboard** — purple gradient header, hero balance card,
  quick actions row, and a white "My Accounts & Services" card exactly as
  in the reference design.
- **Custom-painted balance card** — `Stack` + `BackdropFilter` (frosted
  glass blur) + `CustomPainter` (metallic bevel border, diagonal
  reflections, inner glow) + layered `BoxShadow`s for depth.
- **A full multi-screen app**, not just the dashboard — see [App map](#-app-map)
  below for every screen and how they connect.
- **Reusable widgets** — `BalanceCard`, `QuickActionsRow`,
  `AccountsServicesCard` / `AccountServiceTile`, `BottomNavBar`, `AppHeader`,
  plus shared `PrimaryButton` / `SecondaryButton` / `LabeledField` /
  `SecondaryAppBar` used across every form screen.
- **Micro-animations** — press-scale feedback on all tappable elements and
  a staggered fade/slide-in entrance for the home tab's main sections.
- **Feature-based architecture** — `core/` (theme, constants, shared
  widgets) and one folder per feature (`home`, `transfers`, `payments`,
  `cards`, `investments`, `business`), each with its own `data/` and
  `presentation/` layers.
- **Google Fonts (Inter)**, **Iconsax** icons, **flutter_svg** and
  **glassmorphism** wired up and ready to use.

## 🗺️ App map

The bottom nav bar drives an `IndexedStack` across five tabs, and the
header / quick-action icons push additional flow screens on top:

```
HomeScreen (IndexedStack, 5 tabs)
├── Home tab
│   ├── AppHeader → 🔍 search sheet · 🔔 NotificationsScreen · 👤 ProfileScreen
│   ├── BalanceCard
│   ├── QuickActionsRow → SendMoneyScreen · RequestMoneyScreen · ScanQrScreen · PayBillsScreen
│   └── AccountsServicesCard
│       ├── Zenith Accounts   → AccountDetailsScreen
│       ├── Zenith Cards      → CardsScreen
│       ├── Investments       → InvestmentsScreen
│       └── Business Banking  → BusinessBankingScreen
├── Transfers tab   (TransfersScreen: quick contacts + Send/Request/Scan + history)
├── Payments tab    (PaymentsScreen: biller categories + saved billers → PayBillsScreen)
├── Cards tab       (CardsScreen: card carousel, freeze/limits/details, card transactions)
└── Investments tab (InvestmentsScreen: portfolio value, allocation bar, holdings list)
```

Each tab keeps its own scroll position and state, since `IndexedStack`
keeps all five tabs alive rather than rebuilding them on every switch.

## 📁 Project structure

```
zencash/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart            # Full colour palette / gradients
│   │   │   ├── app_text_styles.dart       # Inter typography scale
│   │   │   └── app_theme.dart             # Material 3 ThemeData
│   │   ├── constants/
│   │   │   └── app_constants.dart         # Radius / spacing / duration tokens
│   │   └── widgets/                       # Shared across every screen
│   │       ├── secondary_app_bar.dart     # Back-button app bar for sub-pages
│   │       ├── primary_button.dart        # PrimaryButton / SecondaryButton
│   │       └── labeled_field.dart         # Labeled form text field
│   └── features/
│       ├── home/
│       │   ├── data/models/
│       │   │   ├── account_service_model.dart
│       │   │   └── notification_model.dart
│       │   └── presentation/
│       │       ├── screens/
│       │       │   ├── home_screen.dart           # 5-tab IndexedStack container
│       │       │   ├── account_details_screen.dart
│       │       │   ├── notifications_screen.dart
│       │       │   └── profile_screen.dart
│       │       └── widgets/
│       │           ├── home_tab.dart              # Home tab content
│       │           ├── app_header.dart
│       │           ├── balance_card.dart
│       │           ├── balance_card_painter.dart
│       │           ├── quick_actions_row.dart
│       │           ├── account_service_tile.dart
│       │           ├── accounts_services_card.dart
│       │           └── bottom_nav_bar.dart
│       ├── transfers/
│       │   ├── data/models/transaction_model.dart
│       │   └── presentation/screens/
│       │       ├── transfers_screen.dart          # bottom-nav tab
│       │       ├── send_money_screen.dart
│       │       ├── request_money_screen.dart
│       │       └── scan_qr_screen.dart
│       ├── payments/
│       │   ├── data/models/biller_model.dart
│       │   └── presentation/screens/
│       │       ├── payments_screen.dart           # bottom-nav tab
│       │       └── pay_bills_screen.dart
│       ├── cards/
│       │   ├── data/models/card_model.dart
│       │   └── presentation/screens/cards_screen.dart   # bottom-nav tab
│       ├── investments/
│       │   ├── data/models/investment_model.dart
│       │   └── presentation/screens/investments_screen.dart  # bottom-nav tab
│       └── business/
│           └── presentation/screens/business_banking_screen.dart
├── assets/
│   ├── icons/
│   └── images/
├── pubspec.yaml
└── README.md
```

## 🚀 Getting started

### Prerequisites

- Flutter SDK **3.24.0** or newer (`flutter --version`)
- Dart **3.4.0** or newer (bundled with Flutter)
- Xcode (for iOS) and/or Android Studio + an emulator or device

### Run it

```bash
# 1. Install dependencies
flutter pub get

# 2. Run on a connected device / simulator / emulator
flutter run

# Or target a specific platform explicitly
flutter run -d ios
flutter run -d android
```

### Build a release

```bash
flutter build apk        # Android
flutter build ios        # iOS (requires macOS + Xcode)
```

## 🎨 Design tokens

All colours, gradients, spacing and radii live in `lib/core/theme/` and
`lib/core/constants/app_constants.dart` — tweak values there to re-skin the
whole app consistently rather than hunting through individual widgets.

## 🧩 Extending the app

The other bottom-nav destinations (Transfers, Payments, Cards, Investments)
are stubbed as tappable items in `BottomNavBar`. To wire up real screens:

1. Create a new folder under `lib/features/<feature_name>/` mirroring the
   `home` feature's `data/` + `presentation/` structure.
2. Swap `HomeScreen`'s `Scaffold` body for an `IndexedStack` (or a
   `Navigator`/router of your choice) driven by `BottomNavBar`'s selected
   index.

## 📦 Key dependencies

| Package         | Purpose                                   |
|------------------|--------------------------------------------|
| `google_fonts`   | Inter typeface                             |
| `iconsax`        | Icon set used throughout the UI            |
| `flutter_svg`    | SVG asset rendering (for custom iconography) |
| `glassmorphism`  | Convenience glass-panel widgets            |
| `flutter_animate`| Declarative entrance/press animations      |

---

Built as a UI-only front end — no backend/networking is wired up. Numbers
shown (balances, account values, transactions, cards, investments) are
static sample data at the top of each screen file, ready to be swapped
for a real data source (REST/GraphQL, a state-management layer such as
Riverpod or Bloc, etc.).

## ⚠️ Known caveats

- **Scan QR is a mock viewfinder**, not a working scanner — there's no
  camera plugin wired up. Swap the dark backdrop in `scan_qr_screen.dart`
  for a preview widget from a package like `mobile_scanner` when you're
  ready to scan real QR codes.
- **Icon names weren't compiled against a live `iconsax` install.** This
  project was generated in a sandbox without access to `pub.dev` /
  the Flutter SDK, so icon constants (`Iconsax.wallet_2`, `Iconsax.setting_4`,
  etc.) were chosen from well-established naming patterns but not verified
  against your exact installed version. Run `flutter pub get` and
  `flutter analyze` first — if any `Iconsax.xxx` constant doesn't exist,
  it'll show as a single clear analyzer error per usage, easy to swap for
  the nearest equivalent in your installed version.
