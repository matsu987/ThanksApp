require "csv"

# companyテーブル
companies = [{name: "株式会社div"},{name: "株式会社ELE"}]
companies.each do |company|
  find_company = Company.where(name: company[:name])

  if find_company.length == 0
    new_company = Company.new(company)
    new_company.save!
  end
end

# groupsテーブル
groups = []

CSV.foreach('db/seeds/csv/div-groups.csv', headers: true) do |row|
  group = {
    name: row["部署名"],
    parent_group: row["親部署名"],
    company: row["会社名"]
  }
  groups << group
end

groups.each do |group|
  find_company = Company.find_by(name: group[:company])
  parent_group = Group.where(name: group[:parent_group], company_id: find_company.id)
  if parent_group.length != 0 && parent_group.first.name == group[:parent_group]
    child_groups = parent_group.first.children
    if child_groups.length != 0
      groups = []
      child_groups.each do |child_group|
        groups << child_group.name
      end
      unless groups.include?(group[:name])
        group_data = {name: group[:name], company_id: find_company.id}
        new_group = parent_group.first.children.new(group_data)
        new_group.save!
      end
    else
      group_data = {name: group[:name], company_id: find_company.id}
      new_group = parent_group.first.children.new(group_data)
      new_group.save!
    end
  else
    old_group = Group.where(name: group[:name], company_id: find_company.id)
    if old_group.length == 0
      group_data = {name: group[:name], company_id: find_company.id, ancestry: nil}
      new_group = Group.new(group_data)
      new_group.save!
    end
  end
end

#usersテーブル
users = []

CSV.foreach('db/seeds/csv/div-users.csv', headers: true) do |row|
  case row["管理者"]
  when "管理者"
    row["管理者"] = 1
  else
    row["管理者"] = 0
  end

  case row["役職1"]
  when "メンバー"
    row["役職1"] = 0
  when "チームリーダー"
    row["役職1"] = 1
  when "拠点リーダー"
    row["役職1"] = 2
  when "チーム統括"
    row["役職1"] = 3
  when "エリアリーダー"
    row["役職1"] = 4
  when "グループリーダー"
    row["役職1"] = 5
  when "ユニットリーダー"
    row["役職1"] = 6
  when "秘書"
    row["役職1"] = 7
  when "内部監査担当者"
    row["役職1"] = 8
  when "新規事業担当者"
    row["役職1"] = 9
  when "代表取締役"
    row["役職1"] = 10
  when "社長"
    row["役職1"] = 11
  when "業務委託"
    row["役職1"] = 12
  when "派遣"
    row["役職1"] = 13
  when "アルバイト"
    row["役職1"] = 14
  else
    row["役職1"] = 0
  end
  
  case row["役職2"]
  when "メンバー"
    row["役職2"] = 0
  when "チームリーダー"
    row["役職2"] = 1
  when "拠点リーダー"
    row["役職2"] = 2
  when "チーム統括"
    row["役職2"] = 3
  when "エリアリーダー"
    row["役職2"] = 4
  when "グループリーダー"
    row["役職2"] = 5
  when "ユニットリーダー"
    row["役職2"] = 6
  when "秘書"
    row["役職2"] = 7
  when "内部監査担当者"
    row["役職2"] = 8
  when "新規事業担当者"
    row["役職2"] = 9
  when "代表取締役"
    row["役職2"] = 10
  when "社長"
    row["役職2"] = 11
  when "業務委託"
    row["役職2"] = 12
  when "派遣"
    row["役職2"] = 13
  when "アルバイト"
    row["役職2"] = 14
  else
    row["役職2"] = nil
  end
    
  case row["役職3"]
  when "メンバー"
    row["役職3"] = 0
  when "チームリーダー"
    row["役職3"] = 1
  when "拠点リーダー"
    row["役職3"] = 2
  when "チーム統括"
    row["役職3"] = 3
  when "エリアリーダー"
    row["役職3"] = 4
  when "グループリーダー"
    row["役職3"] = 5
  when "ユニットリーダー"
    row["役職3"] = 6
  when "秘書"
    row["役職3"] = 7
  when "内部監査担当者"
    row["役職3"] = 8
  when "新規事業担当者"
    row["役職3"] = 9
  when "代表取締役"
    row["役職3"] = 10
  when "社長"
    row["役職3"] = 11
  when "業務委託"
    row["役職3"] = 12
  when "派遣"
    row["役職3"] = 13
  when "アルバイト"
    row["役職3"] = 14
  else
    row["役職3"] = nil
  end

  user = {
    name: row["氏名"],
    email: row["email"],
    status: row["管理者"],
    group1: row["部署名1"],
    rank1: row["役職1"],
    group1_parent: row["部署1の親部署"],
    group2: row["部署名2"],
    rank2: row["役職2"],
    group2_parent: row["部署2の親部署"],
    group3: row["部署名3"],
    rank3: row["役職3"],
    group3_parent: row["部署3の親部署"]
  }
  users << user
end

users.each do |user|
  find_user = User.where(email: user[:email])
  if find_user.length == 0
    group_ids = []
    for i in 0..2 do
      if i == 0
        parent_group = Group.where(name: user[:group1_parent]).first
        if parent_group
          find_group = parent_group.children.where(name: user[:group1])
          group_ids << find_group.first.id
        end
      elsif i == 1
        parent_group = Group.where(name: user[:group2_parent]).first
        if parent_group
          find_group = parent_group.children.where(name: user[:group2])
          group_ids << find_group.first.id
        end
      elsif i == 2
        parent_group = Group.where(name: user[:group3_parent]).first
        if parent_group
          find_group = parent_group.children.where(name: user[:group3])
          group_ids << find_group.first.id
        end
      end
    end

    user_data = {name: user[:name], email: user[:email], status: user[:status], password: "pass0000", group_ids: group_ids}
    new_user = User.new(user_data)
    new_user.save!

    for i in 0..group_ids.length do
      group_user = new_user.group_users.where(group_id: group_ids[i])
      if group_user.length != 0
        if i == 0
          group_user.first.update(rank: user[:rank1])
        elsif i == 1
          group_user.first.update(rank: user[:rank2])
        elsif i == 2
          group_user.first.update(rank: user[:rank3])
        end
      end
    end
  end
end