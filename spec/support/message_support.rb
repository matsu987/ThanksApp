module PrepareMessage
  def prepare_message(user, another_user)

    sign_in(user)

    create_group()

    create(:group_user, user: another_user, group:  user.groups[0])

    find('.new').click

    click_on('感謝を送りたい人を選択')

    find(".groups-content__result__box").click

    find(".users-content__result__box__name").click

    click_on('宛先を決定')
  end
end