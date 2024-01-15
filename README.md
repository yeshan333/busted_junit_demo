# Lua Busted DEV Container

```shell
devcontainer build

devcontainer open

# get gtest output format
busted spec/busted_demo.spec.lua --output=gtest --output-file

# get junit output format
busted spec/busted_demo.spec.lua --output=junit

# specific out file
# demo: https://jenkins.shan333.cn/job/busted_junit_demo/2/testReport/
busted spec/busted_demo.spec.lua --output=junit --Xoutput official_junitv2.2.xml

# split xml out
# demo: https://jenkins.shan333.cn/job/busted_junit_demo/3/testReport/spec/
busted spec/*.spec.lua --output=junit --Xoutput true
# no cases
busted *.xxspec.lua --output=junit --Xoutput true
```