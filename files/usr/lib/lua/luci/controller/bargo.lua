# module 名称
module("luci.controller.bargo", package.seeall)

function index()
    # 4 个参数介绍
    # 1.后台访问路径 admin/services/bargo 
    # 2.target 动作（call, template, cbi）call 是调用自定义函数，template 调用 html 模板，cbi 调用 openwrt 的公共表单页面
    # 3.菜单名称 
    # 4.排序
    entry({"admin", "services", "bargo"}, cbi("bargo"), _("巴法云网络唤醒"), 1)
end