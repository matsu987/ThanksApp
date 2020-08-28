require 'rails_helper'

RSpec.describe "Messages", type: :system do
  let(:user) {create(:user)}

  it 'メッセージ入力画面を表示すること' do
    sign_in(user)

    create_group()

    expect(page).to have_content "新規作成"

    find('.new').click

    expect(page).to have_selector "div[class='overlay']"
  end

  context 'メッセージ送信機能' do
    let(:another_user) {create(:user)}

    it 'メッセージ送信が成功すること' do
      sign_in(user)

      create_group()

      create(:group_user, user: another_user, group:  user.groups[0])

      find('.new').click

      click_on('感謝を送りたい人を選択')

      find(".groups-content__result__box").click

      expect(page).to have_content "#{another_user.family_name}#{another_user.given_name}さん"

      find(".users-content__result__box__name").click

      click_on('宛先を決定')

      expect(page).to have_content "To: #{another_user.family_name}#{another_user.given_name}さん"

      find("textarea").set("test")

      click_on("確定")

      expect(page).to have_content "投稿が完了しました！"
      click_on('Close')

      within '.send-confirm' do
        expect(page).to have_selector '.countbox_num', text: 1
      end
      within '.send-count' do
        expect(page).to have_selector '.countbox_num', text: 1
      end
      # TODO: hrefが仮置きのため遷移先が固定されている
      # expect(current_path).to eq user_letters_send_path(user.id)
    end

    context 'メッセージ作成' do
      before do
        prepare_message(user, another_user)
      end
      it 'メッセージを保存せずに終了することができること' do

        click_on("保存せずに閉じる")

        expect(page).to have_no_selector "div[class='overlay']"
      end
      it 'メッセージを保存せずに一時保存できること' do
        message = "めっちゃありがとうやで！"

        find("textarea").set(message)
        click_on("一時保存")

        expect(page).to have_content "投稿が完了しました！"
        click_on('Close')

        expect(page).to have_content "編集中"
        expect(page).to have_content message
        expect(page).to have_content "#{another_user.family_name}#{another_user.given_name}さん"

      end
      it 'メッセージを入力せずには確定できないこと' do

        click_on("一時保存")

        expect(page).to have_content "「熱い感謝のメッセージ」を入力してください"
      end
    end

    context 'メッセージ編集' do
      it 'メッセージ編集に成功すること' do
        message = "text"
        updated_message = "message is updated"
        prepare_message(user, another_user)
        find("textarea").set(message)

        click_on("確定")

        click_on('Close')

        find('.content').click

        find("textarea").set(updated_message)

        click_on("確定")

        expect(page).to have_content "更新が完了しました！"
        click_on('Close')

        expect(page).to have_content updated_message
      end
    end
  end
end
