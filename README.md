# 🎴 KanaCard 

**KanaCard** is a high-fidelity Japanese learning application built with Swift and SwiftUI, designed to help users master Hiragana and Katakana through active recall, spaced repetition, and fluid, tactile interactions.

<!-- 🎥 Demo video coming soon -->

---

## 🚀 The Vibe & Key Features

* **Active Recall UI**: A seamless 3D card-flip interaction that simulates physical flashcards for maximum retention.
* **"Tinder-Style" Flick UX**: Fluid navigation using gesture-driven physics—swipe to move through the deck with interactive spring animations.
* **SM-2 Spaced Repetition Engine**: Every card tracks its own ease factor, interval, and repetition count. Rating a card as Fail, Hard, Good, or Easy reschedules its next appearance automatically, surfacing tricky kana more often and retiring mastered ones.
* **Persistent Progress with SwiftData**: Review history and scheduling state are stored locally, so your deck and stats pick up right where you left off.
* **Progress & Stats Dashboard**:
    * **Daily Snapshot**: See how many cards are due today versus scheduled for later.
    * **Deck Mastery**: Track how many cards have graduated to "mastered" status versus still being learned.
    * **Script Breakdown**: Side-by-side mastery progress bars for Hiragana and Katakana.
    * **Rating Breakdown**: A Swift Charts pie chart visualizing your Easy / Good / Hard / Fail history.
* **Dynamic Visual Physics**:
    * **Specular Shine**: A `RadialGradient` overlay that follows your finger to simulate light reflecting off a glossy card.
    * **Responsive Shadows**: Shadows that shift dynamically based on card position to create a sense of depth.
    * **Haptic Feedback**: Tactile responses on flips, swipes, and ratings via `sensoryFeedback`.
* **Adaptive Design**: Fully responsive layout using `GeometryReader` that scales perfectly across the entire Apple ecosystem, from iPhone SE to iPad Pro.
* **Granular Deck Customization**: A bottom settings sheet lets you precisely tune your study session:
    * **Script Picker**: Segment between All, Hiragana (あ), and Katakana (ア).
    * **Kana Set Filters**: Toggle individual variant sets via filter chips—Basic (あ seion), Voiced (が dakuon), Semi-Voiced (ぱ handakuon), and Contracted (きゃ yoon). At least one set always stays active to prevent an empty deck.
    * **Quick Options**: Reset or shuffle the deck without leaving the card view.
* **6 Custom App Themes**: Re-tint the entire UI with one of six palettes—Amethyst, Forest, Mint, Ocean, Ruby, and Sunset—each with matching light and dark variants.
* **Complete Kana Coverage**: The deck spans the full Japanese kana system—over 200 characters including all seion, dakuon, handakuon, and yoon combinations for both scripts.

## 🛠 Tech Stack & Modern Patterns

* **Swift 6 / SwiftUI**: Utilizing the latest in Apple's declarative UI framework.
* **SwiftData**: On-device persistence for the entire kana deck, including SRS scheduling state and rating history.
* **SM-2 Algorithm**: A from-scratch implementation of the SuperMemo 2 spaced repetition formula driving the review scheduler.
* **Swift Charts**: Native `SectorMark` pie charts and progress visualizations on the Stats screen.
* **Observation Framework**: Managed application state using the modern `@Observable` macro for high-performance view updates.
* **GeometryProxy**: Advanced container-relative sizing for font and frame scaling.
* **MVVM Architecture**: Clean separation of concerns with dedicated `Models/`, `ViewModels/`, and `Views/Components/` folders.
* **Presentation Detents**: Settings exposed in a native bottom sheet using `.presentationDetents([.medium, .large])` for a seamless, in-context experience.
* **Reusable Components**: `FilterChipsView` and `GlassCardBackground` are self-contained, theme-aware building blocks shared across the Card and Stats screens.

## 📈 Roadmap & Future Slay

- [ ] **Review Forecast**: A chart previewing how many cards will come due over the next several days.
- [ ] **Reminders**: Local notifications to nudge users back for their daily review.
- [ ] **iCloud Sync**: Keep deck progress in sync across devices via SwiftData + CloudKit.

---

Designed and developed by **Kevin Struna** in Colorado. 🏔️
