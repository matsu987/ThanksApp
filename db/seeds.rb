# require "csv"

# # ユニット一覧
# u_marketing,u_business_promotion = Group.create([{name: "マーケティング"}, {name: "事業推進"}])

# # グループ一覧
# g_marketing,g_engineer,g_design,g_sales_promotion,g_contents,g_public_relations = u_marketing.children.create([{name: "マーケティング"},{name: "開発"},{name: "デザイン"},{name: "セールス企画"},{name: "コンテンツ"},{name: "広報"}])

# g_operation_tc,g_operation_exp,g_carrieer_support,g_sales,g_customer_support,g_business_solution,g_development,g_operation_management = u_business_promotion.children.create([{name: "オペレーションTC"},{name: "オペレーションEXP"},{name: "キャリアサポート"},{name: "セールス"},{name: "カスタマーサポート"},{name: "ビジネスソリューション"},{name: "拠点開発"},{name: "オペレーション管理"}])


# # チーム一覧
# customer_management,tech_master,tech_payment = g_engineer.children.create([{name: "顧客管理"},{name: "TECH::MASTER"},{name: "TECH::PAYMENT"}])



# CSV.foreach('db/seeds/csv/thanks_app_user.csv', headers: true) do |row|
#   User.create(
#     name: row['name'],
#     email: row['email'],
#     introduction: row['introduction'],
#     status: row['status'],
#     password: row['password']
#   )
# end

# CSV.foreach('db/seeds/csv/thanks_app_group_users.csv', headers: true) do |row|
#   GroupUser.create(
#     group_id: row['group_id'],
#     user_id: row['user_id'],
#     status: row['status']
#   )
# end



# companyテーブル
companies = [{name: "株式会社div"}]
companies.each do |company|
  find_company = Company.where(name: company[:name])

  if find_company.length == 0
    new_company = Company.new(company)
    new_company.save!
  end
end

# groupsテーブル

  groups = [
  {name: "事業推進ユニット", company: "株式会社div", parent: ""},
  {name: "オペレーション_転職", company: "株式会社div", parent: "事業推進ユニット"},
  # エンジニア転職（エンジニアメンター）
  {name: "メンターチーム東日本統括", company: "株式会社div", parent: "オペレーション_転職"},
  {name: "メンターチーム東京統括", company: "株式会社div", parent: "メンターチーム東日本統括"},
  {name: "東京1（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京2（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京3（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京4（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京5（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京メンター教育チーム（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京メンター管理チーム（エンジニア）", company: "株式会社div", parent: "メンターチーム東日本統括"},
  # エンジニア転職（エンジニアライフコーチ）
  {name: "ライフコーチチーム東日本統括", company: "株式会社div", parent: "オペレーション_転職"},
  {name: "ライフコーチチーム東京統括", company: "株式会社div", parent: "ライフコーチチーム東日本統括"},
  {name: "東京1（エンジニアLC）", company: "株式会社div", parent: "ライフコーチチーム東京統括"},
  {name: "東京2（エンジニアLC）", company: "株式会社div", parent: "ライフコーチチーム東京統括"},
  {name: "東京3（エンジニアLC）", company: "株式会社div", parent: "ライフコーチチーム東京統括"},
  {name: "東京4（エンジニアLC）", company: "株式会社div", parent: "ライフコーチチーム東京統括"},
  {name: "東京教室管理チーム（ライフコーチ）", company: "株式会社div", parent: "ライフコーチチーム東京統括"},
  {name: "東京ライフコーチサポートチーム", company: "株式会社div", parent: "ライフコーチチーム東京統括"},
  {name: "東京ライフコーチ管理チーム", company: "株式会社div", parent: "ライフコーチチーム東日本統括"},
  # エンジニア転職（デザインメンター）
  {name: "デザインメンターチーム統括", company: "株式会社div", parent: "オペレーション_転職"},
  {name: "東京1（デザイン）", company: "株式会社div", parent: "デザインメンターチーム統括"},
  {name: "東京メンター管理チーム（デザイン）", company: "株式会社div", parent: "デザインメンターチーム統括"},
  #エンジニア転職（デザインライフコーチ）
  {name: "デザインライフコーチチーム統括", company: "株式会社div", parent: "オペレーション_転職"},
  {name: "東京1（デザインLC）", company: "株式会社div", parent: "デザインライフコーチチーム統括"},
  {name: "東京教室管理チーム（デザイン）", company: "株式会社div", parent: "デザインライフコーチチーム統括"},
  ]
  groups.each do |group|
    find_company = Company.find_by(name: group[:company])
    find_groups = Group.where(name: group[:name], company_id: find_company.id)
    parent_group = Group.where(company_id: find_company.id, name: group[:parent])
    if find_groups.length == 0
      if parent_group.length == 0  #ルートグループの作成
        group_data = {name: group[:name], company_id: find_company.id, ancestry: nil}
        new_group = Group.new(group_data)
      else  #子グループ作成
        group_data = {name: group[:name], company_id: find_company.id}
        new_group = parent_group.first.children.new(group_data)
      end
      new_group.save!
    else
      groups = []
      find_groups.each do |find_group|
        if find_group.parent != nil
          groups << find_group.parent.name
        end
      end
      if groups.length != 0
        unless groups.include?(group[:parent])
          group_data = {name: group[:name], company_id: find_company.id}
          new_group = parent_group.first.children.new(group_data)
          new_group.save!
        end
      end
    end
  end

# ユーザー（オペレーション転職）
users = [
  #オペレーション_転職（GL）
  {name: "藤井智之", email: "tomo.fujii@di-v.co.jp", status: 0, rank1: 4, rank2: 0, rank3: 0, group1: "オペレーション_転職", group2: "", group3: ""},
  #メンターチーム東日本統括
  {name: "奥脇真人", email: "masato.okuwaki@di-v.co.jp", status: 0, rank1: 3, rank2: 3, rank3: 0, group1: "メンターチーム東日本統括", group2: "デザインメンターチーム統括", group3: ""},
  #メンターチーム東京統括
  {name: "栗原秀虎", email: "hidetake.kurihara@di-v.co.jp", status: 0, rank1: 2, rank2: 0, rank3: 0, group1: "メンターチーム東京統括", group2: "", group3: ""},
  #東京1（エンジニア）
  {name: "熊谷裕樹", email: "hiroki.kumagai@di-v.co.jp", status: 1, rank1: 1, rank2: 0, rank3: 0, group1: "東京1（エンジニア）", group2: "", group3: ""},
  {name: "櫻井駿介", email: "shunsuke.sakurai@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニア）", group2: "東京1（デザインLC）", group3: ""},
  {name: "馬場惇史郎", email: "baba.junshiro@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニア）", group2: "", group3: ""},
  {name: "長松軒昇吾", email: "shogo.chomatsuken@di-v.co.jp", status: 1, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニア）", group2: "", group3: ""},
  {name: "石山玲央奈", email: "reona.ishiyama@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニア）", group2: "", group3: ""},
  #東京2（エンジニア）
  {name: "大石尚哉", email: "naoki.oishi@di-v.co.jp", status: 1, rank1: 1, rank2: 0, rank3: 0, group1: "東京2（エンジニア）", group2: "", group3: ""},
  {name: "杉山了紀", email: "akinori.sugiyama@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニア）", group2: "", group3: ""},
  {name: "千葉良晴", email: "yoshiharu.chiba@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニア）", group2: "", group3: ""},
  {name: "豊田優士", email: "yushi.toyoda@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニア）", group2: "", group3: ""},
  {name: "飯尾瑞貴", email: "mizuki.iio@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニア）", group2: "", group3: ""},
  {name: "久島珠奈", email: "juna.kujima@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニア）", group2: "", group3: ""},
  #東京3（エンジニア）
  {name: "島田裕之", email: "hiroyuki.shimada@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京3（エンジニア）", group2: "", group3: ""},
  {name: "櫻井昌也", email: "masaya.sakurai@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニア）", group2: "", group3: ""},
  {name: "河内せな", email: "sena.kawauchi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニア）", group2: "", group3: ""},
  {name: "麦倉啓暉", email: "hiroki.mugikura@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニア）", group2: "", group3: ""},
  {name: "佐藤佑華", email: "yuka.sato@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニア）", group2: "", group3: ""},
  #東京4（エンジニア）
  {name: "田中剛貴", email: "goki.tanaka@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京4（エンジニア）", group2: "", group3: ""},
  {name: "静野宗貢", email: "munetsugu.shizuno@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニア）", group2: "", group3: ""},
  {name: "近森裕士", email: "hiroshi.chikamori@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニア）", group2: "", group3: ""},
  {name: "麓大地", email: "daichi.fumoto@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニア）", group2: "", group3: ""},
  {name: "中田真日己", email: "masahiko.nakata@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニア）", group2: "", group3: ""},
  #東京5（エンジニア）
  {name: "本間直人", email: "naoto.honma@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京5（エンジニア）", group2: "", group3: ""},
  {name: "滝口裕作", email: "yusaku.takiguchi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京5（エンジニア）", group2: "", group3: ""},
  {name: "荒木真", email: "makoto.araki@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京5（エンジニア）", group2: "", group3: ""},
  #東京メンター教育チーム（エンジニア）
  {name: "岩崎史弥", email: "goki.tanaka@di-v.co.jp", status: 0, rank1: 1, rank2: 1, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "東京メンター管理チーム（エンジニア）", group3: ""},
  {name: "海津若菜", email: "wakana.kaizu@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "東京メンター管理チーム（エンジニア）", group3: ""},
  {name: "砂川彩奈", email: "ayana.sunakawa@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "千葉翔太", email: "shota.chiba@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},

  {name: "城戸風馬", email: "fuma.kido@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "奈良達也", email: "tatsuya.nara@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "沖津明日見", email: "asumi.okitsu@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "皆川達郎", email: "tatsuro.minagawa@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "栗田謙人", email: "kento.kurita@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "丸山春香", email: "haruka.maruyama@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "森山凪", email: "nagi.moriyama@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "宮﨑智治", email: "tomoharu.miyazaki@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "脇田康仁", email: "yasuhito.wakita@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "髙橋瑞樹", email: "mizuki.takahashi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  {name: "平野雅大", email: "masahiro.hirano@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター教育チーム（エンジニア）", group2: "", group3: ""},
  #東京メンター管理チーム（エンジニア）
  #ライフコーチチーム東日本統括
  {name: "佐々木良央", email: "yoshiteru.sasaki@di-v.co.jp", status: 0, rank1: 3, rank2: 3, rank3: 0, group1: "ライフコーチチーム東日本統括", group2: "デザインライフコーチチーム統括", group3: ""},
  #ライフコーチチーム東京統括
  #東京1（エンジニアLC）
  {name: "竹井裕子", email: "yuko.takei@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京1（エンジニアLC）", group2: "東京教室管理チーム（ライフコーチ）", group3: ""},
  {name: "中森直也", email: "naoya.nakamori@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニアLC）", group2: "", group3: ""},
  {name: "菊地勝人", email: "masato.kikuchi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニアLC）", group2: "", group3: ""},
  {name: "北田彩", email: "aya.kitada@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニアLC）", group2: "", group3: ""},
  {name: "湯澤みなみ", email: "minami.yuzawa@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニアLC）", group2: "", group3: ""},
  #東京2（エンジニアLC）
  {name: "久保敦史", email: "atsushi.kubo@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京2（エンジニアLC）", group2: "", group3: ""},
  {name: "金澤紗由里", email: "sayuri.kanazawa@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニアLC）", group2: "", group3: ""},
  {name: "辻本尊之", email: "takayuki.tsujimoto@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニアLC）", group2: "", group3: ""},
  {name: "佐藤千寛", email: "chihiro.sato@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニアLC）", group2: "", group3: ""},
  {name: "多久美智子", email: "michiko.taku@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニアLC）", group2: "", group3: ""},
  {name: "峯崎康太", email: "kota.minezaki@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京2（エンジニアLC）", group2: "", group3: ""},
  #東京3（エンジニアLC）
  {name: "鶴岡篤人", email: "atsuto.tsuruoka@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  {name: "小出恵理奈", email: "erina.koide@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  {name: "酒井瑛", email: "akira.sakai@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  {name: "和泉秀明", email: "hideaki.izumi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  {name: "大谷栞", email: "shiori.otani@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  {name: "竹内達郎", email: "tatsuro.takeuchi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  {name: "窪田あかり", email: "akari.kubota@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京3（エンジニアLC）", group2: "", group3: ""},
  #東京4（エンジニアLC）
  {name: "岩田あゆむ", email: "ayumu.iwata@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京4（エンジニアLC）", group2: "", group3: ""},
  {name: "市村穂高", email: "hodaka.ichimura@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニアLC）", group2: "", group3: ""},
  {name: "牧孝俊", email: "takatoshi.maki@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニアLC）", group2: "", group3: ""},
  {name: "千葉郁人", email: "fumito.chiba@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニアLC）", group2: "", group3: ""},
  {name: "髙橋宗右", email: "shusuke.takahashi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニアLC）", group2: "", group3: ""},
  {name: "定木海帆", email: "miho.sadaki@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京4（エンジニアLC）", group2: "", group3: ""},
  #東京教室管理チーム（ライフコーチ）
  #東京ライフコーチサポートチーム
  {name: "佐竹柚香", email: "yuka.satake@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "東京4（エンジニアLC）", group3: ""},
  {name: "礒田航平", email: "kohei.isoda@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "", group3: ""},
  {name: "児玉啓督", email: "keisuke.kodama@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "", group3: ""},
  {name: "山本美憂", email: "miyu.yamamoto@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "", group3: ""},
  {name: "三浦靖奈", email: "yasuna.miura@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "", group3: ""},
  {name: "奥村見依子", email: "mieko.okumura@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "", group3: ""},
  {name: "梅田千里", email: "chisato.umeda@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京ライフコーチサポートチーム", group2: "", group3: ""},
  #東京ライフコーチ管理チーム
  {name: "高野快", email: "kai.takano@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group: "東京ライフコーチ管理チーム", group2: "", group3: ""},
  #東京1（デザイン）
  {name: "栗田ひかり", email: "hikari.kurita@di-v.co.jp", status: 1, rank1: 1, rank2: 0, rank3: 0, group1: "東京1（デザイン）", group2: "", group3: ""},
  {name: "足立浩平", email: "kohei.adachi@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（デザイン）", group2: "東京教室管理チーム（デザイン）", group3: ""},
  {name: "國見愛", email: "kunimi.ai@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（デザイン）", group2: "", group3: ""},
  {name: "松浦舞", email: "mai.matsura@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（デザイン）", group2: "", group3: ""},
  #東京メンター管理チーム（デザイン）
  {name: "鈴木将太", email: "shota.suzuki@di-v.co.jp", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京メンター管理チーム（デザイン）", group2: "", group3: ""},
  {name: "粟飯原匠", email: "takumi.aihara@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター管理チーム（デザイン）", group2: "", group3: ""},
  #東京1（デザインLC）
  # {name: "山本圭志朗", email: "kuu01050105@gmail.com", status: 0, rank1: 1, rank2: 0, rank3: 0, group1: "東京メンター管理チーム（デザイン）", group2: "東京教室管理チーム（デザイン）", group3: ""},
  {name: "青屋名摘子", email: "natsuko.aoya@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター管理チーム（デザイン）", group2: "", group3: ""},
  {name: "田後はるか", email: "haruka.tago@di-v.co.jp", status: 0, rank1: 0, rank2: 0, rank3: 0, group1: "東京メンター管理チーム（デザイン）", group2: "", group3: ""},
  #東京教室管理チーム（デザイン）
]

# users = [{name: "長松軒昇吾", email: "shogo.chomatsuken@di-v.co.jp", status: 1, rank1: 0, rank2: 0, rank3: 0, group1: "東京1（エンジニア）", group2: "", group3: ""}]
users.each do |user|
  find_user = User.where(email: user[:email])
  if find_user.length == 0
    find_group1 = Group.where(name: user[:group1])
    find_group2 = Group.where(name: user[:group2])
    find_group3 = Group.where(name: user[:group3])
    groups = [find_group1.first, find_group2.first, find_group3.first]
    group_ids = []
    for i in 0..2 do
      if groups[i] != nil
        group_ids << groups[i].id
      end
    end
    user_data = {name: user[:name], email: user[:email], status: user[:status], group_ids: group_ids}
    new_user = User.new(user_data)
    new_user.save!

    for i in 1..group_ids.length do
      group_user = new_user.group_users.where(group_id: group_ids[i - 1])
      if i == 1
        group_user.first.update(rank: user[:rank1])
      elsif i == 2
        group_user.first.update(rank: user[:rank2])
      elsif i == 3
        group_user.first.update(rank: user[:rank3])
      else
      end
    end
  end
end