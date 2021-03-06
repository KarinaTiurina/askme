class Tag < ApplicationRecord
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags, source: :question

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, format: { with: /\A#[[:word:]-]+\z/i,
                             message: 'Неправильный формат тега.'}
end
