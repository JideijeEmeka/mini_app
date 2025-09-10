# Business Directory Mini App

A Flutter mini app that displays a list of businesses with clean architecture, state management, and offline support.

## Features

- **Clean Architecture**: Domain models with validation and normalization of messy API keys
- **State Management**: Provider pattern for reactive state management
- **Networking**: Dio for HTTP requests (configured for local JSON assets)
- **Offline Support**: Local persistence with SharedPreferences
- **Reusable Components**: Generic CardWidget that can render different data types
- **UI States**: Loading, empty, error, and retry states with clear user feedback
- **Material Design**: Modern Material 3 design with responsive layout

## Architecture

### Models
- `Business`: Clean domain model with validation for business data
- `Service`: Example of another model that can use the generic CardWidget

### Services
- `BusinessService`: Handles data fetching from local JSON assets and caching

### Providers
- `BusinessProvider`: Manages business list state with loading, error, and success states

### Widgets
- `CardWidget<T>`: Generic reusable card component
- `BusinessCard`: Specific implementation for business data
- `ServiceCard`: Example implementation for service data
- State widgets: `LoadingWidget`, `EmptyWidget`, `ErrorWidget`

## Data Normalization

The app normalizes intentionally messy API keys:
- `biz_name` → `name`
- `bss_location` → `location`  
- `contct_no` → `contactNumber`

## Local Data

Business data is stored in `assets/data/businesses.json`:

```json
[
  { "biz_name": "Glow & Go Salon", "bss_location": "Atlanta", "contct_no": "+1 404 123 4567" },
  { "biz_name": "Fresh Cuts Barbershop", "bss_location": "Lagos", "contct_no": "+234 802 555 1212" },
  { "biz_name": "Chef Ama Private Kitchen", "bss_location": "Accra", "contct_no": "+233 24 888 9999" }
]
```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Generate JSON serialization code:
   ```bash
   flutter packages pub run build_runner build
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Testing

Run tests:
```bash
flutter test
```

## Key Features Demonstrated

1. **Generic Card Widget**: The `CardWidget<T>` demonstrates composition and generics
2. **Data Validation**: Business model validates and normalizes messy API data
3. **Offline Support**: App works offline after first load with cached data
4. **State Management**: Clean separation of concerns with Provider
5. **Error Handling**: Comprehensive error states with retry functionality
6. **Material Design**: Modern UI following Material 3 guidelines

## Dependencies

- `provider`: State management
- `dio`: HTTP client
- `shared_preferences`: Local storage
- `json_annotation`: JSON serialization
- `json_serializable`: Code generation for JSON