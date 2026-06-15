//
//  Kana.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import Foundation
import SwiftData

@Model
class Kana: Identifiable {
    var id = UUID()
    var character: String // "あ"
    var romaji: String    // "a"
    var type: KanaType    // enum: .hiragana or .katakana
    var variant: KanaVariant // enum: .seion, .dakuon, .handakuon, .yoon
    var lastRating: RatingType? // enum: .fail, .hard, .good, .easy
    
    // SRS Properties
    var dueDate: Date // The exact date this card should appear in the active deck again.
    var interval: Int // The number of days to wait before the next review.
    var easeFactor: Double // The multiplier that dictates how fast the interval grows (usually starts at 2.5).
    var repetitions: Int // The number of consecutive times the user has answered this card correctly.
    
    init(id: UUID = UUID(), character: String, romaji: String, type: KanaType, variant: KanaVariant, lastRating: RatingType? = nil, dueDate: Date = Date(), interval: Int = 0, easeFactor: Double = 2.5, repetitions: Int = 0) {
        self.id = id
        self.character = character
        self.romaji = romaji
        self.type = type
        self.variant = variant
        self.lastRating = lastRating
        self.dueDate = dueDate
        self.interval = interval
        self.easeFactor = easeFactor
        self.repetitions = repetitions
    }
}

enum KanaType: String, Codable {
    case hiragana
    case katakana
}

enum KanaVariant: String, Codable, CaseIterable, Hashable {
    case seion      // Basic (Pure)
    case dakuon     // Dakuten (Voiced)
    case handakuon  // Handakuten (Semi-voiced)
    case yoon       // Contracted (kya, sha, etc.)
}

enum RatingType: String, Codable {
    case fail
    case hard
    case good
    case easy
}

extension Kana {
    static let allExamples: [Kana] = [
        
        // MARK: - HIRAGANA SEION (Pure)
        // Vowels
        Kana(character: "あ", romaji: "a", type: .hiragana, variant: .seion),
        Kana(character: "い", romaji: "i", type: .hiragana, variant: .seion),
        Kana(character: "う", romaji: "u", type: .hiragana, variant: .seion),
        Kana(character: "え", romaji: "e", type: .hiragana, variant: .seion),
        Kana(character: "お", romaji: "o", type: .hiragana, variant: .seion),
        // K-Row
        Kana(character: "か", romaji: "ka", type: .hiragana, variant: .seion),
        Kana(character: "き", romaji: "ki", type: .hiragana, variant: .seion),
        Kana(character: "く", romaji: "ku", type: .hiragana, variant: .seion),
        Kana(character: "け", romaji: "ke", type: .hiragana, variant: .seion),
        Kana(character: "こ", romaji: "ko", type: .hiragana, variant: .seion),
        // S-Row
        Kana(character: "さ", romaji: "sa", type: .hiragana, variant: .seion),
        Kana(character: "し", romaji: "shi", type: .hiragana, variant: .seion),
        Kana(character: "す", romaji: "su", type: .hiragana, variant: .seion),
        Kana(character: "せ", romaji: "se", type: .hiragana, variant: .seion),
        Kana(character: "そ", romaji: "so", type: .hiragana, variant: .seion),
        // T-Row
        Kana(character: "た", romaji: "ta", type: .hiragana, variant: .seion),
        Kana(character: "ち", romaji: "chi", type: .hiragana, variant: .seion),
        Kana(character: "つ", romaji: "tsu", type: .hiragana, variant: .seion),
        Kana(character: "て", romaji: "te", type: .hiragana, variant: .seion),
        Kana(character: "と", romaji: "to", type: .hiragana, variant: .seion),
        // N-Row
        Kana(character: "な", romaji: "na", type: .hiragana, variant: .seion),
        Kana(character: "に", romaji: "ni", type: .hiragana, variant: .seion),
        Kana(character: "ぬ", romaji: "nu", type: .hiragana, variant: .seion),
        Kana(character: "ね", romaji: "ne", type: .hiragana, variant: .seion),
        Kana(character: "の", romaji: "no", type: .hiragana, variant: .seion),
        // H-Row
        Kana(character: "は", romaji: "ha", type: .hiragana, variant: .seion),
        Kana(character: "ひ", romaji: "hi", type: .hiragana, variant: .seion),
        Kana(character: "ふ", romaji: "fu", type: .hiragana, variant: .seion),
        Kana(character: "へ", romaji: "he", type: .hiragana, variant: .seion),
        Kana(character: "ほ", romaji: "ho", type: .hiragana, variant: .seion),
        // M-Row
        Kana(character: "ま", romaji: "ma", type: .hiragana, variant: .seion),
        Kana(character: "み", romaji: "mi", type: .hiragana, variant: .seion),
        Kana(character: "む", romaji: "mu", type: .hiragana, variant: .seion),
        Kana(character: "め", romaji: "me", type: .hiragana, variant: .seion),
        Kana(character: "も", romaji: "mo", type: .hiragana, variant: .seion),
        // Y-Row
        Kana(character: "や", romaji: "ya", type: .hiragana, variant: .seion),
        Kana(character: "ゆ", romaji: "yu", type: .hiragana, variant: .seion),
        Kana(character: "よ", romaji: "yo", type: .hiragana, variant: .seion),
        // R-Row
        Kana(character: "ら", romaji: "ra", type: .hiragana, variant: .seion),
        Kana(character: "り", romaji: "ri", type: .hiragana, variant: .seion),
        Kana(character: "る", romaji: "ru", type: .hiragana, variant: .seion),
        Kana(character: "れ", romaji: "re", type: .hiragana, variant: .seion),
        Kana(character: "ろ", romaji: "ro", type: .hiragana, variant: .seion),
        // W-Row & N
        Kana(character: "わ", romaji: "wa", type: .hiragana, variant: .seion),
        Kana(character: "を", romaji: "wo", type: .hiragana, variant: .seion),
        Kana(character: "ん", romaji: "n", type: .hiragana, variant: .seion),

        // MARK: - HIRAGANA DAKUON (Voiced)
        // G-Row
        Kana(character: "が", romaji: "ga", type: .hiragana, variant: .dakuon),
        Kana(character: "ぎ", romaji: "gi", type: .hiragana, variant: .dakuon),
        Kana(character: "ぐ", romaji: "gu", type: .hiragana, variant: .dakuon),
        Kana(character: "げ", romaji: "ge", type: .hiragana, variant: .dakuon),
        Kana(character: "ご", romaji: "go", type: .hiragana, variant: .dakuon),
        // Z-Row
        Kana(character: "ざ", romaji: "za", type: .hiragana, variant: .dakuon),
        Kana(character: "じ", romaji: "ji", type: .hiragana, variant: .dakuon),
        Kana(character: "ず", romaji: "zu", type: .hiragana, variant: .dakuon),
        Kana(character: "ぜ", romaji: "ze", type: .hiragana, variant: .dakuon),
        Kana(character: "ぞ", romaji: "zo", type: .hiragana, variant: .dakuon),
        // D-Row
        Kana(character: "だ", romaji: "da", type: .hiragana, variant: .dakuon),
        Kana(character: "ぢ", romaji: "ji", type: .hiragana, variant: .dakuon),
        Kana(character: "づ", romaji: "zu", type: .hiragana, variant: .dakuon),
        Kana(character: "で", romaji: "de", type: .hiragana, variant: .dakuon),
        Kana(character: "ど", romaji: "do", type: .hiragana, variant: .dakuon),
        // B-Row
        Kana(character: "ば", romaji: "ba", type: .hiragana, variant: .dakuon),
        Kana(character: "び", romaji: "bi", type: .hiragana, variant: .dakuon),
        Kana(character: "ぶ", romaji: "bu", type: .hiragana, variant: .dakuon),
        Kana(character: "べ", romaji: "be", type: .hiragana, variant: .dakuon),
        Kana(character: "ぼ", romaji: "bo", type: .hiragana, variant: .dakuon),

        // MARK: - HIRAGANA HANDAKUON (Semi-Voiced)
        // P-Row
        Kana(character: "ぱ", romaji: "pa", type: .hiragana, variant: .handakuon),
        Kana(character: "ぴ", romaji: "pi", type: .hiragana, variant: .handakuon),
        Kana(character: "ぷ", romaji: "pu", type: .hiragana, variant: .handakuon),
        Kana(character: "ぺ", romaji: "pe", type: .hiragana, variant: .handakuon),
        Kana(character: "ぽ", romaji: "po", type: .hiragana, variant: .handakuon),

        // MARK: - HIRAGANA YOON (Contracted)
        // K-Row
        Kana(character: "きゃ", romaji: "kya", type: .hiragana, variant: .yoon),
        Kana(character: "きゅ", romaji: "kyu", type: .hiragana, variant: .yoon),
        Kana(character: "きょ", romaji: "kyo", type: .hiragana, variant: .yoon),
        // S-Row
        Kana(character: "しゃ", romaji: "sha", type: .hiragana, variant: .yoon),
        Kana(character: "しゅ", romaji: "shu", type: .hiragana, variant: .yoon),
        Kana(character: "しょ", romaji: "sho", type: .hiragana, variant: .yoon),
        // C-Row
        Kana(character: "ちゃ", romaji: "cha", type: .hiragana, variant: .yoon),
        Kana(character: "ちゅ", romaji: "chu", type: .hiragana, variant: .yoon),
        Kana(character: "ちょ", romaji: "cho", type: .hiragana, variant: .yoon),
        // N-Row
        Kana(character: "にゃ", romaji: "nya", type: .hiragana, variant: .yoon),
        Kana(character: "にゅ", romaji: "nyu", type: .hiragana, variant: .yoon),
        Kana(character: "にょ", romaji: "nyo", type: .hiragana, variant: .yoon),
        // H-Row
        Kana(character: "ひゃ", romaji: "hya", type: .hiragana, variant: .yoon),
        Kana(character: "ひゅ", romaji: "hyu", type: .hiragana, variant: .yoon),
        Kana(character: "ひょ", romaji: "hyo", type: .hiragana, variant: .yoon),
        // M-Row
        Kana(character: "みゃ", romaji: "mya", type: .hiragana, variant: .yoon),
        Kana(character: "みゅ", romaji: "myu", type: .hiragana, variant: .yoon),
        Kana(character: "みょ", romaji: "myo", type: .hiragana, variant: .yoon),
        // R-Row
        Kana(character: "りゃ", romaji: "rya", type: .hiragana, variant: .yoon),
        Kana(character: "りゅ", romaji: "ryu", type: .hiragana, variant: .yoon),
        Kana(character: "りょ", romaji: "ryo", type: .hiragana, variant: .yoon),
        // G-Row (Voiced)
        Kana(character: "ぎゃ", romaji: "gya", type: .hiragana, variant: .yoon),
        Kana(character: "ぎゅ", romaji: "gyu", type: .hiragana, variant: .yoon),
        Kana(character: "ぎょ", romaji: "gyo", type: .hiragana, variant: .yoon),
        // J-Row (Voiced)
        Kana(character: "じゃ", romaji: "ja", type: .hiragana, variant: .yoon),
        Kana(character: "じゅ", romaji: "ju", type: .hiragana, variant: .yoon),
        Kana(character: "じょ", romaji: "jo", type: .hiragana, variant: .yoon),
        // B-Row (Voiced)
        Kana(character: "びゃ", romaji: "bya", type: .hiragana, variant: .yoon),
        Kana(character: "びゅ", romaji: "byu", type: .hiragana, variant: .yoon),
        Kana(character: "びょ", romaji: "byo", type: .hiragana, variant: .yoon),
        // P-Row (Semi-Voiced)
        Kana(character: "ぴゃ", romaji: "pya", type: .hiragana, variant: .yoon),
        Kana(character: "ぴゅ", romaji: "pyu", type: .hiragana, variant: .yoon),
        Kana(character: "ぴょ", romaji: "pyo", type: .hiragana, variant: .yoon),

        // MARK: - KATAKANA SEION (Pure)
        // Vowels
        Kana(character: "ア", romaji: "a", type: .katakana, variant: .seion),
        Kana(character: "イ", romaji: "i", type: .katakana, variant: .seion),
        Kana(character: "ウ", romaji: "u", type: .katakana, variant: .seion),
        Kana(character: "エ", romaji: "e", type: .katakana, variant: .seion),
        Kana(character: "オ", romaji: "o", type: .katakana, variant: .seion),
        // K-Row
        Kana(character: "カ", romaji: "ka", type: .katakana, variant: .seion),
        Kana(character: "キ", romaji: "ki", type: .katakana, variant: .seion),
        Kana(character: "ク", romaji: "ku", type: .katakana, variant: .seion),
        Kana(character: "ケ", romaji: "ke", type: .katakana, variant: .seion),
        Kana(character: "コ", romaji: "ko", type: .katakana, variant: .seion),
        // S-Row
        Kana(character: "サ", romaji: "sa", type: .katakana, variant: .seion),
        Kana(character: "シ", romaji: "shi", type: .katakana, variant: .seion),
        Kana(character: "ス", romaji: "su", type: .katakana, variant: .seion),
        Kana(character: "セ", romaji: "se", type: .katakana, variant: .seion),
        Kana(character: "ソ", romaji: "so", type: .katakana, variant: .seion),
        // T-Row
        Kana(character: "タ", romaji: "ta", type: .katakana, variant: .seion),
        Kana(character: "チ", romaji: "chi", type: .katakana, variant: .seion),
        Kana(character: "ツ", romaji: "tsu", type: .katakana, variant: .seion),
        Kana(character: "テ", romaji: "te", type: .katakana, variant: .seion),
        Kana(character: "ト", romaji: "to", type: .katakana, variant: .seion),
        // N-Row
        Kana(character: "ナ", romaji: "na", type: .katakana, variant: .seion),
        Kana(character: "ニ", romaji: "ni", type: .katakana, variant: .seion),
        Kana(character: "ヌ", romaji: "nu", type: .katakana, variant: .seion),
        Kana(character: "ネ", romaji: "ne", type: .katakana, variant: .seion),
        Kana(character: "ノ", romaji: "no", type: .katakana, variant: .seion),
        // H-Row
        Kana(character: "ハ", romaji: "ha", type: .katakana, variant: .seion),
        Kana(character: "ヒ", romaji: "hi", type: .katakana, variant: .seion),
        Kana(character: "フ", romaji: "fu", type: .katakana, variant: .seion),
        Kana(character: "ヘ", romaji: "he", type: .katakana, variant: .seion),
        Kana(character: "ホ", romaji: "ho", type: .katakana, variant: .seion),
        // M-Row
        Kana(character: "マ", romaji: "ma", type: .katakana, variant: .seion),
        Kana(character: "ミ", romaji: "mi", type: .katakana, variant: .seion),
        Kana(character: "ム", romaji: "mu", type: .katakana, variant: .seion),
        Kana(character: "メ", romaji: "me", type: .katakana, variant: .seion),
        Kana(character: "モ", romaji: "mo", type: .katakana, variant: .seion),
        // Y-Row
        Kana(character: "ヤ", romaji: "ya", type: .katakana, variant: .seion),
        Kana(character: "ユ", romaji: "yu", type: .katakana, variant: .seion),
        Kana(character: "ヨ", romaji: "yo", type: .katakana, variant: .seion),
        // R-Row
        Kana(character: "ラ", romaji: "ra", type: .katakana, variant: .seion),
        Kana(character: "リ", romaji: "ri", type: .katakana, variant: .seion),
        Kana(character: "ル", romaji: "ru", type: .katakana, variant: .seion),
        Kana(character: "レ", romaji: "re", type: .katakana, variant: .seion),
        Kana(character: "ロ", romaji: "ro", type: .katakana, variant: .seion),
        // W-Row & N
        Kana(character: "ワ", romaji: "wa", type: .katakana, variant: .seion),
        Kana(character: "ヲ", romaji: "wo", type: .katakana, variant: .seion),
        Kana(character: "ン", romaji: "n", type: .katakana, variant: .seion),

        // MARK: - KATAKANA DAKUON (Voiced)
        // G-Row
        Kana(character: "ガ", romaji: "ga", type: .katakana, variant: .dakuon),
        Kana(character: "ギ", romaji: "gi", type: .katakana, variant: .dakuon),
        Kana(character: "グ", romaji: "gu", type: .katakana, variant: .dakuon),
        Kana(character: "ゲ", romaji: "ge", type: .katakana, variant: .dakuon),
        Kana(character: "ゴ", romaji: "go", type: .katakana, variant: .dakuon),
        // Z-Row
        Kana(character: "ザ", romaji: "za", type: .katakana, variant: .dakuon),
        Kana(character: "ジ", romaji: "ji", type: .katakana, variant: .dakuon),
        Kana(character: "ズ", romaji: "zu", type: .katakana, variant: .dakuon),
        Kana(character: "ゼ", romaji: "ze", type: .katakana, variant: .dakuon),
        Kana(character: "ゾ", romaji: "zo", type: .katakana, variant: .dakuon),
        // D-Row
        Kana(character: "ダ", romaji: "da", type: .katakana, variant: .dakuon),
        Kana(character: "ヂ", romaji: "ji", type: .katakana, variant: .dakuon),
        Kana(character: "ヅ", romaji: "zu", type: .katakana, variant: .dakuon),
        Kana(character: "デ", romaji: "de", type: .katakana, variant: .dakuon),
        Kana(character: "ド", romaji: "do", type: .katakana, variant: .dakuon),
        // B-Row
        Kana(character: "バ", romaji: "ba", type: .katakana, variant: .dakuon),
        Kana(character: "ビ", romaji: "bi", type: .katakana, variant: .dakuon),
        Kana(character: "ブ", romaji: "bu", type: .katakana, variant: .dakuon),
        Kana(character: "ベ", romaji: "be", type: .katakana, variant: .dakuon),
        Kana(character: "ボ", romaji: "bo", type: .katakana, variant: .dakuon),

        // MARK: - KATAKANA HANDAKUON (Semi-Voiced)
        // P-Row
        Kana(character: "パ", romaji: "pa", type: .katakana, variant: .handakuon),
        Kana(character: "ピ", romaji: "pi", type: .katakana, variant: .handakuon),
        Kana(character: "プ", romaji: "pu", type: .katakana, variant: .handakuon),
        Kana(character: "ペ", romaji: "pe", type: .katakana, variant: .handakuon),
        Kana(character: "ポ", romaji: "po", type: .katakana, variant: .handakuon),

        // MARK: - KATAKANA YOON (Contracted)
        // K-Row
        Kana(character: "キャ", romaji: "kya", type: .katakana, variant: .yoon),
        Kana(character: "キュ", romaji: "kyu", type: .katakana, variant: .yoon),
        Kana(character: "キョ", romaji: "kyo", type: .katakana, variant: .yoon),
        // S-Row
        Kana(character: "シャ", romaji: "sha", type: .katakana, variant: .yoon),
        Kana(character: "シュ", romaji: "shu", type: .katakana, variant: .yoon),
        Kana(character: "ショ", romaji: "sho", type: .katakana, variant: .yoon),
        // C-Row
        Kana(character: "チャ", romaji: "cha", type: .katakana, variant: .yoon),
        Kana(character: "チュ", romaji: "chu", type: .katakana, variant: .yoon),
        Kana(character: "チョ", romaji: "cho", type: .katakana, variant: .yoon),
        // N-Row
        Kana(character: "ニャ", romaji: "nya", type: .katakana, variant: .yoon),
        Kana(character: "ニュ", romaji: "nyu", type: .katakana, variant: .yoon),
        Kana(character: "ニョ", romaji: "nyo", type: .katakana, variant: .yoon),
        // H-Row
        Kana(character: "ヒャ", romaji: "hya", type: .katakana, variant: .yoon),
        Kana(character: "ヒュ", romaji: "hyu", type: .katakana, variant: .yoon),
        Kana(character: "ヒョ", romaji: "hyo", type: .katakana, variant: .yoon),
        // M-Row
        Kana(character: "ミャ", romaji: "mya", type: .katakana, variant: .yoon),
        Kana(character: "ミュ", romaji: "myu", type: .katakana, variant: .yoon),
        Kana(character: "ミョ", romaji: "myo", type: .katakana, variant: .yoon),
        // R-Row
        Kana(character: "リャ", romaji: "rya", type: .katakana, variant: .yoon),
        Kana(character: "リュ", romaji: "ryu", type: .katakana, variant: .yoon),
        Kana(character: "リョ", romaji: "ryo", type: .katakana, variant: .yoon),
        // G-Row (Voiced)
        Kana(character: "ギャ", romaji: "gya", type: .katakana, variant: .yoon),
        Kana(character: "ギュ", romaji: "gyu", type: .katakana, variant: .yoon),
        Kana(character: "ギョ", romaji: "gyo", type: .katakana, variant: .yoon),
        // J-Row (Voiced)
        Kana(character: "ジャ", romaji: "ja", type: .katakana, variant: .yoon),
        Kana(character: "ジュ", romaji: "ju", type: .katakana, variant: .yoon),
        Kana(character: "ジョ", romaji: "jo", type: .katakana, variant: .yoon),
        // B-Row (Voiced)
        Kana(character: "ビャ", romaji: "bya", type: .katakana, variant: .yoon),
        Kana(character: "ビュ", romaji: "byu", type: .katakana, variant: .yoon),
        Kana(character: "ビョ", romaji: "byo", type: .katakana, variant: .yoon),
        // P-Row (Semi-Voiced)
        Kana(character: "ピャ", romaji: "pya", type: .katakana, variant: .yoon),
        Kana(character: "ピュ", romaji: "pyu", type: .katakana, variant: .yoon),
        Kana(character: "ピョ", romaji: "pyo", type: .katakana, variant: .yoon)
    ]
}
