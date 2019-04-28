Board = {}

function Board:new(m, n) -- create class Board 

   local obj = {}
      obj.M = m
      obj.N = n
      obj.Size = m*n
      obj.Field = {}
      
   function Board:rand_cr() -- random types of crystals 
      local cr = {"A", "B", "C", "D", "E", "F"}
      return cr[math.random(#cr)]
   end

   for n = 1, obj.Size do -- fill the board
      obj.Field[n] = Board:rand_cr()
   end

   function Board:del_three() -- get three in a row crystals 
   
      local matches = 0 -- just game element, count of score
      
      for p = 1, self.Size do -- check horizontal
         if self.Field[p] ~= " " then
            if self.Field[p] == self.Field[p+1] and self.Field[p] == self.Field[p+2] then
               self.Field[p] = " "
               self.Field[p+1] = " "
               self.Field[p+2] = " "
               matches = matches + 1
            end

            if self.Field[p] == self.Field[p+self.N] and self.Field[p] == self.Field[p+self.N*2] then -- check vertical
               self.Field[p] = " "
               self.Field[p+self.N] = " "
               self.Field[p+self.N*2] = " "
               matches = matches + 1
            end
         end
      end
      return matches
   end

   function Board:check_three() -- check possible move
   
      local matches = 0
      
      for p = 1, self.Size do
         if self.Field[p] ~= " " then
            if self.Field[p] == self.Field[p+1] and self.Field[p] == self.Field[p+2] then -- check horizontal
               matches = matches + 1
            end
            if self.Field[p] == self.Field[p+self.N] and self.Field[p] == self.Field[p+self.N*2] then -- check vertical
               matches = matches + 1
            end
         end
      end
      return matches
   end 
   
   function Board:check_pos_three() -- check possible move
   
      local matches = 0
      
      for p = 1, self.Size do
         if self.Field[p] ~= " " then
            if self.Field[p] == self.Field[p+1] and self.Field[p] == self.Field[p+3] then -- check horizontal
               matches = matches + 1
            end
            if self.Field[p] == self.Field[p+self.N] and self.Field[p] == self.Field[p+self.N*3] then -- check vertical
               matches = matches + 1
            end
         end
      end
      return matches
   end 
   
   

   function Board:shufle() -- shufle the board
      for n = 1, self.Size do
         local seed = math.random(1, 4) -- replace with 1-4 places
         local temp = 0
         if self.Field[n+seed] ~= nil and self.Field[n] ~= nil then
            temp  = self.Field[n]
            self.Field[n] = self.Field[n+seed]
            self.Field[n+seed] = temp
         end   
      end
   end

   function Board:down_free() -- slow down crystall to free space
      for i = 1, self.M do
         for p = 1, self.Size do
               if self.Field[p+self.N] == " " then
                  self.Field[p+self.N] = self.Field[p]
                  self.Field[p] = " "
               end
         end
      end
   end

   function Board:fill_free() -- get new crystals to free space
      for p = 1, self.Size do
         if self.Field[p] == " " then
            self.Field[p] = self:rand_cr()
         end
      end
   end

   function Board:replace(x, y, x1, y1)
      if self.Field[x+1+y*self.N] ~= nil and self.Field[x1+1+y1*self.N] ~= nil then
         local temp = self.Field[x+1+y*self.N]
         self.Field[x+1+y*self.N] = self.Field[x1+1+y1*self.N]
         self.Field[x1+1+y1*self.N] = temp
      end
   end

   
   

   function Board:to_string() -- Board to string

      local lines = {"\n"}

      for y = -1, self.M-1 do  -- step all stack
         if y < 0 then -- first and second lines
            local line = "      "
            for x = 0, self.N - 1 do
               line = line .. " " .. x
            end 
            table.insert(lines, line)
            table.insert(lines, "     " .. string.rep("-", self.N*2+1))
         else -- body of the main field
            local line =  y .. string.rep(" ", 4 - math.floor(y/10)) .. "|" -- choose correct count of space  
            for x = 1, self.N do
               line = line .. " " .. self.Field[x+y*self.N]
            end
            table.insert(lines, line)
         end
      end
      
      return table.concat(lines,"\n")

   end
   
   setmetatable(obj, self)
   self.__index = self;
   return obj
end

