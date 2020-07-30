require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { build(:group)}
  describe "#create" do
    context "保存できる"  do
      it "名前がある" do
        group.valid?
        expect(group).to be_valid
      end
    end

    context "保存できない" do
      it "名前が入力されていない" do
        no_name_group = build(:group, name: nil)
        no_name_group.valid?
        expect(no_name_group.errors[:name]).to include("を入力してください")
      end
    end
  end

  describe "ancestryが正しく機能する" do
    context "階層ごとにgroupが保存できる" do
      it "rootがcompanyと同じもので登録されている" do
        root_group = create(:group)
        expect(root_group.depth).to eq 0
      end

      it "親部署が登録できる" do
        root_group = create(:group, :have_parent)
        parent_group =  root_group.children[0]  
        expect(parent_group.depth).to eq 1
      end

      it "子部署部署が登録できる" do
        root_group = create(:group, :have_child)
        child_group =  root_group.children[0].children[0]  
        expect(child_group.depth).to eq 2
      end

      it "孫部署が登録できる" do
        root_group = create(:group, :have_grand_child)
        grand_child_group =  root_group.children[0].children[0].children[0] 
        expect(grand_child_group.depth).to eq 3
      end
    end

  end

  describe "#data_custom" do
    context "値が正しく返ってくる" do
      it "companyが渡されていた時に会社の情報を返している" do
        company = create(:company)
        root_group =  create(:group)
        info = root_group.data_custom([], company, nil, nil, nil)
        expect(info[0][:company][:name]).to eq company.name
        expect(info[0][:company][:id]).to eq company.id
      end

      it "親部署が渡されていた時に会社の情報を返している" do
        company = create(:company)
        root_group =  create(:group, :have_parent)
        parent_group = root_group.children[0]
        info = root_group.data_custom([], company, parent_group, nil, nil)
        expect(info[0][:parent_group][:name]).to eq parent_group.name
        expect(info[0][:parent_group][:id]).to eq parent_group.id
      end

      it "子部署が渡されていた時に会社の情報を返している" do
        company = create(:company)
        root_group = create(:group, :have_child)
        parent_group = root_group.children[0]
        child_group =  root_group.children[0].children[0]  
        info = root_group.data_custom([], company, parent_group, child_group, nil)
        expect(info[0][:child_group][:name]).to eq child_group.name
        expect(info[0][:child_group][:id]).to eq child_group.id
      end

      it "孫部署が渡されていた時に会社の情報を返している" do
        company = create(:company)
        root_group = create(:group, :have_grand_child)
        parent_group = root_group.children[0]
        child_group = root_group.children[0].children[0]
        grand_child_group =  root_group.children[0].children[0].children[0] 
        info = root_group.data_custom([], company, parent_group, child_group, grand_child_group)
        expect(info[0][:grandchild_group][:name]).to eq grand_child_group.name
        expect(info[0][:grandchild_group][:id]).to eq grand_child_group.id
      end      
    end

  end
end
