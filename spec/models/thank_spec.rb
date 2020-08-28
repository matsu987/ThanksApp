require 'rails_helper'

RSpec.describe Thank, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with text' do
        receiver = create(:user)
        sender = create(:user)
        expect(build(:thank, receiver_id: receiver.id, sender_id: sender.id)).to be_valid
      end
    end

    context 'can not save' do

      it 'is invalid without sender' do
        receiver = create(:user)
        sender = create(:user)
        thank = build(:thank, receiver_id: receiver.id, sender_id: nil)
        thank.valid?
        expect(thank.errors[:sender]).to include("を入力してください")
      end

      it 'is invalid without receiver' do
        receiver = create(:user)
        sender = create(:user)
        thank = build(:thank, text: nil, receiver_id: nil, sender_id: sender.id)
        thank.valid?
        expect(thank.errors[:receiver]).to include("を入力してください")
      end

      it 'is invalid without text' do
        receiver = create(:user)
        sender = create(:user)
        thank = build(:thank, text: nil, receiver_id: receiver.id, sender_id: sender.id)
        thank.valid?
        expect(thank.errors[:text]).to include("を入力してください")
      end

      it 'is invalid without group' do
        receiver = create(:user)
        sender = create(:user)
        thank = build(:thank, receiver_id: receiver.id, sender_id: sender.id, group_id: nil)
        thank.valid?
        expect(thank.errors[:group]).to include("を入力してください")
      end

    end
  end
end