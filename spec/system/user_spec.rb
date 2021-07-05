require 'rails_helper'

RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do

  describe 'ユーザ登録のテスト' do

    context 'ユーザ新規登録' do
      it '自身の名が入ったページへアクセスできる' do
        visit new_user_path
        fill_in 'user_name', with: 'usertest111'
        fill_in 'user_email', with: 'usertest111@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        expect(page).to have_content 'usertest111'
      end
    end

    context 'ログインなしでタスク一覧にアクセス' do
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  
  end
 
  describe 'session機能テスト' do

    context "ログインしていない状態でユーザデータがある場合" do

      it 'ログインができること・マイページに飛べること・' do
        # @user = FactoryBot.create(:user)
        # visit new_session_path
        # fill_in 'session_email', with: usertest01
        # fill_in 'session_password', with: @user.password
        visit new_user_path
        fill_in 'user_name', with: 'usertest01'
        fill_in 'user_email', with: 'usertest01@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        #マイページに飛べること
        expect(current_path).to eq '/users/2' #2番目にデータができたため
        click_on "user_edit"
        #自分の詳細画面に飛べること
        expect(current_path).to eq '/users/2/edit'
      end

      it '自分の詳細画面に飛べること' do
        #@second_user = FactoryBot.create(:second_user)
        # visit new_session_path
        # fill_in 'session_email', with: @second_user.email
        # fill_in 'session_password', with: @second_user.password
        # click_on "log_in"
        visit new_user_path
        fill_in 'user_name', with: 'usertest02'
        fill_in 'user_email', with: 'usertest02@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        #自分の詳細画面に飛べること
        click_on "user_edit"
        expect(current_path).to eq '/users/3/edit' #3番目にデータができたため
      end

      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        visit new_user_path
        fill_in 'user_name', with: 'usertest03'
        fill_in 'user_email', with: 'usertest03@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        #一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること
        visit user_path(1)
        expect(page).to have_content "権限がありません。"
      end

      it 'ログイン画面に戻る' do
        visit new_user_path
        fill_in 'user_name', with: 'usertest04'
        fill_in 'user_email', with: 'usertest04@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        #ログアウトする
        click_on "logout"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "管理画面のテスト" do

      let!(:third_user) { FactoryBot.create(:third_user) }

    context "管理作成から各刻目のテスト" do
      #@third_user = FactoryBot.create(:third_user)
      it "管理者は管理画面にアクセスできること" do
        
        visit new_session_path
        fill_in "session_email", with: "admintest01@gmail.com​"
        fill_in "session_password", with: "password"
        click_on "log_in"
        visit admin_users_path
        expect(page).to have_content "ユーザーの一覧確認ページ" 
      end

      it "一般ユーザーは管理画面にはアクセスできない" do
        visit new_user_path
        fill_in 'user_name', with: 'usertest05'
        fill_in 'user_email', with: 'usertest05@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント作成'
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません。" 
      end

      it "管理者はユーザ新規登録ができる" do
        visit new_session_path
        fill_in "session_email", with: "admintest01@gmail.com​"
        fill_in "session_password", with: "password"
        click_on "log_in"
        visit admin_users_path
        click_link "users_admin_new_link"
        fill_in "user_name", with: "newtest01"
        fill_in "user_email", with: "newtest01@gmail.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "登録する"
        expect(page).to have_content "newtest01"
      end

      it "管理者はユーザの詳細画面へ行ける" do
        @fourth_user = FactoryBot.create(:fourth_user)
        visit new_session_path
        fill_in "session_email", with: "admintest01@gmail.com​"
        fill_in "session_password", with: "password"
        click_on "log_in"
        visit show_admin_user_path(id: @fifth_user.id)
        expect(page).to have_content 'usertest11のページ'
      end

      it "管理者ユーザーの編集画面からユーザーの編集ができる" do
        @fifth_user = FactoryBot.create(:fifth_user)
        visit new_session_path
        fill_in "session_email", with: "admintest01@gmail.com​"
        fill_in "session_password", with: "password"
        click_on "log_in"
        visit edit_admin_user_path(id: @fifth_user.id)
        fill_in 'user_name', with: 'testuser1000'
        fill_in 'user_email', with: 'testuser1000@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on '更新する'
        expect(page).to have_content "testuser1000"
      end

      it "管理者はユーザーを削除できる" do
        @sixth_user = FactoryBot.create(:sixth_user)
        visit new_session_path
        fill_in "session_email", with: "admintest01@gmail.com​"
        fill_in "session_password", with: "password"
        click_on "log_in"
        @sixth_user = FactoryBot.create(:sixth_user)
        visit admin_users_path
        click_link '削除', href: admin_user_path(@sixth_user)
        expect {
          page.accept_confirm '削除しますか？'
          expect(page).to have_content 'bar'
        }
      end

    end
  end

end
