# portable-nodejs

在当前目录生成全功能, 便携式的 nodejs.

可以运行 npm.

所谓便携式, 是指可以将其拷贝到任何计算机的任何路径下, 都可以正常使用.

只支持 windows.

## 使用

在希望创建环境的目录用 PowerShell 执行:

```
irm "https://raw.githubusercontent.com/one-click-run/portable-nodejs/main/init.ps1" | iex
```

也可以直接指定版本:

```
$env:ONE_CLICK_RUN_PORTABLE_NODEJS_SELECTEDMATCH = 'node-v22.13.0-win-x64.zip'; irm 'https://raw.githubusercontent.com/one-click-run/portable-nodejs/main/init.ps1' | iex
```

## 说明

nodejs 官方提供了独立二进制文件分发, 本仓库提供的 zip 文件为官方分发的副本.
