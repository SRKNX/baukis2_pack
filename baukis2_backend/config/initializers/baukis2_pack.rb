Rails.application.configure do
  config.baukis2_pack = {
    staff:{ host: "baukis2.example.com", path: "" },
    # path:を空欄にすることで/staffが消える。
    admin:{ host: "baukis2.example.com", path: "admin" },
    customer:{ host: "example.com", path: "mypage" }
  }
  # このファイルを作ることで、hostで制約をかけられるようになる。
  # ただしもうひと工程route.rbで行う必要があるのだ

end
