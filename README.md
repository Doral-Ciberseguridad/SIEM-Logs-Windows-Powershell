Pasos para ejecutar y usar esta herramienta:


1. Descarga el script powershell de este repositorio.


2. Lanza el script de PowerShell haciendo clic derecho y seleccionando "Ejecutar con PowerShell" o desde tu terminal elevada ejecutando:

```
./SIEM_log.ps1
```

3. Asegurate de configurar los parámetros de correo electrónico y de revisar o editar el archivo de configuración de IDs de eventos (`eventos_config.txt`) según tus preferencias

<img width="236" height="123" alt="image" src="https://github.com/user-attachments/assets/8024cc51-ee5c-4b31-ba95-9cc202a8701f" />

(El archivo se creará cuando ejecutes el script, por eso es normal si da error al principio)

En este archivo debes de guardar los eventos ID de seguridad de Windows. Si no sabes cuales son échale un vistazo a esta pagina web:

```
https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/appendix-l--events-to-monitor
```



4. Vuelve a ejecutar el archivos powershell y comprueba en pantalla la lectura del archivo de configuración de eventos y el análisis de los registros de seguridad del sistema

<img width="1069" height="285" alt="image" src="https://github.com/user-attachments/assets/b087bcbe-9800-4e35-96a1-cb1ad96ba4a2" />




5. Visualiza si se han generado alertas por coincidencia de eventos críticos o si el sistema se encuentra sin incidencias, y crea una tarea programada que ejecute el script powershell cada X minutos.

<img width="862" height="714" alt="image" src="https://github.com/user-attachments/assets/3db3051c-2676-4708-b547-307c9bfe58f5" />

Este paso es necesario para la ejecucion persistente de esta herramienta


