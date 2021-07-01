// this file itself doesn't commit anything, use task scheduler and import the xml file form github
cd "C:\AHK\2nd-keyboard"
git add --all
git commit -m "AutoCommit %date:~-4%%date:~3,%%time:~0,2%%time:~3,2%%time:~6,2%
git push
exit