module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def sklonenie(number, krokodil, krokodila, krokodilov)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    ostatok = number % 100

    if ostatok >= 11 && ostatok <= 14
      return krokodilov
    end

    ostatok = number % 10

    if ostatok == 1
      return krokodil
    end

    if ostatok >= 2 && ostatok <= 4
      return krokodila
    end

    if ostatok > 4 || ostatok == 0
      return krokodilov
    end
  end

  def find_author(question)
    User.find(question.author_id) if question.author_id.present?
  end

  def load_tags(question)
    Tag.joins(:questions).where("question_tags.question_id = ?", question)
  end
end
