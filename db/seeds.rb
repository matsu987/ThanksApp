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
  groups = [{name: "事業推進ユニット", company: "株式会社div", parent: ""},
  {name: "オペレーション_転職", company: "株式会社div", parent: "事業推進ユニット"},
  {name: "メンターチーム東日本統括", company: "株式会社div", parent: "オペレーション_転職"},
  {name: "メンターチーム東京統括", company: "株式会社div", parent: "メンターチーム東日本統括"},
  {name: "東京1（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京2（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京3（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京4（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  {name: "東京5（エンジニア）", company: "株式会社div", parent: "メンターチーム東京統括"},
  ]
  groups.each do |group|
    find_company = Company.find_by(name: group[:company])
    find_group = Group.where(name: group[:name], company_id: find_company.id)
    if find_group.length == 0
      parent_group = Group.where(company_id: find_company.id, name: group[:parent])
      if parent_group.length == 0  #ルートグループの作成
        group_data = {name: group[:name], company_id: find_company.id, ancestry: nil}
        new_group = Group.new(group_data)
      else  #子グループ作成
        group_data = {name: group[:name], company_id: find_company.id}
        new_group = parent_group.first.children.new(group_data)
      end
      new_group.save!
    end
  end

users = [{name: "大石尚哉", email: "naoki.oishi@di-v.co.jp", status: 1, rank: 1, group: "東京2（エンジニア）"},
  {name: "長松軒昇吾", email: "shogo.chomatsuken@di-v.co.jp", status: 1, rank: 0, group: "東京1（エンジニア）"},
  {name: "熊谷裕樹", email: "hiroki.kumagai@di-v.co.jp", status: 1, rank: 1, group: "東京1（エンジニア）"},
  {name: "栗田ひかり", email: "hikari.kurita@di-v.co.jp", status: 1, rank: 1, group: "東京2（エンジニア）"},
  {name: "奥脇真人", email: "masato.okuwaki@di-v.co.jp", status: 0, rank: 3, group: "メンターチーム東日本統括"},
  {name: "藤井智之", email: "tomo.fujii@di-v.co.jp", status: 0, rank: 4, group: "オペレーション_転職"}
]

users.each do |user|
  find_user = User.where(email: user[:email])
  if find_user.length == 0
    find_group = Group.where(name: user[:group])
    user_data = {name: user[:name], email: user[:email], status: user[:status], rank: user[:rank]}
    new_user = find_group.first.users.new(user_data)
    new_user.save!
  end
end