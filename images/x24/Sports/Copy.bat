@echo

SET dst64release=C:\!MyData\MyBetaSoftware\Seattle\DAZN\Win64\Release\images
SET dst64debug=C:\!MyData\MyBetaSoftware\Seattle\DAZN\Win64\Debug\images
SET dst32release=C:\!MyData\MyBetaSoftware\Seattle\DAZN\Win32\Release\images

for %%i in (*.png) do (
	copy /y %%i %dst64release%\%%i
	copy /y %%i %dst64debug%\%%i
	copy /y %%i %dst32release%\%%i
)
