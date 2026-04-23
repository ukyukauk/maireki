require 'rails_helper'

RSpec.describe Shrine, type: :model do
  let(:user) { create(:user) }

  context '神社名と都道府県が入力されている場合' do
    let(:shrine) { build(:shrine, user: user) }

    it '神社が保存できる' do
      expect(shrine).to be_valid
    end
  end

  context '同一ユーザ・神社名だが、都道府県が違う場合' do
    before do
      create(:shrine, user: user)
    end

    let(:shrine2) { build(:shrine, user: user, prefecture: '大阪府') }

    it '神社が保存できる' do
      expect(shrine2).to be_valid
    end
  end

  context '同一神社名・都道府県でも、ユーザが違う場合' do
    let(:user2) { create(:user, account: 'test_user2') }

    before do
      create(:shrine, user: user2)
    end

    let(:shrine2) { build(:shrine, user: user) }

    it '神社が保存できる' do
      expect(shrine2).to be_valid
    end
  end

  context '神社名が未入力の場合' do
    let(:shrine) { build(:shrine, user: user, name: nil) }

    it '神社が保存できない' do
      expect(shrine).to be_invalid
      # p shrine.errors.messages
      expect(shrine.errors[:name]).to include("を入力してください")
    end
  end

  context '都道府県が未入力の場合' do
    let(:shrine) { build(:shrine, user: user, prefecture: nil) }

    it '神社が保存できない' do
      expect(shrine).to be_invalid
      # p shrine.errors.messages
      expect(shrine.errors[:prefecture]).to include("を入力してください")
    end
  end

  context '同一ユーザ・神社名・都道府県の神社がすでに登録されている場合' do
    before do
      create(:shrine, user: user)
    end

    let(:shrine2) { build(:shrine, user: user) }

    it '神社が保存できない' do
      expect(shrine2).to be_invalid
      # p shrine2.errors.messages
      expect(shrine2.errors[:name]).to include("はすでに存在します")
    end
  end
end
