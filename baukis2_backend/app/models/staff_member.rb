class StaffMember < ApplicationRecord
  include StringNormalizer

  has_many :events, class_name: "StaffEvent", dependent: :destroy

  before_validation do
    self.email = normalize_as_email(email)
    self.family_name = normalize_as_name(family_name)
    self.given_name = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
  end

    HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}A-Za-z]+\z/
    KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

    validates :email, presence: true, "valid_email_2/email": true,
      uniqueness:{case_sensitive: false}
    # valid_email_2というgemを入れているのでありがたく使わせてもらう
    # だだし、「大文字小文字を区別する仕組み」になっているため変更する
    # uniqueness:{case_sensitive: false}で区別しない仕組みにできそうだ

    validates :family_name, :given_name, presence: true,
      format: {with: HUMAN_NAME_REGEXP, allow_blank: true}
      # 設定した正規表現(漢字・ひらがな・カタカナ・アルファベット以外を使用しない)でフォーマットする設定。

    validates :family_name_kana, :given_name_kana, presence: true,
      format: {with: KATAKANA_REGEXP, allow_blank: true}
      # 設定した正規表現(漢字を使用しない)でフォーマットする設定。
      # 「allow_blank: true」は、「空白でも許容する」という意味。
      # ちなみに他のバリデーションに付随する仕組みになるため、
      # 繋げたいバリデーションは「,」を入れること。

    validates :start_date, presence: true, date:{
      after_or_equal_to: Date.new(2000, 1, 1),
      before: -> (obj){1.year.from_now.to_date},
      allow_blank: true
    }
    validates :end_date, date:{
      after: :start_date,
      before: -> (obj){1.year.from_now.to_date},
      allow_blank: true
    }

    # 以上、日付のバリデーション。以下条件
    # 入社日は2000年1月1日以降、かつ今日から1年後の日付よりも前
    # 退職日は入社日よりも後で、今日から1年後の日付よりも前。空でも可
    #
    # 「after_or_equal_to」指定された日付よりも後。ただしその日も含む


  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end

end
