
#  Менеджер тем для приложения на Flutter

## Функции

Данный конфигуратор предназначен для создания, локального хранения и изменения кастомных тем для приложения и их составляющих. Изначально пользователю предлагаются на выбор две темы. Далее можно создавать свои на основе уже существующих, и изменять их.

Конфигуратор позволяет изменить следующие параметры для одной темы.
1. Главного цвета темы;
2. Переключение цвета фона темы между темным и светлым вариантами;
3. Изменение размера всех дефолтных шрифтов;
4. Цвет измененного пакета;
5. Цвет измененного элемента в пакете;
6. Цвет критической ошибки;

## Как пользоваться

Для начала работы в конифгуратором необходимо перейти в раздел настроек и выбрать пункт настройки тем.

> Работа в конфигураторе начинается после открытия диалогового окна с конфигуратором.

Сразу после открытия окна вам доступны следующие действия:

1. Переключение между доступными темами => Клик на одну из доступных тем в списке;
2. Создание новой темы => Символ `+` в конце списка доступных тем;
3. Выход из окна без сохранения изменений нажатием на кнопку `Назад` или клик в любом месте за его пределами;

> Темы, доступные по умолчанию не доступны к изменению. 

Для внесения изменений в тему нужно создать свою первую тему. После её создания тема добавится в список а также разблокируются кнопки в правой колонке конфигуратора, которые дают возможность изменить для новой темы её настройки, описанные в разделе #Features.
Эти настройки перечислены в правой колонке окна конфигуратора тем.

Для внесения изменений в отдельную настройку для созданной темы необходимо нажать на иконку справа от названия настройки.
В открывшемся диалоговом выберите подходящий для вас вариант настройки.

 >❗Вы не увидите вносимые изменения, пока не покинете окно конфигуратора с сохранением внесенных настроек❗

Вносите изменения в свою тему в открывающихся диалоговых окнах, пока не настроите тему под себя.
Для применения добавленных изменений необходимо нажать кнопку `[Применить и выйти]`. 

По аналогии можно создавать/удалять изменять любое количество тем, кроме доступных по умолчанию. Темы по умолчанию удалить/изменить невозможно.

Если вы выйдете из окна не сохраняя настройки, до все изменения внесенные в окне конфигуратора будут отменены, включая создание новых тем и удаление старых.

## Информация для администратора

Есть возможность настроить дефолтные темы для системы.
Программа поддерживает ровно 2 темы пол умолчанию, не больше и не меньше.
Темы по умолчанию редактируются в JSON файле в директории Assets: "assets\customthemes.json".
При повреждении файла программа использует настройки предустановленные разработчиком, они записаны в коде.

Для редактирования цветов необходимо использовать HEX кодировку.
