class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_tags
  has_many :tags, through: :question_tags, source: :tag

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  after_save :find_tags


  def find_tags
    tags = []

    full_text = answer.present? ? (text + answer) : text
    tags_str = full_text.scan(/#[[:word:]-]+/i).uniq

    tags_str.each do |tag_str|
      tag = Tag.find_by(name: tag_str)

      unless tag
        tag = Tag.create(name: tag_str)
      end
      tags << tag
    end

    QuestionTag.where(question: id).destroy_all

    tags.each do |tag|
      QuestionTag.create(question: self, tag: tag)
    end
  end
end
