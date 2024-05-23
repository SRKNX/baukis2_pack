class ModelPresenter
  include HtmlBuilder
  # app/lib/html_builder.rb
  # を読み込んだ。

  attr_reader :object, :view_context

  # delegate :raw, to: :view_context
  delegate :raw, :link_to, to: :view_context
  # 利用したい機能を、delegateでビューコンテクストに同期させて。利用可能にする。

  # def initializers(object, view_context)
  def initialize(object, view_context)
    @object = object
    # objectはモデルとして作ったDBの値
    @view_context = view_context
    # view_contextはrailsで使用する関数を表してるらしい。
  end

  # viewファイルで行う処理は、もっぱらpresenterで行うのだ。
  # 例えば、views/admin/staff_members/index.html.erbでいえば
  #  m.suspended? ? raw("&#x2611;") : raw("&#x2610;")
  # などはできればメソッドとして簡略化したいはず。
  #
  # hepler.rbでは運営を進めて新しいメソッドを作るときに
  # 名前が被らないように気を使う必要があるので大変だ。
  # StaffMemberクラスへの割り当ても考えられるが、
  # 無駄な仕事をさせてしまうことになるだろう。
  #
  # ということで、
  # viewファイルで行う処理は、presenterである。


end
