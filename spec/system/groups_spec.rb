require 'rails_helper'

RSpec.describe "Groups", type: :system do
  let(:user) {create(:user)}

  context '正しくページ遷移できる場合' do
    it 'グループ新規登録画面へ繊維すること' do
      sign_in(user)

      click_on('新規登録')

      expect(current_path).to eq new_group_path

    end
    # TODO:仮置きのherfを修正する
    # it 'グループ編集画面へ繊維すること' do
    #   sign_in(user)

    #   click_on('選択')

    #   expect(current_path).to eq edit_user_path(user.id)
    # end
  end

  context 'グループの新規登録機能' do
    it '新しいグループを全て作成すること' do
      sign_in(user)

      company_name = "株式会社樋口カンパニー"
      company_parent_name = "コンテンツ"
      company_child_name = "教材開発"
      company_grand_child_name = "樋口応用チーム"

      post_number = "123-4567"
      address = "東京都新宿丸の内ビル"
      phone_number = "090-1234-5678"

      click_on('新規登録')

      find("input[placeholder='例）株式会社〇〇〇〇']").set(company_name)
      find("input[placeholder='例）123-xxxx']").set(post_number)
      find("input[placeholder='例）東京都〇〇区〇〇〇〇']").set(address)
      find("input[placeholder='例）0120-1234-xxxx']").set(phone_number)

      find("input[type='submit']").click

      expect(page).to have_content('登録が完了しました！')
      expect(page).to have_content('ユーザー設定画面から部署に参加してください')

      click_on('Close')

      expect(page).to have_selector "section[class='group']"
      expect(page).to have_selector "option", text: company_name
      expect(page).to have_selector "input[placeholder='親部署名']"

      find("input[placeholder='親部署名']").set(company_parent_name)

      expect(page).to have_selector "input[placeholder='子部署名']"

      find("input[placeholder='子部署名']").set(company_child_name)

      expect(page).to have_selector "input[placeholder='孫部署名']"

      find("input[placeholder='孫部署名']").set(company_grand_child_name)

      find_all("input[type='submit']")[1].click

      expect(page).to have_content('登録が完了しました！')
      expect(page).to have_content('ユーザー設定画面から部署に参加してください')

      click_on('Close')

      visit edit_user_path(user.id)

      find_all("select")[0].select(company_name)
      find_all("select")[1].select(company_parent_name)
      find_all("select")[2].select(company_child_name)
      find_all("select")[3].select(company_grand_child_name)

      find("input[value='登録']").click

      expect(page).to have_content('登録が完了しました！')
      click_on('Close')

      expect(page).to have_content(company_name)
      expect(page).to have_content(company_parent_name)
      expect(page).to have_content(company_child_name)
      expect(page).to have_content(company_grand_child_name)
    end
  end
end
