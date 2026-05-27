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
* **Deck Customization**: Filter between Hiragana, Katakana, or the full set, with a randomized shuffle feature for a fresh study session every time.

## 🛠 Tech Stack & Modern Patterns

* **Swift 6 / SwiftUI**: Utilizing the latest in Apple's declarative UI framework.
* **Observation Framework**: Managed application state using the modern `@Observable` macro for high-performance view updates.
* **GeometryProxy**: Advanced container-relative sizing for font and frame scaling.
* **MVVM Architecture**: Clean separation of concerns between the data model and the presentation layer.

## 📈 Roadmap & Future Slay

- [ ] **SwiftData Persistence**: Local storage for tracking "mastery" scores and progress.
- [ ] **Haptic Feedback**: Integrating `UIImpactFeedbackGenerator` for a tactile "click" on card flicks.
- [ ] **Dark Mode Optimization**: Custom color palettes for late-night study sessions.

---

Designed and developed by **Kevin Struna** in Colorado. 🏔️
