class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events
      # @events = @staff_member.events.order(occurred_at: :desc)
      # orderで並べ替え。「occurred_at」は「created_at」の別名と思ったんでよし
    else
      # @events = StaffEvent.order(occurred_at: :desc)
      @events = StaffEvent
    end
    # # 上の式で、2回「.order(occurred_at: :desc)」が出て被っていたので、
    # # 下の式に統一。
    # @events = @events.order(occurred_at: :desc)
    #
    # @events = @events.include(:member)
    # n+1問題に対応開始。
    # データの読み込みが複数モデル跨ぐときはincludeを使うのがおすすめだ。
    #
    # @events = @events.page(params[:page])

    @events = @events.page(params[:page]).include(:member).order(occurred_at: :desc)
    # 上の式をまとめてさらに単純化。

  end
end
