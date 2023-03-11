# 小爱同学-打开电脑

此项目的作用一共两个：

- 学习 openwrt package 开发
- 实现 mqtt 订阅巴法云消息并执行 etherwake 开机指令，以实现小爱同学打开电脑。


## 通信链路
bfWakePc <-> 巴法云 <-> 米家小爱/天猫精灵/小度音响/Amazon Alexa

## 如何编译？
将此项目复制到 openwrt-sdk/package/
执行命令
``` sheel
cd ~/openwrt-sdk
./scripts/feeds install bfWakePc
make package/bfWakePc/compile V=sc
```

编译完成后会打印 ipk 文件所在位置，将 ipk 上传到路由器中安装即可
