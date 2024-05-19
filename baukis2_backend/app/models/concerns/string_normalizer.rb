require "nkf"

module StringNormalizer
  extend ActiveSupport::Concern

  def normalize_as_email(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  def normalize_as_name(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  def normalize_as_furigana(text)
    NKF.nkf("-W -w -Z1 --katakana", text).strip if text
    # -W : 文字の入力コードをutf8と仮定する
    # -w : utf8で出力する
    # -Z1 : 全角英数、記号、全角スペースを半角に変換する
    # --katanaka : ひらがなをカタカナに変換する
  end


end
