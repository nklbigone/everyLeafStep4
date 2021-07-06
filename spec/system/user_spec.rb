require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:user2)
  end
  describe 'ユーザー新規作成' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        expect(new_user_path).to eq new_user_path
        fill_in 'user[name]',with: 'たくや'
        fill_in 'user[email]',with: 'taku1@docomo.ne.jp'
        fill_in 'user[password]',with: 'password'
        fill_in 'user[password_confirmation]',with: 'password'
        click_button 'アカウント作成'
        expect(page).to have_content 'たくや'
      end
    end
    context 'ログインせずに一覧ページに飛んだ場合' do
      it '遷移せずログインページに戻されること' do
        visit tasks_path
        expect(page).to have_content "ログイン"
        expect(current_path).to have_content "/sessions/new"
    end
   end
  end
  describe 'ログイン機能' do 
    context 'ログインした場合' do
      it 'ログインができること' do
        visit new_session_path
        expect(current_path).to have_content "/sessions/new"
        fill_in 'session[email]', with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]', with: 'password'

        click_button 'ログイン'
        expect(page).to have_content "永澤としてログイン中"

      end
    end
    context 'ログアウトした場合' do 
      it 'ログアウトができること' do
        visit new_session_path
        expect(current_path).to have_content "/sessions/new"
        fill_in 'session[email]', with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content "永澤としてログイン中"
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end

  end
  describe 'ユーザー詳細機能' do
    context '自分の詳細ページボタンを押した場合' do 
      it '自分の詳細ページに遷移すること' do
        visit new_user_path
        expect(new_user_path).to eq new_user_path
        fill_in 'user[name]',with: 'fujii'
        fill_in 'user[email]',with: 'fujii@docomo.ne.jp'
        fill_in 'user[password]',with: 'password'
        fill_in 'user[password_confirmation]',with: 'password'
        click_button 'アカウント作成'
        expect(page).to have_content 'fujii'
        expect(page).to have_content 'ユーザー編集'
      end
    end
  end
  describe '管理画面テスト' do
    context '管理者が管理画面にアクセスした場合' do
      it '管理画面に遷移されること' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'ログイン'
        click_button '管理者用ユーザ一覧'
        
        expect(current_path).to have_content "/admin/users"
      end
      it '管理者は新規ユーザーを作成できること' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'ログイン'
        click_button '管理者用ユーザ一覧'
        click_button '管理者用ユーザ一作成'
        fill_in 'user[name]',with: 'たく2'
        fill_in 'user[email]',with: 'taku@docomo2.ne.jp'
        fill_in 'user[password]',with: 'password2'
        fill_in 'user[password_confirmation]',with: 'password2'
        click_button '登録する'
        expect(page).to have_content 'たく2'
        expect(current_path).to have_content "/admin/users"
      end
      it '管理ユーザーは他人の詳細ページが確認できること' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'ログイン'
        click_button '管理者用ユーザ一覧'
        first('tr td:nth-child(1)').click
        # binding.irb
        expect(page).to have_content 'takuya'
      end
    end
    it '管理者は他のユーザーを消去できる' do
      visit new_session_path
      fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
      fill_in 'session[password]',with: 'password'
      click_button 'ログイン'
      click_button '管理者用ユーザ一覧'
      first('tr:nth-child(3) td:nth-child(5)').click
    end
  end
    context '一般ユーザーがアクセスした場合' do
      it '一般ユーザーが入れないこと' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya2@docomo.ne.jp'
        fill_in 'session[password]',with: 'password2'
        click_button 'ログイン'
        click_button '管理者用ユーザ一覧'
        expect(page).to have_content 'takuya'
      end
    end

end