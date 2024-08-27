curl -v -o intel-mkl-installer.exe "%WINDOWS_HPCKIT_URL%"
intel-mkl-installer.exe -s -x -f webimage_extracted --log extract.log 
rm -v intel-mkl-installer.exe
dir
webimage_extracted\bootstrapper.exe -s --action install --config ci-scripts\oneapi-install-config-x64-windows.ini --log-dir=.