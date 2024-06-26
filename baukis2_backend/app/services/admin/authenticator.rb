class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(raw_password)
    @administrator &&
      # !@administrator.suspended? &&
      # # ↑実装するまでしばらく休止
      @administrator.hashed_password &&
      BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end

  # 「サービスオブジェクト」といい、
  # コントローラのメソッドではなく、独立したクラスとして実装される。


end
