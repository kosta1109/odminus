
Функция ОписаниеПанели() Экспорт

	Описание = Новый ДеревоЗначений;
	Описание.Колонки.Добавить("Тип");
	Описание.Колонки.Добавить("Активность",Новый ОписаниеТипов("Булево"));
	Описание.Колонки.Добавить("Адрес"     ,Новый ОписаниеТипов("Строка"));
	Описание.Колонки.Добавить("Текст"     ,Новый ОписаниеТипов("Строка"));
	Описание.Колонки.Добавить("Картинка"  ,Новый ОписаниеТипов("Строка"));

	Возврат Описание;

КонецФункции

Функция ДобавитьСсылку(Знач Описание, Знач Адрес, Знач Текст, Знач Картинка = Неопределено, Знач Активна = Ложь) Экспорт
	Стр = Описание.Строки.Добавить();
	Стр.Тип = ТипыЭлементовПанели().Ссылка;
	Стр.Адрес =Адрес;
	Стр.Текст = Текст;
	Стр.Картинка = Картинка;
	Стр.Активность = Активна;
	Возврат Стр;
КонецФункции

Функция ТипыЭлементовПанели() Экспорт
	Возврат Новый Структура("Ссылка,Разделитель", "Ссылка","Разделитель");
КонецФункции

Функция СформироватьНавигацию(Знач Маршрутизатор) Экспорт
	
	Описание = ОписаниеПанели();

	ТекущийКонтроллер = Маршрутизатор.ЗначенияМаршрута["controller"];
	
	Если ТекущийКонтроллер = "agent-admins" Или ТекущийКонтроллер = "clusters" Тогда
		ДобавитьСсылкуАгента(Описание, Маршрутизатор, "clusters", "Кластеры серверов", "mif-cloud", ТекущийКонтроллер);
		ДобавитьСсылкуАгента(Описание, Маршрутизатор, "agent-admins", "Администраторы", "fas fa-user-shield", ТекущийКонтроллер);
	Иначе
		Кластер = ИдентификаторКластера(Маршрутизатор.ЗапросHttp);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "cluster","Обзор кластера", "fas fa-chart-line", ТекущийКонтроллер,"overview");
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "infobase","Информационные базы", "fas fa-database", ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "server","Рабочие серверы", "fas fa-server", ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "admins","Администраторы", "fas fa-user-shield", ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "manager","Менеджеры кластера", "mif-home", ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "process","Рабочие процессы", "fas fa-cogs", ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "session","Сеансы", "fas fa-users",ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "connection","Соединения", "fas fa-plug",ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "lock","Блокировки", "fas fa-unlock-alt",ТекущийКонтроллер);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "profile","Профили безопасности", "fas fa-shield-alt", ТекущийКонтроллер);
	КонецЕсли;

	Возврат Описание;

КонецФункции

Процедура ДобавитьСсылкуАгента(Описание, Маршрутизатор, ИмяКонтроллера, Текст, Картинка, ТекущийКонтроллер)
	ПараметрыСсылки = Новый Структура;
	ПараметрыСсылки.Вставить("controller",ИмяКонтроллера);
	Строка = БоковаяПанельНавигации.ДобавитьСсылку(Описание, Маршрутизатор.АдресМаршрута("ПоАгенту", ПараметрыСсылки), Текст, Картинка);
	Если ИмяКонтроллера = ТекущийКонтроллер Тогда
		Строка.Активность = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, ИмяКонтроллера, Текст, Картинка, ТекущийКонтроллер, ИмяДействия = "index")
	
	ПараметрыСсылки = Новый Структура;
	ПараметрыСсылки.Вставить("controller",ИмяКонтроллера);
	ПараметрыСсылки.Вставить("cluster"   ,Кластер);
	ПараметрыСсылки.Вставить("action"    ,ИмяДействия);
	Строка = ДобавитьСсылку(Описание, Маршрутизатор.АдресМаршрута("ПоАгенту", ПараметрыСсылки), Текст, Картинка);
	Если ИмяКонтроллера = ТекущийКонтроллер Тогда
		Строка.Активность = Истина;
	КонецЕсли;

КонецПроцедуры

Функция ИдентификаторКластера(ЗапросHttp)
	Параметры = ЗапросHttp.ПараметрыЗапроса();
	Возврат Параметры["cluster"];
КонецФункции