History & UI changes

What changed

- Added navigation to the History screen from the Today page by adding a History icon button to the AppBar (`lib/screens/today_screen.dart`).
- Fixed date formatting in the History screen by importing `package:intl/intl.dart` and removing an incorrect getter (`lib/screens/history_screen.dart`).
- Adjusted reset behavior in `StorageService.resetToday()` to remove today's key from storage rather than setting it to 0. This prevents zero-valued entries from appearing in history (`lib/services/storage_service.dart`).
- Added `intl` dependency to `pubspec.yaml` so `DateFormat` works.
- Added a `HomeScreen` with a bottom navigation bar and floating action button and set it as app home. (`lib/screens/home_screen.dart`, `lib/main.dart`)

How to test

1. Fetch packages:

```bash
flutter pub get
```

2. Run the app and open the Today screen.
3. Tap the History icon (top-right) to open History.
4. On Today, press "Reset Today" then open History and press the refresh FAB — today's date should no longer be listed.

Notes

- The branch created for this work (if pushed) is `feat/history-navigation`.
- If you prefer to retain zero entries in history and hide them in the UI instead, change the `resetToday()` implementation accordingly or filter zeros in `HistoryScreen`.

Commit message used

`feat(history): add history navigation, fix DateFormat and reset behavior; add intl dependency`
