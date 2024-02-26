在Windows系统下创建一个类似于Linux环境的虚拟环境，并配置该环境以支持运行NCL应用程序和编辑NCL脚本

# 安装与配置指南

## 一、创建Linux环境

1. 将压缩文件`cygwin.rar`拷贝到`d:\`目录下；
2. 解压rar文件至当前文件路径。路径示例：`D:\cygwin\home`下会自动生成一个与Windows操作系统登录名同名的文件夹，其中包含`.bashrc`文件作为环境变量配置文件；
3. 若要启动X窗口，双击`D:\cygwin\bin\XWin.exe`文件用于NCL画图调试时X11模式输出。

## 二、NCL安装及配置

在Cygwin/X(Windows)系统下安装、配置NCL应用程序：

1. 在`D:\cygwin\app`路径下新建文件夹`ncl`；
2. 将压缩文件`ncl_ncarg-6.4.0-CYGWIN_NT-10.0-WOW_i686.tar.gz`拷贝到`D:\cygwin\app\ncl`路径下，然后解压缩；
3. 配置NCL的环境变量，编辑家目录下的`.bashrc`文件，并添加以下内容：
    ```bash
    export NCARG_ROOT=/app/ncl
    export PATH=$NCARG_ROOT/bin:$PATH
    export DISPLAY=:0.0
    ```
4. 使环境变量生效：
    - 在终端中进入家目录路径；
    - 输入 `source .bashrc` 命令使配置生效；
    - 测试NCL安装是否成功，输入 `ncl`。

## 三、Sublime3170安装以及NCL加载

### Sublime编辑器安装及NCL库加载

1. 安装`sublime text Build 3176.exe`，默认安装；
2. 打开Sublime Text，点击`Preferences` -> `Browse Packages`，进入文件夹`C:\Users\LR\AppData\Roaming\Sublime Text 3\Packages`，将`Package Control`包拷贝到该路径下；
3. 重启Sublime，将NCL包放入Package Control的同一路径下，再次重启Sublime；
4. 关联NCL后缀文件（打开方式选择始终使用Sublime Text 3打开该类文件），实现语法与关键参数高亮显示，并具备自动补全功能。

## 四、Windows Cygwin配置cron

该文档用于介绍Linux系统下Cygwin中配置cron服务，并举例增加NCL脚本作为定时服务执行的主要内容，具体步骤如下：

1. 安装cron服务：
    - 使用`cygwin`的`setup-x86.32.exe`，搜索并选择安装`cron:Vixie’s cron`；
2. 设置当前用户密码；
3. 编辑定时任务，通过`crontab -e`命令进入编辑状态，根据需求添加定时任务。

## 五、配置酸雨程序

1. 将`short`文件夹放置在`/cygwin/app/`下；
2. 将`month.ncl`, `quarter.ncl`, `semi_annual.ncl`, `annual.ncl`中的`file_path`改为待处理文本的绝对路径，例如：`/cygdrive/d/cygwin/app/work/`+文本名；
3. 编辑定时任务，使用`crontab -e`命令进行编辑，根据需求添加定时任务。
