require 'rails_helper'

RSpec.describe 'Shrine', type: :system do
  let(:user) { create(:user) }
  let!(:shrines) { create_list(:shrine, 3, user: user) }

  it '登録神社一覧が表示される' do
    sign_in user
    visit shrines_path

    shrines.each do |shrine|
      expect(page).to have_css('.card', text: shrine.name)
    end
  end

  it '神社詳細を表示できる' do
    sign_in user
    visit shrines_path

    shrine = shrines.first
    click_on shrine.name

    expect(page).to have_css('.card_name', text: shrine.name)
  end

  it '神社を登録できる' do
    sign_in user
    visit new_shrine_path

    fill_in '【神社名】', with: 'テスト神社'
    select('大阪府', from: '【都道府県】')

    click_button '保存'

    expect(page).to have_css('.card_name', text: 'テスト神社')
  end
end
