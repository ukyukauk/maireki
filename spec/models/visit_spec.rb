require 'rails_helper'

RSpec.describe Visit, type: :model do
  let(:user) { create(:user) }

  context '参拝日と神社が入力されており、参拝日が今日以前の場合' do
    let(:shrine) { create(:shrine, user: user) }
    let(:visit) { build(:visit, user: user, shrine: shrine) }

    it '参拝記録が保存できる' do
      expect(visit).to be_valid
    end
  end

  context '参拝日が未入力の場合' do
    let(:shrine) { create(:shrine, user: user) }
    let(:visit) { build(:visit, user: user, shrine: shrine, visited_on: nil) }

    it '参拝記録が保存できない' do
      expect(visit).to be_invalid
      expect(visit.errors[:visited_on]).to include('を入力してください')
    end
  end

  context '神社が未入力の場合' do
    let(:visit) { build(:visit, user: user, shrine_id: nil) }

    it '参拝記録が保存できない' do
      expect(visit).to be_invalid
      expect(visit.errors[:shrine]).to include('を入力してください')
    end
  end

  context '参拝日が未来日の場合' do
    let(:shrine) { create(:shrine, user: user) }
    let(:visit) { build(:visit, user: user, shrine: shrine, visited_on: Date.tomorrow) }

    it '参拝記録が保存できない' do
      expect(visit).to be_invalid
      # p visit.errors.messages
      expect(visit.errors[:visited_on]).to include('は未来の日付にできません')
    end
  end
end
