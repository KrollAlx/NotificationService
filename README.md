# README

Данное приложение представляет собой REST API для администрирования рассылками
и получения статистики. 
После создания рассылки, приложение выбирает всех клиентов подходящих под значение
филтра и обращается к стороннему API, которое отправляет сообщения
клиентам. Рассылка запускается как бекграуд джоба. Также сделана swagger документация.

Возможности:

* Создание, обновление, удаления клиента 

* Создание, обновления, удаления рассылки

* Получение статистики по всем рассылкам, получение статистики по конкретной рассылке

Стек:

* Ruby 3

* Ruby on Rails 7

* PostgreSQL

* RSpec

* RSwag

* Sidekiq

* Dry-monads

* Dry-validation
