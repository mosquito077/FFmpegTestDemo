###  使用FFmpeg-iOS、kxmovie实现视频播放
> 由于FFmpeg开源框架可以播放的视频种类有很多，同时添加第三方库kxmovie实现视频播放，简直是酷爆了。这里详细介绍了关于FFmpeg在iOS上的一些配置过程和配置过程中的一些坑。

#####  一、iOS编译FFmpeg生成FFmpeg-iOS文件
1.下载gas-preprocessor（编译ffmpeg需要的脚本文件）

```
git clone https://github.com/libav/gas-preprocessor
cp -R ~/Downloads/gas-preprocessor-master/gas-preprocessor.pl /usr/local/bin
```

2.下载安装yasm

```
brew install yasm
```

3.编译FFmpeg-iOS-build-script

> FFmpeg-iOS-build-script这个脚本,可以直接转为iOS编译可用的ffmpeg库，我们不用下载ffmpeg，脚本会帮我们下载最新版本的ffmpeg，并且打包成一个iOS可用的ffmpeg库。

```
git clone https://github.com/kewlbear/FFmpeg-iOS-build-script
cd FFmpeg-iOS-build-script文件夹路径
./build-ffmpeg.sh    （生成FFmpeg-iOS文件）
```
![](http://ww3.sinaimg.cn/large/0060lm7Tly1fpjdz3313nj30xk09mwgf.jpg)


4.下载kxmovie

```
git clone https://github.com/applexiaohao/kxmovie
```

#### 二、新建Xcode工程，FFmpegTestDemo
1.新建demo，将FFmpeg-iOS和kxmovie文件添加到工程里
![22](media/15211902572072/22.png)

2.添加类库

```
VideoToolbox.framework
libiconv.tbd
libbz2.tbd
libz.tbd
```

#### 三、处理编译过程中的错误

> 问题1：'libavformat/avformat.h' file not found

```
错误是由于文件路径不对，需要在Build Settings -> Header Search Paths 添加文件路径。
$(SRCROOT)/FFmpegDemo/FFmpeg-iOS/include
```

> 问题2：Use of undeclared identifier 'PIX_FMT_RGB24'; did you mean 'AV_PIX_FMT_RGB24'?


```
将 'PIX_FMT_RGB24'改变成'AV_PIX_FMT_RGB24'
```

> 问题3：Expected a type、Use of undeclared identifier 'UIImage'

```
KxMovieDecoder.h缺少头文件#import <UIKit/UIKit.h>
```

> 问题4：FFmpeg 3.0还会出现以下错误信息
> Undefined symbols for architecture armv7:
  "_avpicture_deinterlace", referenced from:
      -[KxMovieDecoder decodeFrames:] in KxMovieDecoder.o
ld: symbol(s) not found for architecture armv7
clang: error: linker command failed with exit code 1 (use -v to see invocation)


```
注释avpicture_deinterlace（）函数即可
```   





