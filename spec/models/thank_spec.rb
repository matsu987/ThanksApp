require 'rails_helper'

RSpec.describe Thank, type: :model do
  describe '#create' do

    let(:user) { create(:user) }
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }

    context '現在実装されている機能' do
      context 'thanksメッセージが保存できる' do
        it 'メッセージテキストが有効' do
          valid_thank = build(:thank) 
          expect(valid_thank).to be_valid
        end
      end

      context 'thanksメッセージが保存できない' do
        
        it '送信者が無効の場合' do
          no_sender_thank = build(:thank, sender_id: nil)
          no_sender_thank.valid?
          expect(no_sender_thank.errors[:sender]).to include("を入力してください")
        end

        it '受信者の設定ができていない' do
          no_reciever_thank = build(:thank, receiver_id: nil)
          no_reciever_thank.valid?
          expect(no_reciever_thank.errors[:receiver]).to include("を入力してください")
        end

        it 'メッセージテキストがない' do
          no_text_thank = build(:thank, text: nil)
          no_text_thank.valid?
          expect(no_text_thank.errors[:text]).to include("を入力してください")
        end
      end
    end

    context '今後実装したい機能' do
      # 送信者一覧を機能するJSで自分以外が候補として出てくる仕様になっているかと思うが、
      # 送信者リストに乗ってしまっていた時のためにテストが必要？ 現在trueになる
      # it '送信者と受信者が同一' do
      #   myself_thank = build(:thank, receiver_id: user.id, sender_id: user.id)
      #   myself_thank.valid?
      #   expect().to include()
      # end

      # 送信者一覧を機能するJSで一度送信した人が候補として出てこない仕様になっているかと思うが、
      # 送信者リストに乗ってしまっていた時のためにテストが必要？　現在trueになる
      # it '同月に同じ受信者あてに新しいメッセージを送っている' do
      #   first_thank = create(:thank, receiver_id: receiver.id)        
      #   same_receiver_thank = build(:thank, receiver_id: receiver.id)
      #   expect().to include()
      # end

      # 現在のところ月が切り替わったタイミングリセットされていない。
      # どのような実装方法か相談する必要があり。
      # ①(JS側)宛先リストを月が変われば全部リセットして読み込む方法
      # ②(バックエンド側)送信履歴を管理するテーブルを作成する
      # 個人的な意見としては②のバックエンドで管理した方がテストがしやすい。今後パワープレイをしなくて済むかと思われる。
      # it '月が変われば送信したかどうかがリセットされる' do
      #   first_thank = create(:thank, receiver_id: receiver.id)        
      #   same_receiver_thank = build(:thank, receiver_id: receiver.id)
      #   expect().to include()
      # end

    end    
  end

  # 既読か編集中かどうかのチェック用
  # describe '#update' do 
  # end
end