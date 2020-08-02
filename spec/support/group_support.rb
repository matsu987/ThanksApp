module CreateGroup
  def create_group()
    company_name = "株式会社樋口カンパニー"
    post_number = "123-4567"
    address = "東京都新宿丸の内ビル"
    phone_number = "090-1234-5678"

    click_on('新規登録')

    find("input[placeholder='例）株式会社〇〇〇〇']").set(company_name)
    find("input[placeholder='例）123-xxxx']").set(post_number)
    find("input[placeholder='例）東京都〇〇区〇〇〇〇']").set(address)
    find("input[placeholder='例）0120-1234-xxxx']").set(phone_number)

    find("input[type='submit']").click

    click_on('Close')
  end
end