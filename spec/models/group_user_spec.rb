require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  describe '#create' do
    let(:user) {create(:user)}
    let(:group) { create(:group) }
    let(:member) { build(:group_user, user: user, group: group) }

    context "値が正しい場合" do
      it 'group_user生成に紐づいてuserとgroupが生成されていること' do
        expect(member.user.present?).to be true
        expect(member.group.present?).to be true
      end
      it '外部キーを用いて中間テーブルの作成に成功していること' do
        expect {
          member.save
        }.to change{ GroupUser.count }.by(1)
      end
      context '中間テーブルに保存されている外部キーが正しい場合' do
        it 'user_idの値が正しい場合' do
          expect(member.user.id).to eq user.id
        end
        it 'group_idの値が正しい場合' do
          expect(member.group.id).to eq group.id
        end
      end
    end

    context "値が不正の場合" do
      context "特定のカラムが空の場合" do
        it "rankカラムが空であること" do
          member.rank = nil
          member.valid?
          expect(member.errors[:rank]).to include("を入力してください")
        end
        it "statusカラムが空であること" do
          member.status = nil
          member.valid?
          expect(member.errors[:status]).to include("を入力してください")
        end
        it '同じ組み合わせがDBに保存されるとき' do
          member.save
          another_member = build(:group_user, user: user, group: group)
          another_member.valid?
          expect(member.errors[:group_id]).to include("はすでに存在します")
        end
      end
    end
  end
end