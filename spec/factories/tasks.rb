FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at { '2021-03-01 03:33:33' }
    status { 0 }
    priority { 0 }
    association :user
  end
  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    expired_at { '2021-03-03 03:33:33' }
    status { 1 }
    priority { 1 }
    association :user
  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    expired_at { '2021-03-02 03:33:33' }
    status { 2 }
    priority { 2 }
    association :user
  end
end