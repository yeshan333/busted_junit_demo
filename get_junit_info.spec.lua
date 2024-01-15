local function SplitFilePath(path)
    local directory, filename
    if string.match(path, "/") or string.match(path, "\\") then
        directory, filename = path:match("(.-)[\\/]+([^\\/]+)$")
    else
        filename = path
        directory = ""
    end


    -- directory unexist
    if directory == "" then
        directory = nil
    end

    -- file extension
    local extension = filename:match("^.+%.(.-)$")

    return directory, filename, extension
end

describe("SplitFilePath", function()
    describe("/path/to/file.txt", function()
        local directory, filename, extension = SplitFilePath("/path/to/file.txt")
        it("dir is /path/to", function()
            assert.are.same("/path/to", directory)
        end)

        it("filename is file.txt", function()
            assert.are.same("file.txt", filename)
        end)

        it("extension is txt", function()
            assert.are.same("txt", extension)
        end)
    end)

    describe("/another/path/to/another_file.csv", function()
        local directory, filename, extension = SplitFilePath("/another/path/to/another_file.csv")
        it("dir is /another/path/to", function()
            assert.are.same("/another/path/to", directory)
        end)

        it("filename is another_file.csv", function()
            assert.are.same("another_file.csv", filename)
        end)

        it("extension is csv", function()
            assert.are.same("csv", extension)
        end)
    end)

    describe("no_directory.txt", function()
        local directory, filename, extension = SplitFilePath("no_directory.txt")
        it("dir is nil", function()
            assert.is_nil(directory)
        end)

        it("filename is no_directory.txt", function()
            assert.are.same("no_directory.txt", filename)
        end)

        it("extension is txt", function()
            assert.are.same("txt", extension)
        end)
    end)

    describe("C:\\Windows\\System32\\notepad.exe", function()
        local directory, filename, extension = SplitFilePath("C:\\Windows\\System32\\notepad.exe")
        it("dir is C:\\Windows\\System32", function()
            assert.are.same("C:\\Windows\\System32", directory)
        end)

        it("filename is notepad.exe", function()
            assert.are.same("notepad.exe", filename)
        end)

        it("extension is exe", function()
            assert.are.same("exe", extension)
        end)
    end)

    describe("C:\\directory with spaces\\file with spaces.txt", function()
        local directory, filename, extension = SplitFilePath("C:\\directory with spaces\\file with spaces.txt")
        it("dir is C:\\directory with spaces", function()
            assert.are.same("C:\\directory with spaces", directory)
        end)

        it("filename is file with spaces.txt", function()
            assert.are.same("file with spaces.txt", filename)
        end)

        it("extension is txt", function()
            assert.are.same("txt", extension)
        end)
    end)
end)