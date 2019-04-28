--[[
Use
Type m x y d, where m - move, x y coordinates, d - direction. Use empty input for slow down and fill new crystals
And empty input for the next step of logic and animation

Check this for your operation system
   os.execute("clear") -- for Unix
   os.execute("cls") -- for Windows
]]--
require "Board"

function init()
   Game_Name = "THREE IN A ROW"
   M = 10
   N = 10
   Score = 0
   board = Board:new(M, N)
   while board:check_three() ~= 0 do
      board:shufle()
   end
   Input = " "
   Msg = "Input comand q - quit, h - help"
end

function dump()

   local lines = {"\n"}

   os.execute("clear") -- for Unix
   --os.execute("cls") -- for Windows

   for y = -1, board.M-1 do  -- step all stack
         if y < 0 then -- first and second lines
            local line = "      "
            for x = 0, board.N - 1 do
               line = line .. " " .. x
            end 
            table.insert(lines, line)
            table.insert(lines, "     " .. string.rep("-", board.N*2+1))
         else -- body of the main field
            local line =  y .. string.rep(" ", 4 - math.floor(y/10)) .. "|" -- choose correct count of space  
            for x = 1, board.N do
               line = line .. " " .. board.Field[x+y*board.N]
            end
            table.insert(lines, line)
         end
      end

   print("\n".. "            " .. Game_Name)
   print(table.concat(lines,"\n").."\n")
   print("Score: " .. Score)
   print(Msg)
end

function tick()
   board:down_free()
   board:fill_free()
   board:del_three()
   local x = tonumber(string.sub(Input,3,3)) 
   local y = tonumber(string.sub(Input,5,5))
   if string.sub(Input,1,1) == "m" then
      if x and y then
         if string.sub(Input, 7, 7) == "u" then
            board:replace(x, y, x, y-1)
         elseif string.sub(Input, 7, 7) == "d" then
            board:replace(x, y, x, y+1)
         elseif string.sub(Input, 7, 7) == "l" then
            board:replace(x, y, x-1, y)
         elseif string.sub(Input, 7, 7) == "r" then
            board:replace(x, y, x+1, y)
         end
         Score = Score + board:del_three()
         dump()
      end
      elseif string.sub(Input,1,1) == "h" then
         Msg = "Type m x y d, where m - move, x y coordinates, d - direction. Use empty input for slow down and fill new crystals"
         dump()
      elseif Input== "" then
      
      else
      Msg = "Incorrect move! Type 'h' for help."
   end
end

function mix()
    while board:check_pos_three() == 0 do -- shufle a bord for combination
      board:shufle()
   end
end



init()
while Input ~= "q" do
   dump()
   tick()
   Input = io.read()
   mix() 
end
