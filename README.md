# Приложение Askme

Учебное приложение аналог сайта https://ask.fm/.

Приложение написано с помощью rails 5.1.2.

Для запуска:

    bundle exec rails db:migrate
    bundle exec rails s

Приложение использует архитектуру MVC. В ходе работы над приложением была изучена работа с базой данных (в том числе связь М-М (функционал хештэгов)), основы безопасности rails приложений (gem recaptcha), аутентификация и авторизация пользователей.

Посмотреть приложение можно [здесь](https://ask-them.herokuapp.com/)
