# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  #factory :task do
    #title { 'タイトル１' }
    #content { 'コンテント１' }
  #end
  # 作成するテストデータの名前を「second_task」とします
  #factory :second_task, class: Task do
    #title { 'タイトル２' }
    #content { 'コンテント２' }
  #end

      # 作成するテストデータの名前を「task」とします
    factory :task do
      title { 'タイトル１' }
      content { 'コンテント１' }
      status {2}
      priority {1}
      deadline { DateTime.now }
      association :user
    end
    # 作成するテストデータの名前を「second_task」とします
    factory :second_task, class: Task do
      title { 'タイトル２' }
      content { 'コンテント２' }
      status {0}
      priority {2}
      deadline { DateTime.tomorrow }
      association :user
    end

    factory :third_task, class: Task do
      title { 'タイトル3' }
      content { 'コンテント3' }
      status {1}
      priority {3}
      deadline { DateTime.now.since(5.days) }
      association :user
    end  

end
