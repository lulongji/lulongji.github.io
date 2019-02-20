---
layout:     post
title:      CentOs [Install oracle]
subtitle:   oracle搭建
date:       2016-06-25
author:     lulongji
header-img: img/post-bg-2015.jpg
catalog: true
tags:
    - oracle
    - linux
---

# 开始
以下是oracle11g 安装。

# 硬件要求
- 物理内存：最少1GB
- 交互空间：物理内存为1GB至2GB之间时，交互空间为物理内存的1.5倍；物理内存为2GB至8GB之间时，交互空间为物理内存的1倍；物理内存为8GB以上时，交互空间为物理内存的0.75倍。
- 磁盘空间：企业版4.35GB；标准版3.22GB；自定义（最大值）：3.45GB

# 检查内存情况
    grep MemTotal /proc/meminfo
    grep SwapTotal /proc/meminfo

# 到官网下载安装包
``` linux.x64_11gR2_database_1of2.zip ```
``` linux.x64_11gR2_database_1of2.zip ```

# 解压
    unzip linux.x64_11gR2_database_1of2.zip
    unzip linux.x64_11gR2_database_2of2.zip

两个解压包会同时解压到同一个目录下面，生成database，到这里就把安装包的工作做完了。

# 安装依赖
    yum -y install binutils compat-libstdc++-33 compat-libstdc++-33.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-devel.i686 glibc-headers ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make sysstat unixODBC unixODBC-devel

# 添加Oracle用户信息
创建oinstall、dba组，将oracle用户加入组，最后一步设定oracle用户的密码.

    groupadd oinstall
    groupadd dba
    useradd -g oinstall -G dba oracle
    passwd oracle

# 修改内核参数
    vim /etc/sysctl.conf
在该配置文件中修改以下参数，如果不存在的就是直接添加，如果默认值比参考值大的话，就不需要修改。

    fs.aio-max-nr = 1048576
    fs.file-max = 6815744
    kernel.shmall = 2097152
    kernel.shmmax = 536870912
    kernel.shmmni = 4096
    kernel.sem = 250 32000 100 128
    net.ipv4.ip_local_port_range = 9000 65500
    net.core.rmem_default = 262144
    net.core.rmem_max = 4194304
    net.core.wmem_default = 262144
    net.core.wmem_max = 1048586

编辑完后保存，执行以下命令使其生效.

    sysctl -p

# 修改用户资源
    vim /etc/security/limits.conf

配置文件的最下方加入以下参数:

    oracle              soft    nproc  2047
    oracle              hard    nproc  16384
    oracle              soft    nofile  1024
    oracle              hard    nofile  65536
    oracle              soft    stack   10240


    vim /etc/pam.d/login
在配置文件中加入:

    session required /lib/security/pam_limits.so
    session required pam_limits.so

# 创建安装目录并授权
    mkdir -p /usr/local/oracle /usr/local/oraInventory /usr/local/oradata/
    chown -R oracle:oinstall /usr/local/oracle /usr/local/oraInventory /usr/local/oradata/
    chmod -R 775 /usr/local/oracle /usr/local/oraInventory /usr/local/oradata/

# 编辑oraInst.loc文件
    vim /etc/oraInst.loc

在文件中加入下面的内容：

    inventory_loc=/usr/local/oraInventory
    inst_group=oinstall

执行如下命令授权：

    chown oracle:oinstall /etc/oraInst.loc
    chmod 664 /etc/oraInst.loc

# db_install.rsp文件
该文件默认保存在```database/response```下，把response下的所有文件都拷贝到```/usr/local/oracle```文件夹下

    cp /home/database/response/* /usr/local/oracle/
修改安装所需的所有应答文件的所属组及权限

    chown  oracle:oinstall /usr/local/oracle/*.rsp
    chmod 755 /usr/local/oracle/*.rsp
配置```db_install.rsp```文件

    vim /usr/local/oracle/db_install.rsp
文件内修改相应的参数配置如下：

    oracle.install.option=INSTALL_DB_SWONLY     　//安装类型,只装数据库软件
    ORACLE_HOSTNAME=serv2.lin.vm.ncu        //主机名称（在命令行输入hostname查询）
    UNIX_GROUP_NAME=oinstall           　　　　// 安装组
    INVENTORY_LOCATION=/usr/local/oraInventory  　//INVENTORY目录（**不填就是默认值,本例此处需修改,因个人创建安装目录而定）
    SELECTED_LANGUAGES=en,zh_CN    　　 　　// 选择语言
    ORACLE_HOME=/usr/local/oracle/product/11.2.0/db_1  　// oracle_home *路径根据目录情况注意修改 本例安装路径/usr/local/oracle
    ORACLE_BASE=/usr/local/oracle                  // oracle_base *注意修改
    oracle.install.db.InstallEdition=EE          　　// oracle版本
    oracle.install.db.isCustomInstall=false      　　//自定义安装，否，使用默认组件
    oracle.install.db.DBA_GROUP=dba              　　　 //dba用户组
    oracle.install.db.OPER_GROUP=oinstall        　　 //oper用户组
    oracle.install.db.config.starterdb.type=GENERAL_PURPOSE   //数据库类型
    oracle.install.db.config.starterdb.globalDBName=orcl      //globalDBName
    oracle.install.db.config.starterdb.SID=orcl  　　　　 //SID（**此处注意与环境变量内配置SID一致）
    oracle.install.db.config.starterdb.memoryLimit=81920      //自动管理内存的内存(M)
    oracle.install.db.config.starterdb.password.ALL=oracle    //设定所有数据库用户使用同一个密码
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false       　　//（手动写了false）
    DECLINE_SECURITY_UPDATES=true　　　　　　　　　　// **注意此参数 设定一定要为true

# 设置Oracle的用户环境
由root切换至创建好的oracle用户

    su – oracle

修改该用户的用户配置文件，该文件就在~目录下，可以先执行cd 或者cd ~

　　vim .bash_profile

文件内加入并修改至以下内容

    export ORACLE_BASE=/usr/local/oracle
    export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
    export ORACLE_SID=orcl   
    export ORACLE_OWNER=oracle
    export PATH=$PATH:$ORACLE_HOME/bin:$HOME/bin

保存退出后执行source命令立即生效。

    source .bash_profile

# 在Oracle用户下开始安装
    cd /home/database/   
    ./runInstaller -silent -force -ignorePrereq -responseFile  /usr/local/oracle/db_install.rsp

参数说明：

    　　/home/database 是安装包解压后的路径，此处根据安装包解压所在位置做修改，因人而异。
    　　runInstaller 是主要安装脚本
    　　-silent 静默模式
    　　-force 强制安装
    　　-ignorePrereq忽略warning直接安装。
    　　-responseFile读取安装应答文件。

# 运行脚本
执行完安装指令后，在原来那个窗口（1号窗口）可以什么事情都不做，重开一个命令行窗口（2号窗口），以root身份登录到服务器。
在2号窗口进入```/usr/local/oracle/product/11.2.0/db_1```目录，可以看到安装数据库已经装在这个目录下了，并且有一个root.sh文件在这个目录下。这个时候等1号窗口出现以下提示，安装编译需要一定的时间，请耐心等待。

```
#-------------------------------------------------------------------
　　/usr/oracle/oraInventory/orainstRoot.sh（这一句可能没有。。具体原因我也不清楚，不影响安装，如果有这一句，也要运行这个orainstRoot.sh脚本）
　　/usr/oracle/product/11.2.0/db_1/root.sh
 
　　To execute the configuration scripts:
 
　　1. Open a terminal window
 
　　2. Log in as "root"
 
　　3. Run the scripts
 
　　4. Return to this window and hit"Enter" key to continue
 
 　　Successfully Setup Software.
#-------------------------------------------------------------------
```
出现以上界面后，到2号窗口运行root.sh脚本

    ./root.sh

数据库安装过程到这里结束，下面是配置。

# 数据库的配置和创建
创建数据库，这儿切换成root用户,进入```/usr/local/oracle```目录，编辑dbca.rsp创建数据库应答文件：

    vim dbca.rsp

修改几个参数，如果这几个参数被注释了，要取消注释（这个文件一定要修改，否则会造成数据库创建后无法挂载）

    GDBNAME = “orcl”
    SID = “orcl”
    CHARACTERSET = “ZHS16GBK”
    NATIONALCHARACTERSET= “AL16UTF16”
    SOURCEDB = “serv2.lin.vm.ncu:1521:orcl”

保存退出后，执行dbca指令创建数据库：

    dbca -silent -responseFile dbca.rsp

到这的时候，会提示输入sys口令，输入oracle，千万不要回车，然后等待，直到出现以下界面
```
…………………………
Copying database files
1% complete
3% complete
11% complete
18% complete
26% complete
37% complete
Creating and starting Oracle instance
40% complete
…………………………
```
 
执行到100%后，数据库创建完成


# 开启数据库网络监听
还在刚才的目录下，有一个netca.rsp文件,执行以下命令

    netca -silent -responseFile netca.rsp

开启监听

    lsnrctl start
    dbstart $ORACLE_HOME


# 基本命令
sqlplus  /  as  sysdba

启动数据库
    startup

停止数据库
    shutdown immediate
    
解锁的命令

    alter user system account unlock;

修改密码

    alter user system identified by 123456;

创建用户

    create  user test identified by test;
  

给用户授权

    grant connect,resource to test;




    













