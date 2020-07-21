require "rails_helper"

RSpec.describe User, type: :model do
  describe "#create" do
    let(:user) { build(:user) }

    context "値が正しい場合" do
      it "全てのカラム情報が正しいこと" do
        expect(user).to be_valid
      end
      it "DBにレコードが保存されること" do
        expect{ user.save }.to change{ User.count }
      end

      context "正規表現によるバリデーション動作が正しい場合" do

        it "passwordカラムに設定した正規表現のバリデーションが正しく動作していること" do
          user.password, user.password_confirmation = create_random_string(0, 6)
          expect(user).to be_valid
        end

        it "emailを小文字に変換後の値と大文字を混ぜて登録されたアドレスが同じ文字列であること" do
          user.email = "Foo@ExAMPle.CoM"
          user.save
          expect(user.reload.email).to eq "foo@example.com"
        end
      end
    end

    context "値が不正な場合" do
      context "カラムの値が空でエラーが発生する場合" do
        it "family_nameカラムが空であること" do
          user.family_name = nil
          user.valid?
          expect(user.errors[:family_name]).to include("を入力してください")
        end

        it "given_nameカラムが空であること" do
          user.given_name = nil
          user.valid?
          expect(user.errors[:given_name]).to include("を入力してください")
        end

        it "emailカラムが空であること" do
          user.email = nil
          user.valid?
          expect(user.errors[:email]).to include("を入力してください")
        end

        it "passwordカラムが空であること" do
          user.password = nil
          user.valid?
          expect(user.errors[:password]).to include("を入力してください")
        end

        it "password_confirmationカラムが空であること" do
          user.password_confirmation = ""
          user.valid?
          expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
        end
      end

      context "email_custom_errorメソッドが実行される場合" do
        it "emailが空であること" do
          user.email = nil
          user.valid?
          expect(user.email.blank?).to be true
          expect(user.errors[:email]).to include("を入力してください")
        end
        it "emailに設定した正規表現のバリデーションが正しく動作していること" do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
          addresses.each do |invalid_address|
            user.email = addresses
            user.valid?
            expect(user).to be_invalid
            expect(user.errors[:email]).to include("は不適切な値です")
          end
        end
      end

      it "passwordカラムに代入されている値が5文字だと保存できないこと" do
        user.password, user.password_confirmation = create_random_string(0, 5)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "重複したemailはDBに保存できないこと" do
        user.save
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end
    end
  end
end