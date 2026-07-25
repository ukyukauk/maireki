require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:shrine) { create(:shrine, user: user) }
  let(:visit) { create(:visit, user: user, shrine: shrine) }

  context '品名とカテゴリーが入力されている場合' do
    let(:item) { build(:item, visit: visit) }

    it '授与品が保存できる' do
      expect(item).to be_valid
    end
  end

  context '品名が未入力の場合' do
    let(:item) { build(:item, visit: visit, name: nil) }

    it '授与品が保存できない' do
      expect(item).to be_invalid
      expect(item.errors[:name]).to include('を入力してください')
    end
  end

  context 'カテゴリーが未入力の場合' do
    let(:item) { build(:item, visit: visit, category: nil) }

    it '授与品が保存できない' do
      expect(item).to be_invalid
      expect(item.errors[:category]).to include('を入力してください')
    end
  end
end
