# Lua Busted DEV Container

```shell
devcontainer build

devcontainer open

# get gtest output format
busted busted_demo.spec.lua --output=gtest --output-file

# get junit output format
busted busted_demo.spec.lua --output=junit

# specific out file
busted busted_demo.spec.lua --output=junit --Xoutput official_junitv2.2.xml

busted busted_demo.spec.lua --output=junit --Xoutput non.xml,true
```