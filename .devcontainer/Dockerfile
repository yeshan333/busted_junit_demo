FROM imolein/luarocks:5.4-fat

RUN luarocks install busted \
    && luarocks install luacheck \
    && luarocks install lua-cjson

# docker build -t your-image-name -f path/to/Dockerfile /path/to/build/context
COPY outputHandlers/junit_modified.lua /usr/local/share/lua/5.4/busted/outputHandlers/junit.lua

ENTRYPOINT ["tail", "-f", "/dev/null"]