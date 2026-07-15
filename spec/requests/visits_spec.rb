require 'rails_helper'

RSpec.describe 'Visits', type: :request do
  let(:user) { create(:user) }

  describe 'GET /visits' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get visits_path

        expect(response).to have_http_status(:ok) #200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get visits_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /visits/:id' do
    before do
      sign_in user
    end

    it '200ステータスが返ってくる' do
      shrine = create(:shrine, user: user)
      visit = create(:visit, user: user, shrine: shrine)

      get visit_path(visit)

      expect(response).to have_http_status(:ok)
    end

    it '他人の参拝詳細にはアクセスできない' do
      other_user = create(:user)
      other_shrine = create(:shrine, user: other_user)
      other_visit = create(:visit, user: other_user, shrine: other_shrine)

      get visit_path(other_visit)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /visits/new' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get new_visit_path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get new_visit_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /visits' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '参拝記録が保存される' do
        shrine = create(:shrine, user: user)
        visit_params = attributes_for(:visit, shrine_id: shrine.id, impression: '登録後')

        expect {
          post visits_path, params: { visit: visit_params }
        }.to change(user.visits, :count).by(1)

        visit = user.visits.order(:created_at).last

        expect(response).to redirect_to(visit_path(visit))
        expect(visit.shrine).to eq shrine
        expect(visit.impression).to eq '登録後'
      end

      it '不正な値の場合、保存されない' do
        invalid_params = attributes_for(:visit, shrine_id: '')

        expect {
          post visits_path, params: { visit: invalid_params }
        }.not_to change(user.visits, :count)

        expect(response).to have_http_status(:unprocessable_entity) #422
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        shrine = create(:shrine, user: user)
        visit_params = attributes_for(:visit, shrine_id: shrine.id)

        post visits_path, params: { visit: visit_params }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /visits/:id/edit' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)

        get edit_visit_path(visit)

        expect(response).to have_http_status(:ok)
      end

      it '他人の参拝記録の編集画面にはアクセスできない' do
        other_user = create(:user)
        other_shrine = create(:shrine, user: other_user)
        other_visit = create(:visit, user: other_user, shrine: other_shrine)

        get edit_visit_path(other_visit)

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)

        get edit_visit_path(visit)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /visits/:id' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '参拝記録が更新される' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)

        patch visit_path(visit), params: {
          visit: { impression: '更新後' }
        }

        expect(response).to redirect_to(visit_path(visit))
        expect(visit.reload.impression).to eq '更新後'
      end

      it '不正な値の場合、参拝記録が更新されない' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)
        original_visited_on = visit.visited_on

        patch visit_path(visit), params: {
          visit: { visited_on: '' }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(visit.reload.visited_on).to eq original_visited_on
      end

      it '他人の参拝記録は更新できない' do
        other_user = create(:user)
        other_shrine = create(:shrine, user: other_user)
        other_visit = create(:visit, user: other_user, shrine: other_shrine, impression: '更新前')

        patch visit_path(other_visit), params: {
          visit: { impression: '不正に更新' }
        }

        expect(response).to have_http_status(:not_found)
        expect(other_visit.reload.impression).to eq '更新前'
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)

        patch visit_path(visit), params: {
          visit: { impression: '更新後' }
        }

        expect(response).to redirect_to(new_user_session_path)
        expect(visit.reload.impression).not_to eq '更新後'
      end
    end
  end

  describe 'DELETE /visits/:id' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '参拝記録が削除される' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)

        expect {
          delete visit_path(visit)
        }.to change(user.visits, :count).by(-1)

        expect(response).to redirect_to(visits_path)
      end

      it '他人の参拝記録は削除できない' do
        other_user = create(:user)
        other_shrine = create(:shrine, user: other_user)
        other_visit = create(:visit, user: other_user, shrine: other_shrine)

        expect {
          delete visit_path(other_visit)
        }.not_to change(Visit, :count)

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        shrine = create(:shrine, user: user)
        visit = create(:visit, user: user, shrine: shrine)

        expect {
          delete visit_path(visit)
        }.not_to change(user.visits, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
