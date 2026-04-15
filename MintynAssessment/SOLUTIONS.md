# Mintyn iOS Assessment Solutions & Tradeoffs

## Architecture Decisions (MVVM vs MVC)
For this project, I opted for the **MVVM (Model-View-ViewModel)** architectural pattern over traditional MVC structure.

**Why MVVM:**
- **Separation of Concerns:** `UIKit`'s implementation of MVC notoriously leads to Massive View Controllers where business logic, networking, and UI updates blur together. By introducing ViewModels, we offload all business and state-mutation logic out of the View layer.
- **Testability:** A ViewModel is a pure Swift class that does not require importing `UIKit`. Consequently, we can write unit tests against its behaviors natively without instantiating any view hierarchies.

## Liquid Glass UI & Style Implementation
The Home Screen showcases an interaction-heavy **Liquid Glassmorphism** design: 
- `UIVisualEffectView` components utilizing `.systemUltraThinMaterialDark` natively blur background layers.
- CoreAnimation applies infinitely scaling/translating orbs (`CABasicAnimation` via `UIView.animate`) behind a `.dark` style blur canvas to mimic ambient lighting moving softly in the background.

## Tradeoffs Made Due to Time Constraints
Given the constrained nature of this assessment, several intentional tradeoffs were baked into the design:
- **Programmatic UI AutoLayout Boilerplate:** Rather than setting up a fully declarative SwiftUI environment or importing Combine/RxSwift, I utilized native programmatic UIKit closure-based bindings to cleanly meet requirements natively inside standard Xcode (14+) constraints.
- **In-Memory Models & Mocks:** Without an actual REST backend, models and transactions are constructed on-the-fly (`MockAuthService`). 
- **Hardcoded Strings:** Bypassed `NSLocalizedString` tables to favor swift UI iteration and visual polish.

## Future Enhancements
If transitioning this proof-of-concept into a production entity:
1. **Coordinator Pattern:** Extract routing and navigation logic from controllers entirely, managing deep-links seamlessly.
2. **Persistence Layer:** Wrap CoreData or Realm in an async repository protocol for robust offline caching.
3. **URLSession Networking Stack:** Build a reactive `async/await` driven network router to inject into the existing `MockAuthService` protocol. 
