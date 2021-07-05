class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true,length: { maximum: 400 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: { not_yet: 0, in_progress: 1, completed: 2 }
  enum priority: { high: 1, middle: 2, low: 3 }
  
  belongs_to :user
  #binding.pry
  
  scope :title_search, -> (title) {
    where("title LIKE ?","%#{ title }%")
  }

  scope :status_search, -> (status) {
    where(status: status)
  }

end
