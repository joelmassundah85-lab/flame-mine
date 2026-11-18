# FLAME MINING — Android-first Flutter prototype

This is a runnable **UI prototype**, not a live mining service. It includes:
- Dark charcoal / flame-orange mobile interface
- Overview dashboard and mining-coin catalogue
- Wallet setup placeholder with explicit safety messaging
- Eight-step in-app user guide
- Owner-admin approval-flow demonstration
- Responsive Material 3 navigation

## Run it

1. Install Flutter SDK and Android Studio.
2. Unzip this project.
3. In this folder run:

   ```bash
   flutter pub get
   flutter run
   ```

4. To build an Android APK:

   ```bash
   flutter build apk --release
   ```

The APK build requires a configured Android toolchain. This source archive does not include a prebuilt APK.

## Current prototype limitations

No real registration, OTP/SMS, database, owner login, mining-pool API, wallet connector, blockchain transaction or withdrawal is connected. The sample applicant and approve/reject buttons are local demo state only. No actual mining or rewards occur.

## Production architecture to add

- **Identity:** Firebase Authentication phone OTP or a reputable regional SMS/identity provider.
- **Database:** PostgreSQL (for example, Supabase) with row-level security.
- **Backend:** authenticated API with server-side authorization and audit logs.
- **Sole owner:** provision the owner's account out-of-band; enforce `owner_admin` role on the server; require MFA; never let users self-assign roles.
- **User approval:** pending/approved/rejected states stored server-side. Every privileged action checks the server role.
- **Mining data:** integrate only with mining pools/devices the platform is authorized to monitor. Verify provider API responses and clearly separate estimates from settled rewards.
- **Wallets:** use audited wallet-connect infrastructure or payout transaction signing with explicit user consent. Never request seed phrases or private keys.
- **Background monitoring:** server-side workers for mining devices; Android WorkManager for periodic sync and notifications. Android may defer background work to protect battery.
- **Africa launch:** configure country-specific phone formats, supported languages, local consumer disclosures, sanctions/AML obligations where applicable, tax and crypto rules, data protection, and payout availability before enabling each market.

## Important product guardrails

- Do not scan, crack, access or withdraw from dormant accounts belonging to other people.
- No guaranteed returns or claims that an app can make proof-of-work mining 100x faster.
- Mining rewards depend on real hash power, network difficulty, pool terms, fees, uptime and electricity costs.
- Show users provider, hardware, fees, reward calculations, risks and withdrawal rules before they commit funds.
