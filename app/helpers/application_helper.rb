module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def questions_count(questions)
    number = questions.count

    ostatok = number % 100

    if ostatok >= 11 && ostatok <= 14
      str = 'вопросов'
      return "#{number} #{str}"
    end

    ostatok = number % 10

    if ostatok == 1
      str = 'вопрос'
    end

    if ostatok >= 2 && ostatok <= 4
      str = 'вопроса'
    end

    if ostatok > 4 || ostatok == 0
      str = 'вопросов'
    end

    "#{number} #{str}"
  end
end
