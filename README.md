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

# split xml out
busted *.spec.lua --output=junit --Xoutput true
# no cases
busted *.xxspec.lua --output=junit --Xoutput true
```