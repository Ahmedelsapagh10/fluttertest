# FlutterTest

## App Setup Instructions

### Prerequisites
- Flutter SDK (version 3.6.1 or higher)
- Dart SDK
- Android Studio/VSCode with Flutter plugins
- For Hive: Run `flutter pub run build_runner build` after setup

### Installation Steps
1. Clone the repository
2. Run `flutter pub get` to install all dependencies
3. For localization:
   - Ensure all localization files are in `assets/lang/`
   - Run `flutter pub run easy_localization:generate -S assets/lang`
4. For Hive models:
   - Run `flutter packages pub run build_runner build`
5. For app icons:
   - Configure in `flutter_icons` section of pubspec.yaml
   - Run `flutter pub run flutter_launcher_icons:main`
6. Run the app with `flutter run`

## Dependencies Used

### Core Dependencies
- **State Management**: `flutter_bloc` (^9.1.0)
- **Dependency Injection**: `get_it` (^8.0.3)
- **Navigation**: `get` (^4.7.2)
- **HTTP Client**: `dio` (^5.8.0+1) with `pretty_dio_logger` (^1.4.0)
- **Functional Programming**: `dartz` (^0.10.1)
- **Local Storage**: `hive` & `hive_flutter`
- **Internationalization**: `easy_localization` (^3.0.7+1)
- **UI Helpers**: 
  - `flutter_svg` (^2.0.17)
  - `cached_network_image` (^3.4.1)
  - `auto_size_text` (^3.0.0)
  - `flutter_screenutil` (^5.9.3)

### Dev Dependencies
- `build_runner` (for code generation)
- `hive_generator` (for Hive model generation)
- `flutter_lints` (^5.0.0)

## Project Structure
lib/
├── app/                           # App root (MaterialApp, localization, etc.)
├── config/                        # Global app configs like routes & theme
│   ├── routes/
│   └── theme/
├── core/                          # Core modules used across the app
│   ├── api/                       # Network layer (Dio, interceptors, etc.)
│   ├── preferences/               # Hive managers and model adapters
│   ├── utils/                     # Constants, string managers, asset helpers
│   ├── widget/                    # Reusable shared widgets
│   └── etc/                       # Miscellaneous helpers/tools
├── feature/                       # Feature-based folder structure
│   └── <feature_name>/           
│       ├── data/                  # Models and repository implementations
│       ├── cubit/                 # BLoC/Cubit files (logic + states)
│       └── screen/               # UI screens and local widgets
├── injector/                     # Dependency injection setup using get_it
├── main.dart                     # App entry point
