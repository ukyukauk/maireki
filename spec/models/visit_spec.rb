require 'rails_helper'

RSpec.describe Visit, type: :model do
  let!(:user) do
    User.create!({
      account: 'testuser',
      email: 'test@sample.com',
      password: 'password'
    })
  end

  context '参拝日と神社が入力されており、参拝日が今日以前の場合' do
    let!(:shrine) do
      user.shrines.create!({
        name: 'テスト神社',
        prefecture: '兵庫県'
      })
    end

    let!(:visit) do
      user.visits.build({
        shrine_id: shrine.id,
        visited_on: Date.today
      })
    end

    it '参拝記録が保存できる' do
      expect(visit).to be_valid
    end
  end

  context '参拝日が未入力の場合' do
    let!(:shrine) do
      user.shrines.create!({
        name: 'テスト神社',
        prefecture: '兵庫県'
      })
    end

    let!(:visit) do
      user.visits.build({
        shrine_id: shrine.id,
        visited_on: nil
      })
    end

    it '参拝記録が保存できない' do
      expect(visit).to be_invalid
      expect(visit.errors[:visited_on]).to include("を入力してください")
    end
  end

  context '神社が未入力の場合' do
    let!(:visit) do
      user.visits.build({
        shrine_id: nil,
        visited_on: Date.today
      })
    end

    it '参拝記録が保存できない' do
      expect(visit).to be_invalid
      expect(visit.errors[:shrine]).to include("を入力してください")
    end
  end

  context '参拝日が未来日の場合' do
    let!(:shrine) do
      user.shrines.create!({
        name: 'テスト神社',
        prefecture: '兵庫県'
      })
    end

    let!(:visit) do
      user.visits.build({
        shrine_id: shrine.id,
        visited_on: Date.tomorrow
      })
    end

    it '参拝記録が保存できない' do
      expect(visit).to be_invalid
      # p visit.errors.messages
      expect(visit.errors[:visited_on]).to include("は未来の日付にできません")
    end
  end

end
