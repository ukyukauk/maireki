require 'rails_helper'

RSpec.describe 'Visit', type: :system do
  let(:user) { create(:user) }
  let!(:shrine) { create(:shrine, user: user) }
  let!(:visits) { create_list(:visit, 3, user: user, shrine: shrine) }

  it '参拝記録一覧が表示される' do
    sign_in user
    visit root_path

    visits.each do |visit|
      displayed_date = I18n.l(visit.visited_on, format: '%Y/%m/%d(%a)')
      expect(page).to have_css('.visit_date', text: displayed_date)
    end
  end

  it '参拝記録詳細を表示できる' do
    sign_in user
    visit root_path

    visit = visits.first
    displayed_date = I18n.l(visit.visited_on, format: '%Y/%m/%d(%a)')
    click_on displayed_date

    expect(page).to have_css('.card_info_item_content', text: displayed_date)
    expect(page).to have_css('.card_info_item_content', text: visit.prayer)
  end

  it '参拝記録を登録できる' do
    sign_in user
    visit new_visit_path

    fill_in '参拝日', with: Date.current
    select shrine.name_with_prefecture, from: 'visit_shrine_id'
    fill_in '祈願内容', with: '健康祈願'
    fill_in '感想', with: '静かで落ち着いた神社だった'

    click_button '保存'

    displayed_date = I18n.l(Date.current, format: '%Y/%m/%d(%a)')

    expect(page).to have_css('.card_name', text: shrine.name)
    expect(page).to have_css('.card_info_item_content', text: displayed_date)
    expect(page).to have_css('.card_info_item_content', text: '健康祈願')
    expect(page).to have_css('.card_info_item_content', text: '静かで落ち着いた神社だった')
  end

  it '授与品を追加して保存できる', js: true do
    sign_in user
    visit new_visit_path

    fill_in '参拝日', with: Date.current
    select shrine.name_with_prefecture, from: 'visit_shrine_id'
    fill_in '祈願内容', with: '健康祈願'
    fill_in '感想', with: '静かで落ち着いた神社だった'

    within(all('.item-inputs').first) do
      find('select').select('御朱印')
      find('input[name$="[name]"]').set('限定御朱印')
      find('input[name$="[price]"]').set('500')
    end

    find('#add-row-button').click

    within(all('.item-inputs').last) do
      find('select').select('御守り')
      find('input[name$="[name]"]').set('厄除け守')
      find('input[name$="[price]"]').set('700')
    end

    click_button '保存'

    expect(page).to have_css('.item-name', text: '厄除け守')
    expect(page).to have_css('.item-price', text: '700円')

  end

  it '既存の授与品を削除できる', js: true do
    target_visit = visits.first
    item = create(:item, visit: target_visit, name: '限定御朱印')

    sign_in user
    visit edit_visit_path(target_visit)

    within("#item_#{item.id}") do
      find('#remove-row-button').click
    end

    click_button '保存'

    expect(page).not_to have_content('限定御朱印')
  end
end
