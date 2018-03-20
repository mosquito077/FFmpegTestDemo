# FFmpegTestDemo

Tips:
根据https://github.com/gaoyuhang/FFmpegTest修改而成的Demo,引用FFmpegTest中FFmpeg-iOS和KxMovie文件时有需要修改的地方如下：
1.TARGETS -> General -> Linked Frameworks and Libraries 添加libz.tbd,libbz2.tbd,libiconv.tbd

2.项目中有使用#include的地方，修改文件路径 TARGETS -> Build Settings -> Search Paths:
将Library Search Paths里面的路径内容复制到Header Search Paths中

3.真机运行的时候会出现“does not contain bitcode.”的错误,原因是某些二进制库不支持bitcode,而Xcode默认是要支持bitcode的.将TARGETS -> Build Settings -> Enable bitcode从YES置为NO
