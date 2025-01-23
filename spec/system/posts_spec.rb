require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '新規投稿ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_post_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context '投稿編集ページにアクセス' do
        it '投稿編集ページへのアクセスが失敗する' do
          visit edit_post_path(post)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context '投稿詳細ページにアクセス' do
        it '投稿の詳細ページへのアクセスが失敗する' do
          visit post_path(post)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context '投稿一覧ページにアクセス' do
        it 'すべての投稿が表示される' do
          post_list = create_list(:post, 3) # 配列になっている
          visit posts_path
          expect(page).to have_content post_list[0].body
          expect(page).to have_content post_list[1].body
          expect(page).to have_content post_list[2].body
          expect(current_path).to eq posts_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe '新規投稿' do
      context 'フォームの入力値が正常' do
        fit '新規投稿が成功する' do
          visit new_post_path
          fill_in 'やらかしエピソード', with: 'テスト'
          click_button '投稿する'
          expect(page).to have_content('投稿を作成しました')
          expect(current_path).to eq '/posts'
        end
      end

      context 'Bodyが未入力' do
        it 'タスクの新規作成が失敗する' do
          visit new_post_path
          fill_in 'やらかしエピソード', with: ''
          click_button '投稿する'
          expect(page).to have_content('本文を入力してください')
          expect(current_path).to eq new_post_path
        end
      end
    end

    describe '投稿編集' do
      let!(:post) { create(:post, user: user) }
      let(:other_post) { create(:post, user: user) }
      before { visit edit_post_path(post) }

      context 'フォームの入力値が正常' do
        it 'タスクの編集が成功する' do
          fill_in 'やらかしエピソード', with: 'update_body'
          click_button '更新'
          expect(page).to have_content('投稿を更新しました')
          expect(current_path).to eq post_path(post)
        end
      end

      context 'Bodyが未入力' do
        it 'タスクの編集が失敗する' do
          fill_in 'やらかしエピソード', with: ''
          click_button '更新'
          expect(page).to have_content('投稿を更新出来ませんでした')
          expect(current_path).to eq edit_post_path(post)
        end
      end
    end

    describe '投稿削除' do
      it '投稿の削除が成功する' do
        post = create(:post, user: user, body: 'テスト')
        visit post_path(post)
        click_on '削除'
        expect(page.accept_confirm).to eq '削除しますか？'
        expect(page).to have_content('投稿を削除しました')
        expect(current_path).to eq posts_path
      end
    end
  end
end
