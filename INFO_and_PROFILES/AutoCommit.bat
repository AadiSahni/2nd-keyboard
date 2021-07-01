// this file itself doesn't commit anything, use task scheduler and import the xml file form github
cd "C:\AHK\2nd-keyboard"
git add --all
git commit -m "AutoCommit %date:~-4%%date:~3,1%%time:~0,1%%time:~3,1%%time:~6,1%
git push
exit