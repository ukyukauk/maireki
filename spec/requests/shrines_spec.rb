require 'rails_helper'

RSpec.describe 'Shrines', type: :request do
  let(:user) { create(:user) }
  let!(:shrines) { create_list(:shrine, 3, user: user) }

  describe 'GET /shrines' do
    context 'ログインしている場合' do
      before do
          sign_in user
        end

      it '200ステータスが返ってくる' do
        get shrines_path
        expect(response).to have_http_status(:ok) #200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get shrines_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /shrines/:id' do
    before do
      sign_in user
    end

    it '200ステータスが返ってくる' do
      shrine = create(:shrine, user: user)
      get shrine_path(shrine)
      expect(response).to have_http_status(:ok)
    end

    it '他人の神社詳細にはアクセスできない' do
      other_user = create(:user)
      other_shrine = create(:shrine, user: other_user)

      get shrine_path(other_shrine)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /shrines/new' do
    context 'ログインしている場合' do
      before do
          sign_in user
        end

      it '200ステータスが返ってくる' do
        get new_shrine_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get new_shrine_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /shrines' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '神社が保存される' do
        shrine_params = attributes_for(:shrine)

        expect {
          post shrines_path, params: { shrine: shrine_params }
        }.to change(Shrine, :count).by(1)

        expect(response).to redirect_to(shrine_path(Shrine.last))
      end

      it '不正な値の場合、保存されない' do
        invalid_params = attributes_for(:shrine, name: '')

        expect {
          post shrines_path, params: { shrine: invalid_params }
        }.not_to change(Shrine, :count)

        expect(response).to have_http_status(:unprocessable_content) #422
      end

      it 'return_toが内部パスなら、その画面に戻る' do
        shrine_params = attributes_for(:shrine)

        post shrines_path, params: {
          shrine: shrine_params,
          return_to: new_visit_path
        }

        expect(response).to redirect_to("#{new_visit_path}?shrine_id=#{Shrine.last.id}")
      end

      it 'return_toが外部URLなら、神社詳細へ遷移する' do
        shrine_params = attributes_for(:shrine)

        post shrines_path, params: {
          shrine: shrine_params,
          return_to: 'https://example.com'
        }

        expect(response).to redirect_to(shrine_path(Shrine.last))
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        shrine_params = attributes_for(:shrine)
        post shrines_path, params: { shrine: shrine_params }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /shrines/:id' do
    before do
      sign_in user
    end

    it '神社が更新される' do
      shrine = create(:shrine, user: user)

      patch shrine_path(shrine), params: {
        shrine: { name: '更新後の神社名' }
      }

      expect(response).to redirect_to(shrine_path(shrine))
      expect(shrine.reload.name).to eq '更新後の神社名'
    end
  end

  describe 'DELETE /shrines/:id' do
    before do
      sign_in user
    end

    it '神社が削除される' do
      shrine = create(:shrine, user: user)

      expect {
        delete shrine_path(shrine)
      }.to change(Shrine, :count).by(-1)

      expect(response).to redirect_to(shrines_path)
    end
  end
end
