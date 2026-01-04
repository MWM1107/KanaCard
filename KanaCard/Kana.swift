//
//  Kana.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import Foundation

struct Kana: Identifiable, Codable {
    var id = UUID()
    let character: String // e.g., "あ"
    let romaji: String    // e.g., "a"
    let type: KanaType    // enum: .hiragana or .katakana
    
}

enum KanaType: String, Codable {
    case hiragana
    case katakana
}

extension Kana {
    static let allExamples: [Kana] = [
        // MARK: - HIRAGANA
        // Vowels
        Kana(character: "あ", romaji: "a", type: .hiragana),
        Kana(character: "い", romaji: "i", type: .hiragana),
        Kana(character: "う", romaji: "u", type: .hiragana),
        Kana(character: "え", romaji: "e", type: .hiragana),
        Kana(character: "お", romaji: "o", type: .hiragana),
        // K-Row
        Kana(character: "か", romaji: "ka", type: .hiragana),
        Kana(character: "き", romaji: "ki", type: .hiragana),
        Kana(character: "く", romaji: "ku", type: .hiragana),
        Kana(character: "け", romaji: "ke", type: .hiragana),
        Kana(character: "こ", romaji: "ko", type: .hiragana),
        // S-Row
        Kana(character: "さ", romaji: "sa", type: .hiragana),
        Kana(character: "し", romaji: "shi", type: .hiragana),
        Kana(character: "す", romaji: "su", type: .hiragana),
        Kana(character: "せ", romaji: "se", type: .hiragana),
        Kana(character: "そ", romaji: "so", type: .hiragana),
        // T-Row
        Kana(character: "た", romaji: "ta", type: .hiragana),
        Kana(character: "ち", romaji: "chi", type: .hiragana),
        Kana(character: "つ", romaji: "tsu", type: .hiragana),
        Kana(character: "て", romaji: "te", type: .hiragana),
        Kana(character: "と", romaji: "to", type: .hiragana),
        // N-Row
        Kana(character: "な", romaji: "na", type: .hiragana),
        Kana(character: "に", romaji: "ni", type: .hiragana),
        Kana(character: "ぬ", romaji: "nu", type: .hiragana),
        Kana(character: "ね", romaji: "ne", type: .hiragana),
        Kana(character: "の", romaji: "no", type: .hiragana),
        // H-Row
        Kana(character: "は", romaji: "ha", type: .hiragana),
        Kana(character: "ひ", romaji: "hi", type: .hiragana),
        Kana(character: "ふ", romaji: "fu", type: .hiragana),
        Kana(character: "へ", romaji: "he", type: .hiragana),
        Kana(character: "ほ", romaji: "ho", type: .hiragana),
        // M-Row
        Kana(character: "ま", romaji: "ma", type: .hiragana),
        Kana(character: "み", romaji: "mi", type: .hiragana),
        Kana(character: "む", romaji: "mu", type: .hiragana),
        Kana(character: "め", romaji: "me", type: .hiragana),
        Kana(character: "も", romaji: "mo", type: .hiragana),
        // Y-Row
        Kana(character: "や", romaji: "ya", type: .hiragana),
        Kana(character: "ゆ", romaji: "yu", type: .hiragana),
        Kana(character: "よ", romaji: "yo", type: .hiragana),
        // R-Row
        Kana(character: "ら", romaji: "ra", type: .hiragana),
        Kana(character: "り", romaji: "ri", type: .hiragana),
        Kana(character: "る", romaji: "ru", type: .hiragana),
        Kana(character: "れ", romaji: "re", type: .hiragana),
        Kana(character: "ろ", romaji: "ro", type: .hiragana),
        // W-Row & N
        Kana(character: "わ", romaji: "wa", type: .hiragana),
        Kana(character: "を", romaji: "wo", type: .hiragana),
        Kana(character: "ん", romaji: "n", type: .hiragana),
        
        // MARK: - HIRAGANA (Dakuten & Handakuten)
        // G-Row
        Kana(character: "が", romaji: "ga", type: .hiragana),
        Kana(character: "ぎ", romaji: "gi", type: .hiragana),
        Kana(character: "ぐ", romaji: "gu", type: .hiragana),
        Kana(character: "げ", romaji: "ge", type: .hiragana),
        Kana(character: "ご", romaji: "go", type: .hiragana),
        // Z-Row
        Kana(character: "ざ", romaji: "za", type: .hiragana),
        Kana(character: "じ", romaji: "ji", type: .hiragana),
        Kana(character: "ず", romaji: "zu", type: .hiragana),
        Kana(character: "ぜ", romaji: "ze", type: .hiragana),
        Kana(character: "ぞ", romaji: "zo", type: .hiragana),
        // D-Row
        Kana(character: "だ", romaji: "da", type: .hiragana),
        Kana(character: "ぢ", romaji: "ji", type: .hiragana),
        Kana(character: "づ", romaji: "zu", type: .hiragana),
        Kana(character: "で", romaji: "de", type: .hiragana),
        Kana(character: "ど", romaji: "do", type: .hiragana),
        // B-Row
        Kana(character: "ば", romaji: "ba", type: .hiragana),
        Kana(character: "び", romaji: "bi", type: .hiragana),
        Kana(character: "ぶ", romaji: "bu", type: .hiragana),
        Kana(character: "べ", romaji: "be", type: .hiragana),
        Kana(character: "ぼ", romaji: "bo", type: .hiragana),
        // P-Row
        Kana(character: "ぱ", romaji: "pa", type: .hiragana),
        Kana(character: "ぴ", romaji: "pi", type: .hiragana),
        Kana(character: "ぷ", romaji: "pu", type: .hiragana),
        Kana(character: "ぺ", romaji: "pe", type: .hiragana),
        Kana(character: "ぽ", romaji: "po", type: .hiragana),

        // MARK: - KATAKANA
        // Vowels
        Kana(character: "ア", romaji: "a", type: .katakana),
        Kana(character: "イ", romaji: "i", type: .katakana),
        Kana(character: "ウ", romaji: "u", type: .katakana),
        Kana(character: "エ", romaji: "e", type: .katakana),
        Kana(character: "オ", romaji: "o", type: .katakana),
        // K-Row
        Kana(character: "カ", romaji: "ka", type: .katakana),
        Kana(character: "キ", romaji: "ki", type: .katakana),
        Kana(character: "ク", romaji: "ku", type: .katakana),
        Kana(character: "ケ", romaji: "ke", type: .katakana),
        Kana(character: "コ", romaji: "ko", type: .katakana),
        // S-Row
        Kana(character: "サ", romaji: "sa", type: .katakana),
        Kana(character: "シ", romaji: "shi", type: .katakana),
        Kana(character: "ス", romaji: "su", type: .katakana),
        Kana(character: "セ", romaji: "se", type: .katakana),
        Kana(character: "ソ", romaji: "so", type: .katakana),
        // T-Row
        Kana(character: "タ", romaji: "ta", type: .katakana),
        Kana(character: "チ", romaji: "chi", type: .katakana),
        Kana(character: "ツ", romaji: "tsu", type: .katakana),
        Kana(character: "テ", romaji: "te", type: .katakana),
        Kana(character: "ト", romaji: "to", type: .katakana),
        // N-Row
        Kana(character: "ナ", romaji: "na", type: .katakana),
        Kana(character: "ニ", romaji: "ni", type: .katakana),
        Kana(character: "ヌ", romaji: "nu", type: .katakana),
        Kana(character: "ネ", romaji: "ne", type: .katakana),
        Kana(character: "ノ", romaji: "no", type: .katakana),
        // H-Row
        Kana(character: "ハ", romaji: "ha", type: .katakana),
        Kana(character: "ヒ", romaji: "hi", type: .katakana),
        Kana(character: "フ", romaji: "fu", type: .katakana),
        Kana(character: "ヘ", romaji: "he", type: .katakana),
        Kana(character: "ホ", romaji: "ho", type: .katakana),
        // M-Row
        Kana(character: "マ", romaji: "ma", type: .katakana),
        Kana(character: "ミ", romaji: "mi", type: .katakana),
        Kana(character: "ム", romaji: "mu", type: .katakana),
        Kana(character: "メ", romaji: "me", type: .katakana),
        Kana(character: "モ", romaji: "mo", type: .katakana),
        // Y-Row
        Kana(character: "ヤ", romaji: "ya", type: .katakana),
        Kana(character: "ユ", romaji: "yu", type: .katakana),
        Kana(character: "ヨ", romaji: "yo", type: .katakana),
        // R-Row
        Kana(character: "ラ", romaji: "ra", type: .katakana),
        Kana(character: "リ", romaji: "ri", type: .katakana),
        Kana(character: "ル", romaji: "ru", type: .katakana),
        Kana(character: "レ", romaji: "re", type: .katakana),
        Kana(character: "ロ", romaji: "ro", type: .katakana),
        // W-Row & N
        Kana(character: "ワ", romaji: "wa", type: .katakana),
        Kana(character: "ヲ", romaji: "wo", type: .katakana),
        Kana(character: "ン", romaji: "n", type: .katakana),

        // MARK: - KATAKANA (Dakuten & Handakuten)
        // G-Row
        Kana(character: "ガ", romaji: "ga", type: .katakana),
        Kana(character: "ギ", romaji: "gi", type: .katakana),
        Kana(character: "グ", romaji: "gu", type: .katakana),
        Kana(character: "ゲ", romaji: "ge", type: .katakana),
        Kana(character: "ゴ", romaji: "go", type: .katakana),
        // Z-Row
        Kana(character: "ザ", romaji: "za", type: .katakana),
        Kana(character: "ジ", romaji: "ji", type: .katakana),
        Kana(character: "ズ", romaji: "zu", type: .katakana),
        Kana(character: "ゼ", romaji: "ze", type: .katakana),
        Kana(character: "ゾ", romaji: "zo", type: .katakana),
        // D-Row
        Kana(character: "ダ", romaji: "da", type: .katakana),
        Kana(character: "ヂ", romaji: "ji", type: .katakana),
        Kana(character: "ヅ", romaji: "zu", type: .katakana),
        Kana(character: "デ", romaji: "de", type: .katakana),
        Kana(character: "ド", romaji: "do", type: .katakana),
        // B-Row
        Kana(character: "バ", romaji: "ba", type: .katakana),
        Kana(character: "ビ", romaji: "bi", type: .katakana),
        Kana(character: "ブ", romaji: "bu", type: .katakana),
        Kana(character: "ベ", romaji: "be", type: .katakana),
        Kana(character: "ボ", romaji: "bo", type: .katakana),
        // P-Row
        Kana(character: "パ", romaji: "pa", type: .katakana),
        Kana(character: "ピ", romaji: "pi", type: .katakana),
        Kana(character: "プ", romaji: "pu", type: .katakana),
        Kana(character: "ペ", romaji: "pe", type: .katakana),
        Kana(character: "ポ", romaji: "po", type: .katakana)

    ]
}
