require("luci.sys")

# 页面标题和描述
m = Map("bargo", translate("巴法云网络唤醒"), translate("通过巴法云远程启动本地网络内的计算机"))

# 读取配置文件
s = m:section(TypedSection, "server", "")
s.addremove = false
s.anonymous = true

# 是否启用的选择框
enable = s:option(Flag, "enable", translate("Enable"))
# 映射我们的配置到输入框
privateKey = s:option(Value, "privateKey", translate("PrivateKey"))
privateKey.password = true
topic = s:option(Value, "topic", translate("Topic"))

host = s:option(Value, "mac", translate("Host to wake up"),
        translate("Choose the host to wake up or enter a custom MAC address to use"))

sys.net.mac_hints(function(mac, name)
        host:value(mac, "%s (%s)" %{ mac, name })
end)


# 如果点击了保存按钮
local apply = luci.http.formvalue("cbi.apply")
if apply then
    # 这里是调用我们自己的程序脚本，后面会讲怎么来写这个脚本
    io.popen("/etc/init.d/bargo restart > /dev/null &")
end

return m