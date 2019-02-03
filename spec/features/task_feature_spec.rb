# 可以設定任務的結束時間
# 可以設定任務的優先順序
# 可以為任務加上分類標籤
# 可以管理各種狀態（待處理、進行中、完成）
require 'rails_helper'

feature 'Task' do
  # 可以讓使用者登入，並只能看見自己建立的任務
  describe 'index task' do
    let!(:task) { create :task, title: 'First created', content: 'This is first one.' }
    let!(:task) { create :task, title: 'Second created', content: 'This is second one.' }
    let!(:task) { create :task, title: 'Third created', content: 'This is third one.' }

    context 'user is not logged in' do
      @tasks = Task.all.order('created_at DESC')

      scenario 'show tasks of current user' do
        visit tasks_path
        titles = page.all('tr td:nth-child(2)')
        puts titles[0]
        puts @tasks[0]
        titles[0].should have_content(@tasks[0].title)
        titles[1].should have_content(@tasks[1].title)
        titles[-1].should have_content(@tasks[-1].title)
      end
    end

    context 'user is logged in' do
      before { log_in create(:user) }
      @tasks = Task.all.order('created_at DESC')

      scenario 'show tasks of current user' do
        visit tasks_path
        titles = page.all('tr td:nth-child(2)')
        titles[0].should have_content(@tasks[0].title)
        titles[1].should have_content(@tasks[1].title)
        titles[-1].should have_content(@tasks[-1].title)
      end
    end
  end

  # 預設已建立任務時間來排序
  describe 'new task' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit new_task_path
        expect(page).not_to have_content('New Task')
        expect(page).to have_content('Password')
      end
    end

    context 'user is logged in' do
      before { log_in create(:user) }

      context 'with valid field' do
        scenario 'creates the task' do
          visit new_task_path
          fill_in 'title', with: 'Homework'
          fill_in 'content', with: 'Homework for summer vacation.'
          fill_in 'priority', with: 'important'
          fill_in 'status', with: 'finished'
          fill_in 'user', with: '1'
          click_on 'submit'
          expect(page).to have_content('Homework for summer vacation.')
        end
      end
    end
  end

  describe 'edit task' do
    context 'user is not logged in' do

    end

    context 'user is logged in' do

    end
  end

  describe 'destroy task' do
    context 'user is not logged in' do

    end

    context 'user is logged in' do

    end
  end
end
