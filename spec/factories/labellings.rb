FactoryBot.define do
  factory :labelling do
    task_id { Task.first }
    label_id { Label.first }
  end
end