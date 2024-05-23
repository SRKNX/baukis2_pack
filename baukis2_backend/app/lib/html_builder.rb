module HtmlBuilder
  def markup(tag_name = nil, options = {})
    # HtmlBuilderで作成するメソッドはmarkupメソッドのみ。
    root = Nokogiri::HTML::DocumentFragment.parse("")

    Nokogiri::HTML::Builder.with(root) do |doc|
      if tag_name
        doc.method_missing(tag_name, options) do
          yield(doc)
        end
      else
        yield(doc)
      end


    end
    root.to_html.html_safe

  end
end
# この「HtmlBuilder」を併用すれば、htmlコードがさらに綺麗に整理できるぞ。
# …現時点詳細は不明である！
# HtmlBuilderでのコーディングはメンテナンス性が高くなる。
# その一方、ruby言語が読めない人には抵抗が強く集団開発では不都合かも。
