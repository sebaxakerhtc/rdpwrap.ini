echo 'Downloading INI file...'
Invoke-WebRequest 'https://raw.githubusercontent.com/sebaxakerhtc/rdpwrap.ini/master/rdpwrap.ini' -OutFile '.\rdpwrap.ini'

echo 'Copying INI file...'
Copy-Item -Path '.\rdpwrap.ini' -Destination 'C:\Program Files\RDP Wrapper\rdpwrap.ini' -Force

echo 'Stopping RDP service'
net stop TermService
# Stop-Service termservice -Force

Start-Sleep -Seconds 1

echo 'Starting RDP service'
net start TermService
# Start-Service termservice