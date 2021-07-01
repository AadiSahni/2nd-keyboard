// this file itself doesn't commit anything, use task scheduler and import the xml file form github
cd "C:\AHK\2nd-keyboard"
git add --all
git commit -m "AutoCommit %date:~;
git push
exit