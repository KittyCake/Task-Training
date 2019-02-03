# 可以設定任務的結束時間
# 可以設定任務的優先順序
# 可以為任務加上分類標籤
# 可以管理各種狀態（待處理、進行中、完成）
require 'rails_helper'

feature 'Task' do
  # 可以讓使用者登入，並只能看見自己建立的任務
  describe 'index task' do
    context 'user is not logged in' do

    end

    context 'user is logged in' do

    end
  end

  describe 'new task' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit new_task_path
        expect(page).not_to have_content('New Task')
        expect(page).to have_content('Password')
      end
    end

    context 'user is logged in' do

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
