# Tech Notes - Business Directory Mini App

## Architecture
**Clean layered architecture:**
```
UI (Screens, Widgets) → State (Provider, Models) → Service (Dio) → Data (JSON, Cache)
```

## Key Decisions

### Generic Card Widget
- `CardWidget<T>` with composition pattern
- Reusable across Business/Service types
- Trade-off: More complex than specific widgets

### Data Normalization
- Normalize messy API keys in model layer (`biz_name` → `name`)
- Clean domain models regardless of backend quality

### Offline-First
- SharedPreferences with 24h cache expiry
- Works without network, better UX

### State Management
- Provider over Bloc/Riverpod for simplicity
- Trade-off: Less powerful but easier to understand

## Current Limitations
- Basic error handling
- No dependency injection
- Simple caching strategy
- Limited test coverage

## Improvements (Given More Time)

1. **Bloc for state management** - Better testability and predictability
2. **GetIt for DI** - Easier mocking and testing
3. **Hive for caching** - Better performance and query capabilities
4. **Comprehensive testing** - Unit, widget, and integration tests
5. **Performance optimizations** - Lazy loading, image caching, memory management

## Dependencies
- `provider` - State management
- `dio` - HTTP client
- `shared_preferences` - Local storage
- `json_annotation` - Serialization

**Potential additions:** `get_it`, `hive`, `bloc`, `equatable`

## Summary
Clean architecture with good separation of concerns. Generic CardWidget demonstrates composition patterns. Offline-first approach ensures good UX. Main improvements needed: testing coverage, dependency injection, and better caching.