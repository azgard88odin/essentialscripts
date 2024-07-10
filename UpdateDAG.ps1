# This program is to be used for the updating of the .apk file of the package on an android device
# This was made to speed up the updating and/or rollback of a custom application not posted on the play store
# make sure you have your .apk file and the rest is pretty simple, update the variables and press F5

$apkFile = "C:\Users\USERNAME\APK\yourProgramFile.apk"

$adb = "C:\Users\USERNAME\AndroidDebugBridge\adb.exe"
$appName = "PACKAGE_NAME"

$downloadFolder = "/sdcard/Download/"

# Upload the .apk file to the device
# This is for when you wish to have a backup and manually run it on the device
# Feel free to remove the $downloadFolder variable and the following line
& $adb push $apkFile $downloadFolder

# Stop the existing instance of the app, if running
& $adb shell am force-stop $appName

# Replace the APK file. -g option grants the apk all permissions
& $adb install -g $apkFile

# Confirm the "Success" message on the terminal screen
# If not successful, validate your variables and paths and run again
# Even if it was correct the first time, try it again