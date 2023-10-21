function Send-Email {
    $az104 = Get-Content ".\questions.txt"
    $username = (Get-Content ".\creds.txt")[0]
    $password = (Get-Content ".\creds.txt")[1] | ConvertTo-SecureString -AsPlainText -Force

    $notes = $az104 | Sort-Object{Get-Random}
    $randomNotes = $notes[0..11]
    $text = foreach($note in $randomNotes){
        "<li>$note</li>"
    }

    $body = @"
    <h1>AZ-104 Revision</h1>
    <ul>
        $text
    </ul>
"@
    $email = @{
        from = $username
        to = $username
        subject = "Az-104 Revision"
        smtpserver = "smtp.gmail.com"
        body = $body
        port = 587
        credential = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $password
        usessl = $true
        verbose = $true
    }
    
    Send-MailMessage @email -BodyAsHtml
}

Send-Email