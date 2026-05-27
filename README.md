# 🎴 KanaCard 

**KanaCard** is a high-fidelity Japanese learning application built with Swift and SwiftUI, designed to help users master Hiragana and Katakana through active recall and fluid, tactile interactions.

https://github.com/user-attachments/assets/70454827-4627-4c4c-9d27-27a8dbd84a69

---

## 🚀 The Vibe & Key Features

* **Active Recall UI**: A seamless 3D card-flip interaction that simulates physical flashcards for maximum retention.
* **"Tinder-Style" Flick UX**: Fluid navigation using gesture-driven physics—swipe to move through the deck with interactive spring animations.
* **Dynamic Visual Physics**: 
    * **Specular Shine**: A `RadialGradient` overlay that follows your finger to simulate light reflecting off a glossy card.
    * **Responsive Shadows**: Shadows that shift dynamically based on card position to create a sense of depth.
* **Adaptive Design**: Fully responsive layout using `GeometryReader` that scales perfectly across the entire Apple ecosystem, from iPhone SE to iPad Pro.
* **Granular Deck Customization**: A bottom settings sheet lets you precisely tune your study session:
    * **Script Picker**: Segment between All, Hiragana (あ), and Katakana (ア).
    * **Kana Set Filters**: Toggle individual variant sets via filter chips—Basic (あ seion), Voiced (が dakuon), Semi-Voiced (ぱ handakuon), and Contracted (きゃ yoon). At least one set always stays active to prevent an empty deck.
    * **Quick Options**: Reset or shuffle the deck without leaving the card view.
* **Complete Kana Coverage**: The deck spans the full Japanese kana system—over 200 characters including all seion, dakuon, handakuon, and yoon combinations for both scripts.

## 🛠 Tech Stack & Modern Patterns

* **Swift 6 / SwiftUI**: Utilizing the latest in Apple's declarative UI framework.
* **Observation Framework**: Managed application state using the modern `@Observable` macro for high-performance view updates.
* **GeometryProxy**: Advanced container-relative sizing for font and frame scaling.
* **MVVM Architecture**: Clean separation of concerns with dedicated `Models/`, `ViewModels/`, and `Views/Components/` folders.
* **Presentation Detents**: Settings exposed in a native bottom sheet using `.presentationDetents([.medium, .large])` for a seamless, in-context experience.
* **Reusable Components**: `FilterChipsView` is a self-contained toggle chip built with a `@Binding`, keeping filter state cleanly owned by the ViewModel.

## 📈 Roadmap & Future Slay

- [ ] **SwiftData Persistence**: Local storage for tracking "mastery" scores and progress.
- [ ] **Haptic Feedback**: Integrating `UIImpactFeedbackGenerator` for a tactile "click" on card flicks.
- [ ] **Dark Mode Optimization**: Custom color palettes for late-night study sessions.

---

Designed and developed by **Kevin Struna** in Colorado. 🏔️
