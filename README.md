# Android Toolkit
Reverse engineering tools for Android

## Install
Requires [fzf](https://github.com/junegunn/fzf) and [adb](https://developer.android.com/studio/releases/platform-tools.html).

Install globally:
```
sudo ln -s /absolute/pull.sh /usr/local/bin/pull
```

## Scripts
#### pull.sh
Downloads an Android app from current debugging device by searching installed packages.

#### decompile.sh APK_FILE
1. Uncompress APK archive
1. Convert dex files to java class files ([dex2jar](https://github.com/pxb1988/dex2jar))
1. Decompile class files to plain java ([jd-core](https://github.com/java-decompiler/jd-core))
