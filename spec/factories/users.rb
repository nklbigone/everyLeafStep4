FactoryBot.define do
  factory :user do
    name {'永澤'}
    email {'takuya@docomo.ne.jp'}
    password {'password'}
    admin {'管理者'}
  end
  factory :user2 ,class: User do
    name {'takuya'}
    email {'takuya2@docomo.ne.jp'}
    password {'password2'}
    admin {'一般'}
  end

end 