require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do

    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: 'title'
        fill_in "task_content", with: 'content'
        select '高', from: 'task[priority]'
        fill_in 'deadline', with: '2021/06/25'
        select '未着手', from: 'task_status'
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content '未着手'
      end
    end

  end

  describe '一覧表示機能' do

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task', deadline: '2020/06/25', status: 'not_yet', priority: 'middle' )
        visit tasks_path
        expect(page).to have_content '着手中'
      end
    end

  end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '降順に表示される' do
        Task.create(title: '1', content: 'context1', deadline: '2020/12/11', status: 'not_yet', priority: 'middle' )
        Task.create(title: '2', content: 'context2', deadline: '2020/12/11', status: 'not_yet', priority: 'middle' )
        Task.create(title: '3', content: 'context3', deadline: '2020/12/11', status: 'not_yet', priority: 'middle' )
        visit tasks_path
        expect(Task.order("created_at DESC").map(&:title)).to eq ["3", "2", "1"]
      end
    end

    context '終了期限でソートした場合' do
      it 'タスクが終了期限順に並んでいる' do
        Task.create(title: '1', content: 'context1', deadline: '2020/11/30', status: 'not_yet', priority: 'middle' )
        Task.create(title: '2', content: 'context2', deadline: '2020/11/29', status: 'not_yet', priority: 'middle' )
        Task.create(title: '3', content: 'context3', deadline: '2020/11/28', status: 'not_yet', priority: 'middle' )
        visit tasks_path
        click_on "sort_deadline"
        visit tasks_path(sort_expired: "true")
        visit tasks_path
        expect(Task.order("deadline DESC").map(&:title)).to eq ["1", "2", "3"]
      end
    end

    describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          @task = FactoryBot.create(:task,title: 'task1',content: 'content1', deadline: '2020/11/30', status: 'not_yet', priority: 'middle' )
          visit task_path(@task)
          expect(page).to have_content 'task1'
          expect(page).to have_content 'content1'
        end
      end
    end
   
     describe '検索機能' do
      before do
        FactoryBot.create(:task, title: "task101", deadline: '2021/06/30', status: 'not_yet', priority: 'middle' )
        FactoryBot.create(:second_task, title: "test100", deadline: '2021/06/30', status: 'completed', priority: 'middle' )
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in 'title', with: 'task'
          click_on '検索'
          expect(page).to have_content 'task'
        end
      end
   
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select "未着手", from: "status"
          click_on '検索'
          expect(page).to have_content '未着手'
        end
      end
   
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in 'title', with: 'task'
          select "未着手", from: "status"
          click_on '検索'
          expect(page).to have_content 'task'
          expect(page).to have_content '未着手'
        end
      end
     end


end







