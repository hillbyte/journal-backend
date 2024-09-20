class Entry < ApplicationRecord
  belongs_to :journal
  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates :content, presence: true
  validates :date, presence: true
end
