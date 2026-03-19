"""
特殊詞例外表 — pronunciate 或分析引擎無法正確處理的詞。
analyze_word() 優先查此表，命中則直接回傳預設結果。

格式: {泰文: {syllables: [{onset, vowel, vowel_ipa, coda, tone, ho_nam}], rtgs: str}}
只需提供音節分解，analyze_word() 會自動組裝完整的 WordAnalysis。
"""

WORD_OVERRIDES: dict[str, dict] = {
    # หาว: pronunciate 錯誤把 หาว→หวาว，造成 ห นำ 誤判
    # 正確: ห=/h/ 初始, า 長元音, ว 韻尾
    "หาว": {
        "rtgs": "hao",
        "syllables": [
            {"onset": "ห", "onset_ipa": "/h/", "vowel": "า", "vowel_ipa": "/aː/",
             "coda": "ว", "tone": "rise", "ho_nam": False,
             "zh_onset": "像「哈」的 h，氣流輕送",
             "zh_vowel": "長元音，像「啊——」",
             },
        ],
    },
}
