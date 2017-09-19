# SwiftTableLesson

## HW 
* Нужно дореализовать таблицу с подписчиками, которую начинали на паре.
* Реализовать экран пользователя, который открывается по тапу на кнопку "info". 

Соотвественно вам нужно кинуть UIView с информацией пользователя в шапку UITableView (просто берешь и переносишь), а дальше уже создавать кастомные ячейки для каждого из разделов. 
Должны быть следующие секции: 
* Секция с ячейкой статуса пользователя. 
* Секция с основной инфой (где день рождение, место работы, семейное положение, языки, родители)
* Секция "Контакты" 
* Секция "Карьера"
* Секция "Образование"
* Секция с подарками (просто пока сделайте UIScrollView и туда накидайте картинки якобы подарков) 
* Секция с 3-мя ячейками: Интересные страницы, Заметки, Документы. 

Так же для данного экрана добавить функционал "pull-to-refresh". После него нужно рандомно перезадать инфу внутри таблиц. 
Т.е. инфу про пользователя типа Имя, аватар и остальное не трогаете, перезадаете только то, что внутри секций.  
По тапу на ячейки ничего не должно происходить.

### Скрины того, что примерно нужно сделать:

<img src="https://raw.githubusercontent.com/ZalyalovIldar/SwiftTableLesson/master/1.jpg" alt="Demo" />

<img src="https://raw.githubusercontent.com/ZalyalovIldar/SwiftTableLesson/master/2.jpg" alt="Demo" />

<img src="https://raw.githubusercontent.com/ZalyalovIldar/SwiftTableLesson/master/3.jpg" alt="Demo" />

### Некоторые подсказки: 
Используйте group стиль таблицы, чтобы дизайн был похож на вк. 
В одной секции очевидно один тип ячеек. 
Для заполнения инфы создавайте отдельные модели (структуры). 
Иконки просто найдите похожие более менее, особо сильно не заморачивайтесь. 
Цвет текста в той или иной ячейке постарайтесь повторить (что-то черное, что-то серое, что-то синее). 
Внутри таблицы все есть UILabel. 

## Полезные ссылки: 
https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/ - работа с таблицами 
https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/ - работа с pull-to-refresh-ом. 
