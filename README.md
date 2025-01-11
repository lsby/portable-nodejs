# portable-nodejs

在当前目录生成全功能, 便携式的 nodejs.

可以运行 npm.

所谓便携式, 是指可以将其拷贝到任何计算机的任何路径下, 都可以正常使用.

只支持 windows.

## 使用

在你希望创建环境的目录用 PowerShell 执行:

```
irm "https://raw.githubusercontent.com/lsby/portable-nodejs/main/init.ps1" | iex
```

## 细节

nodejs 官方提供了独立二进制文件分发, 本仓库提供的 zip 文件为官方文件的副本.
