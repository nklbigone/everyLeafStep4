FactoryBot.define do
    factory :user do
      name { 'usertest01' }
      email { 'usertest01@gmail.com' }
      password { 'password' }
      admin { false }
    end
    factory :second_user, class: User do
      name { 'usertest02' }
      email { 'usertest02@gmail.com' }
      password { 'password' }
      admin { false }
    end
    factory :third_user, class: User do
      name { 'admintest01' }
      email { 'admintest01@gmail.com' }
      password { 'password' }
      admin { true }
    end
    factory :fourth_user, class: User do
      name { 'usertest11' }
      email { 'usertest11@gmail.com' }
      password { 'password' }
      admin { false }
    end
    factory :fifth_user, class: User do
      name { 'usertest22' }
      email { 'usertest22@gmail.com' }
      password { 'password' }
      admin { false }
    end
    factory :sixth_user, class: User do
      name { 'usertest33' }
      email { 'usertest33@gmail.com' }
      password { 'password' }
      admin { false }
    end
end
