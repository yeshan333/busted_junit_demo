print(package.path)
print(package.cpath)

package.path = package.path .. ";src/dump_busted_struct.lua"


describe("Busted unit testing framework", function()
    describe("should be awesome", function()
      it("should be easy to use", function()
        assert.truthy("Yup.")
      end)

      it("should have lots of features", function()
        -- deep check comparisons!
        assert.are.same({ table = "great"}, { table = "great" })

        -- or check by reference!
        assert.are_not.equal({ table = "great"}, { table = "great"})

        assert.truthy("this is a string") -- truthy: not false or nil

        assert.True(1 == 1)
        assert.is_true(1 == 1)

        assert.falsy(nil)
        assert.has_error(function() error("Wat") end, "Wat")
        assert.True(1 == 2)
      end)

      it("should provide some shortcuts to common functions", function()
        assert.are.unique({{ thing = 1 }, { thing = 2 }, { thing = 3 }})
      end)

      describe("spies", function()
        it("registers a new spy as a callback", function()
          local s = spy.new(function() end)

          s(1, 2, 3)
          s(4, 5, 6)

          assert.spy(s).was.called()
          assert.spy(s).was.called(2) -- twice!
          assert.spy(s).was.called_with(1, 2, 3) -- checks the history
          assert.spy(s).was.called_with(4, 5, 6) -- checks the history
        end)

        -- it("replaces an original function", function()
        --   local t = {
        --     greet = function(msg) print(msg) end
        --   }

        --   local s = spy.on(t, "greet")

        --   t.greet("Hey!") -- prints 'Hey!'
        --   assert.spy(t.greet).was_called_with("Hey!")

        --   t.greet:clear()   -- clears the call history
        --   assert.spy(s).was_not_called_with("Hey!")

        --   t.greet:revert()  -- reverts the stub
        --   t.greet("Hello!") -- prints 'Hello!', will not pass through the spy
        --   assert.spy(s).was_not_called_with("Hello!")
        -- end)
      end)
    end)
end)