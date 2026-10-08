# Configuro los parametros de correo electronico
$smtpServer = "smtp.gmail.com"
$from = "INTRODUCE_TU_CORREO"
$usuario = "INTRODUCE_TU_CORREO"
$passApp = "INTRODUCE_TU_PASSWORD_APLICACION"
$to = "INTRODUCE_TU_CORREO_DESTINO"
$securePass = $passApp | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($usuario, $securePass)




# Creo y compruebo que el archivo de configuracion de IDs existe
$ruta_config_eventos = "$PSScriptRoot\eventos_config.txt"
Write-Host ""
if (Test-Path $ruta_config_eventos) {
    $eventosConfigurados = Get-Content -Path $ruta_config_eventos
    Write-Host "Todos los IDs de eventos Windows que aparezcan en $ruta_config_eventos seran alertados y enviados a tu correo electronico. Debes configurar este arcivo segun tus preferencias." -ForegroundColor Green
} else {
    Write-Host "No se encontro el archivo de configuracion de eventos en: $ruta_config_eventos" -ForegroundColor Red
    exit
}




# Envio una alerta por correo electronico si detecto un evento ID definido en el archivo ce configuracion
Write-Host ""
$subject = "Alerta: Nuevo evento critico detectado"
$ultimos_eventos = Get-WinEvent -Path "C:\Windows\System32\winevt\Logs\Security.evtx" -MaxEvents 300
$eventosCoincidentes = $ultimos_eventos | Where-Object { $_.Id -in $eventosConfigurados }
if ($eventosCoincidentes) {
    $idsEncontrados = ($eventosCoincidentes.Id | Select-Object -Unique) -join ", "
    $body = "Se ha detectado actividad en el sistema de los siguientes eventos criticos configurados: ID(s) [$idsEncontrados]."
    Send-MailMessage -SmtpServer $smtpServer -From $from -To $to -Subject $subject -Body $body -Credential $cred -UseSsl -Port 587
    Write-Host "Se ha generado una o mas alertas! Revisa tu correo electronico." -ForegroundColor Yellow
} else {
    Write-Host "No se han detectado eventos coincidentes en los ultimos registros." -ForegroundColor Cyan
}
$ultimos_eventos = $null
$eventosCoincidentes = $null




# Le explico al usuario que tiene que hacer si quiere que este programa se ejecute de manera constante
Write-Host ""
Write-Host "Si quieres que ese script se ejecute siempre en segundo plano de manera persistente debes crear manualmente una tarea programada."
Write-Host "Te recomiendo que sigas esta guia:"
Write-Host "https://blog.victorsilva.com.uy/powershell-ejecutar-script-de-manera-programada/"




# Imprimo el mensaje final
Write-Host ""
Write-Host "Fin del programa."
Write-Host ""
