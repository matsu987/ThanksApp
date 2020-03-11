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
# user1 = User.new(name: "大石尚哉", email: "naoki.oishi@di-v.co.jp", status: 1, rank: 1)
# user1.save!

# user2 = User.new(name: "長松軒昇吾", email: "shogo.chomatsuken@di-v.co.jp", status: 1, rank: 0)
# user2.save!

# user3 = User.new(name: "熊谷裕樹", email: "hiroki.kumagai@di-v.co.jp", status: 1, rank: 1)
# user3.save!

# user4 = User.new(name: "栗田ひかり", email: "hikari.kurita@di-v.co.jp", status: 1, rank: 1)
# user4.save!

# user5 = User.new(name: "奥脇真人", email: "masato.okuwaki@di-v.co.jp", status: 0, rank: 3)
# user5.save!

user6 = User.new(name: "藤井智之", email: "tomo.fujii@di-v.co.jp", status: 0, rank: 4)
user6.save!