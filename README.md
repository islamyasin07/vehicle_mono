# Vehicle Mono — Vehicle Manager (Flutter monorepo)

Welcome to Vehicle Mono — a small, multi-package Flutter project to manage vehicles (cars, motorcycles, trucks). This README is tailored to be both a professional project overview and a handy developer guide. It also includes a concise changelog of recent work and placeholders for logo/screenshots so you can make the README visual and polished.

---

## Quick overview

- Project type: Flutter multi-package monorepo
- Main app: `packages/app_flutter` (Flutter app using Provider)
- Domain package: `packages/domain` (models, data repository, storage service, search helpers)

This app provides CRUD operations for three vehicle types (Car, Motorcycle, Truck). Data is stored locally using a simple JSON-based storage service under the domain package.

## Features

- Add / Edit vehicles with rich form (engine, dimensions, weights, manufacture date)
- Insert at index (advanced insert) from the editor
- Swipe-to-delete in lists (with immediate persistence)
- Delete button inside the editor when editing an existing item
- Search by company name, plate number, and manufacture date (uses typed SearchService)
- Animated, visually pleasing UI: animated gradient backgrounds, smooth transitions, cards and translucent surfaces

## Repo layout (high level)

- packages/
	- app_flutter/ — Flutter application
		- lib/pages/ — main screens (home, search, edit)
		- lib/widgets/ — reusable widgets (vehicle cards, fields, empty state)
		- lib/state/ — app state and provider wiring
	- domain/ — domain models and storage (VehicleRepository, StorageService, adapters)

## How to run (Windows — PowerShell)

1. Open PowerShell and navigate to the app package:

```powershell
cd C:\flutter-projects\vehicle_mono\packages\app_flutter
```

2. Get dependencies and run the app on a connected device or emulator:

```powershell
flutter pub get
flutter run
# or select a device: flutter devices then flutter run -d <deviceId>
```

3. Analyze & lint:

```powershell
flutter analyze
```

## Screenshots & Logo (placeholders)

Add your images to the repository and reference them here. Recommended folders:

- `assets/logo.png` — app logo
- `docs/screenshots/home.png` — screenshot of Home screen
- `docs/screenshots/edit.png` — screenshot of Edit form

Example Markdown you can paste into this README after adding images:

```markdown
![App Logo](assets/logo.png)

### Home
![Home Screen](docs/screenshots/home.png)

### Edit Vehicle
![Edit Screen](docs/screenshots/edit.png)
```

If you'd like, I can add these files (blank placeholders or sample screenshots) to the repo for you.

## Changelog — What we changed (concise)

The following is a summary of recent edits applied across the codebase (useful if you want to review or revert changes):

- `packages/app_flutter/lib/pages/home_page.dart`
	- Added animated gradient background, an AnimatedSwitcher for tab content transitions, and a rotating FAB for a polished UX. The main list area uses translucent Material surfaces so content pops from the background.

- `packages/app_flutter/lib/pages/search_page.dart`
	- Built a Search UI with fields for company name, plate number, and date. Integrated `SearchService` from the domain package to perform typed lookups.

- `packages/app_flutter/lib/pages/edit_vehicle_page.dart`
	- Comprehensive vehicle form for Car / Truck / Motorcycle, including engine, dimensions and weights.
	- Added a red "Delete" button that appears when editing an existing item; it calls the app state's delete method, saves, and closes the editor.
	- Insert-at-index dialog and hydration helpers (fill form when editing an item) are present.

- `packages/app_flutter/lib/pages/list_tab.dart`
	- List rendering for the three vehicle types. Each list item is wrapped in a `Dismissible`/`VehicleCard`.
	- Swipe-to-delete now calls `AppState.deleteXAt(index)` and immediately `AppState.save()` so deletions persist to storage.

- `packages/app_flutter/lib/widgets/vehicle_card.dart`
	- Card UI for vehicles with gradients and icons; uses `Dismissible` for swipe-to-delete and tactile scale animation on tap.

- `packages/app_flutter/lib/widgets/empty_state.dart`
	- Improved empty-state presentation with a rounded Material card and padding for visual consistency.

- `packages/app_flutter/lib/widgets/labeled_field.dart`
	- Styled TextFormField with a filled background and rounded border for consistent form visuals.

- `packages/domain/lib/services/search_service.dart`
	- Added typed search helpers: search by company/model, plate, and manufacture date.

- `packages/domain/lib/data/repo.dart` and `storage_service.dart`
	- Repository CRUD methods exist for add/update/delete/insert and save/load helpers that persist JSON files to app documents directory.

- `packages/app_flutter/lib/state/app_state.dart`
	- ChangeNotifier wrapper around `VehicleRepository` exposing add/update/delete/insert + save operations used by the UI.

Notes:
- The delete UX was improved to be more discoverable (explicit Delete button in editor) and more reliable (swipe deletes now persist instantly).
- A number of stylistic and lint fixes were applied across code (consts, alpha usage for colors, small naming fixes) during iteration.

## Developer notes & next steps

- Undo / Snackbar: currently deletes are immediate. A recommended next step is to add an 'Undo' snackbar after deletion so users can recover accidental removals. I can implement this across both swipe and editor deletes.
- Tests: add some domain unit tests for `VehicleRepository` and `SearchService` (quick wins to protect behavior).
- CI: add a GitHub Actions workflow running `flutter analyze` and optionally `flutter test` for PR checks.

## Contributing

If you want me to add images, implement Undo snackbar, or add CI, tell me which feature to prioritize and I will implement and run tests locally.

## License

Add your license here. Example: MIT.

---

## ملخص عربي (Arabic summary — موجز عربي احترافي)

Vehicle Mono هو مشروع Flutter ضمن repo متعدد الحزم لإدارة المركبات (سيارات، دراجات نارية، شاحنات). قمت مؤخراً بتحسين واجهة المستخدم بشكل مرئي، وإضافة صفحة بحث فعالة، وتحسينات على حذف العناصر (سواء بالسحب أو من شاشة التعديل) بحيث يتم الحذف وحفظ التغييرات مباشرة. كما أضفت خدمة بحث بسيطة في حزمة الـ domain.

التغييرات الرئيسية:
- واجهة رئيسية مع تدرجات متحركة.
- شاشة بحث تدعم البحث باسم الشركة، رقم اللوحة، وتاريخ التصنيع.
- شاشة تعديل بها زر حذف يظهر عند تحرير عنصر موجود ويقوم بالحذف والحفظ والرجوع.
- السحب للحذف في القوائم الآن يحفظ تلقائياً.

للمتابعة: أخبرني إن أردت إضافة زر تراجع (Undo)، تأكيد حذف (dialog)، أو أن أضع لوجو/صور توضيحية داخل `assets/` و`docs/screenshots/` وأحدّث الـ README لعرضها مباشرة.

---

If you want the README to include a real logo and screenshots now, say "Add placeholders" and I will create `assets/logo.png` (blank/placeholder) and sample screenshots in `docs/screenshots/` and update the README with working sample image links.

Happy to continue — tell me which follow-up you prefer (Undo snackbar, confirmation dialog, or add logo/screenshots now). 

