curl -v -o intel-mkl-installer.exe "%WINDOWS_HPCKIT_URL%"
intel-mkl-installer.exe -s -x -f /d/a/webimage_extracted --log extract.log 
rm -v intel-mkl-installer.exe
webimage_extracted/bootstrapper.exe -s --action install --config ./build/oneapi-install-config-x64-windows.ini --log-dir=.