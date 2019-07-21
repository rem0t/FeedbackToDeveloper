# FeedbackToDeveloper
Позволяет настроить отправку сообщения с разных почтовых клиентов разработчику от юзера

Очень важно добавить в файле info.plist вашего проекта:

![Снимок экрана 2019-07-22 в 0 50 54](https://user-images.githubusercontent.com/23454470/61597672-ff5ead00-ac1b-11e9-85f3-db21ed4a8f54.png)

```
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>googlegmail</string>
		<string>readdle-spark</string>
		<string>ms-outlook</string>
	</array>

```
###### Поддерживаемые почтовые кленты 

- Gmail - gogle 
- Spark - readdle
- Microsoft Outlook - Microsoft

Добавить yandex.ru и mail.ru
