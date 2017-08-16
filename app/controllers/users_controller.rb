class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'WALL-E',
        username: 'wall_e',
        avatar_url: 'http://avatarki.tomsk.ru/img/11/11_2955_100_.jpg'
      ),
      User.new(
        id: 2,
        name: 'Neitiri',
        username: 'neitiri'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'WALL-E',
      username: 'wall_e',
      avatar_url: 'http://avatarki.tomsk.ru/img/11/11_2955_100_.jpg'
    )

    @questions = [
        Question.new(text: 'Kак дела?', created_at: Date.parse('16.08.2017')),
        Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('16.08.2017'))
    ]

    @new_question = Question.new
  end
end
