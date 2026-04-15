# Mintyn iOS Assessment Solution Overview

## 1. Architecture Decisions (MVVM vs MVC)
For this project, I opted for the **MVVM (Model-View-ViewModel)** architectural pattern over the traditional MVC (Model-View-Controller) structure.

**Why MVVM:**
- **Separation of Concerns:** `UIKit`'s implementation of MVC notoriously leads to Massive View Controllers where business logic, networking, and UI updates blur together. By introducing ViewModels, we offload all business and state-mutation logic out of the View layer.
- **Testability:** A ViewModel is a pure Swift class that does not require importing `UIKit`. Consequently, we can write extremely fast unit tests against its state and behaviors without instantiating any view hierarchies, as demonstrated in `LoginViewModelTests`.

## 2. Tradeoffs Made Due to Time Constraints
Given the constrained nature of this assessment, several intentional tradeoffs were baked into the design:
- **Programmatic UI AutoLayout Boilerplate:** Rather than setting up a fully comprehensive View-binding engine (like Combine or RxSwift), I used simple closure-based bindings (`onSuccess`, `onError`) in the ViewModels. This keeps dependency footprint to zero but lacks the robust declarative power of a reactive framework.
- **In-Memory Models & Mocks:** Without an actual REST backend or CoreData stack, models and transactions are constructed on-the-fly via dummy injection. Real persistence handling requires synchronization queues and heavy error handling which was intentionally skipped here.
- **Hardcoded Strings:** I bypassed NSLocalizedString tables. While localized string bundles are mandatory for production, injecting them here would distract from the core architectural deliverables.

## 3. Future Improvements
If given more time or if transitioning this proof-of-concept into a production entity, I would target the following optimizations:
- **Performance:** Move UI component instantiations into a generic view hierarchy lifecycle manager (e.g. `loadView()`) to restrict memory usage. Optimize `UITableView` batch updates utilizing `DiffableDataSource`.
- **Scalability:** Migrate routing logic out of the ViewControllers entirely utilizing the **Coordinator Pattern**. Currently, ViewControllers push each other to the Navigation Stack. A Coordinator handles deep-linking natively and fully decouples ViewControllers from knowing about each other.
- **Networking Layer:** Implement a generic `URLSessionProtocol` abstracting the requests built on Swift concurrency (`async/await`) along with `Codable` wrappers, removing the current traditional callback handler.
- **Persistence:** Wrap CoreData or Realm in an async repository pattern abstraction to allow seamless offline caching for the Home dashboard.

## 4. Testing Strategy
Our testing aims to enforce the integrity of the critical user boundaries.
- **Unit Tests (`AuthServiceTests.swift`, `LoginViewModelTests.swift`):** Ensure that our ViewModel appropriately validates inputs without the application needing to be built or run. Mocked abstract boundaries (`MockAuthService`) guarantee deterministic results preventing flakey networked tests.
- **UI Tests (`LoginFlowUITests.swift`):** Validated the end-to-end navigational integrity: booting the App -> Splash -> entering valid mocked credentials -> hitting Home dashboard -> navigating to Settings -> triggering Logout.

## 5. UI/UX Assumptions
Without raw high-fidelity assets (like exact font profiles, `.lottie` files for the loader, and specific `.svg` iconography), I had to make safe approximations:
- Built custom `PaddingTextField` and `PrimaryButton` subclasses enforcing a sleek dark mode.
- Synthesized the Splash logo/loading cadence utilizing base `CABasicAnimation` primitives and `SF Symbols`.
- Selected standard grouped table layout interfaces for settings, honoring standard Apple Human Interface Guidelines to keep the app familiar and accessible.
