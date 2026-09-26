local Anim = {}

Anim.__index = Anim

function Anim:new(calendar)
  local o = {}
  setmetatable(o, self)
  o.calendar = calendar -- Store reference to Calendar instance
  return o
end

function Anim:gridAnim(startIndex, endIndex, matchIndices, Timer)
  print("[Anim]: gridAnim called with startIndex: " .. tostring(startIndex) .. ", endIndex: " .. tostring(endIndex))
  local calendar = self.calendar
  if not calendar or not calendar.playersDataToPublish or not calendar.playersDataToPublish.data then
    print("[Anim]: Calendar or grid data not initialized")
    return
  end

  if not Timer then
    print("[Anim]: Timer not provided")
    return
  end

  if not startIndex or not endIndex or startIndex > endIndex or startIndex < 1 then
    print("[Anim]: Invalid startIndex (" .. tostring(startIndex) .. ") or endIndex (" .. tostring(endIndex) .. ")")
    return
  end

  if calendar.selectTimerObj then
    calendar.selectTimerObj:finalize()
    calendar.selectTimerObj = nil
    print("[Anim]: Existing select timer stopped")
  end

  local GRIDS_PER_SET = 35
  local function getMonthSetIndex(gridIndex)
    return math.floor((gridIndex - 1) / GRIDS_PER_SET) + 1
  end

  local function getGridIndexInSet(gridIndex)
    return ((gridIndex - 1) % GRIDS_PER_SET) + 1
  end

  local function getDaysInMonth(gridIndex)
    local item = calendar.playersDataToPublish.data[gridIndex]
    if not item or not item.month then
      print("[Anim]: No valid item or month at gridIndex " .. gridIndex)
      return 0
    end
    local monthMap = {
      January = 31, February = 28, March = 31, April = 30, May = 31,
      June = 30, July = 31, August = 31, September = 30, October = 31,
      November = 30, December = 31
    }
    local days = monthMap[item.month] or 31
    if item.month == "February" and item.year then
      local year = tonumber(item.year)
      if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
        days = 29
      end
    end
    return days
  end

  local function updateGlobalDate(day, month, year)
    local dateStr = string.format("%02d/%02d/%02d", day, month, year % 100)
    calendar.globalState.date = dateStr
    GLOBAL_DATE_PLACEHOLDER = dateStr -- Sync with global
    print("[Anim]: Updated global date to " .. dateStr)
  end

  local targetEndDateNum
  local endItem = calendar.playersDataToPublish.data[endIndex]
  if endItem and endItem.day and endItem.month and endItem.year then
    local monthMap = {
      January = 1, February = 2, March = 3, April = 4, May = 5,
      June = 6, July = 7, August = 8, September = 9, October = 10,
      November = 11, December = 12
    }
    targetEndDateNum = endItem.year * 10000 + monthMap[endItem.month] * 100 + endItem.day
  else
    print("[Anim]: Invalid endIndex " .. endIndex .. ", stopping animation")
    return
  end

  local indexes = {}
  for i = startIndex, endIndex do
    local item = calendar.playersDataToPublish.data[i]
    if item and item.day then
      table.insert(indexes, i)
    end
  end
  print("[Anim]: Initial indexes: " .. #indexes .. ", target end date: " .. targetEndDateNum .. ", endIndex: " .. endIndex)

  matchIndices = matchIndices or {}

  local function selectNext(index)
    if index > #indexes or not indexes[index] then
      calendar.selectTimerObj = nil
      print("[Anim]: Grid animation completed at index " .. index .. ", total indexes: " .. #indexes)
      return
    end

    local gridIndex = indexes[index]
    local currentItem = calendar.playersDataToPublish.data[gridIndex]
    if not currentItem or not currentItem.day or not currentItem.month or not currentItem.year then
      print("[Anim]: Invalid item at gridIndex " .. gridIndex .. ", stopping animation")
      calendar.selectTimerObj = nil
      return
    end

    local delay = (index == 1) and 2 or 1
    local monthSetIndex = getMonthSetIndex(gridIndex)
    local gridIndexInSet = getGridIndexInSet(gridIndex)
    local daysInMonth = getDaysInMonth(gridIndex)
    local currentMonthLabel = currentItem.month .. " " .. currentItem.year
    local monthMap = {
      January = 1, February = 2, March = 3, April = 4, May = 5,
      June = 6, July = 7, August = 8, September = 9, October = 10,
      November = 11, December = 12
    }
    local currentDateNum = currentItem.year * 10000 + monthMap[currentItem.month] * 100 + currentItem.day

    if currentDateNum >= targetEndDateNum then
      print("[Anim]: Reached target date " .. currentDateNum .. " >= " .. targetEndDateNum .. ", final index: " .. gridIndex)
      calendar.selectTimerObj = nil
      calendar:setSelectedPlayerIndex(gridIndex)
      calendar:publishPlayerInfo()
      calendar.im.Refresh(bnd_player_list)
      return
    end

    calendar.selectTimerObj = Timer:new({
      id = "selectTimer_" .. gridIndex,
      interval = delay,
      reps = 1,
      onTimerComplete = function(id, repsCount)
        print("[Anim]: Timer completed, index: " .. index .. ", gridIndex: " .. gridIndex .. " (Month: " .. currentMonthLabel .. ", DateNum: " .. currentDateNum .. ")")

        calendar.playersDataToPublish.data[gridIndex].simulated = true
        local monthNum = monthMap[currentItem.month]
        updateGlobalDate(currentItem.day, monthNum, currentItem.year)

        if currentItem.matchIndex and matchIndices[currentItem.matchIndex] then
          local matchIndex = currentItem.matchIndex
          print("[Anim]: Simulating match index " .. matchIndex)
          if calendar.brain and calendar.brain.simSys then
            calendar.brain:simSys(matchIndex, matchIndex)
            calendar.globalState.matchupCount = math.max(calendar.globalState.matchupCount, matchIndex)
            GLOBAL_MATCHUP_COUNT = calendar.globalState.matchupCount -- Sync with global
            calendar:refreshMatchData()
            for i, item in ipairs(calendar.playersDataToPublish.data) do
              if item.matchIndex == matchIndex then
                local match = calendar.globalState.rivalListData[matchIndex]
                calendar.playersDataToPublish.data[i].homeScore = match.homeScore
                calendar.playersDataToPublish.data[i].awayScore = match.awayScore
                calendar.playersDataToPublish.data[i].simulated = true
              end
            end
          else
            print("[Anim]: Brain or simSys not available, skipping match simulation")
          end
        end

        calendar:setSelectedPlayerIndex(gridIndex)
        calendar:publishPlayerInfo()
        calendar.im.Refresh(bnd_player_list)

        if gridIndexInSet == daysInMonth and currentDateNum < targetEndDateNum then
          local currentMonthNum = monthMap[currentItem.month]
          local currentYear = tonumber(currentItem.year)
          local nextMonthNum = (currentMonthNum % 12) + 1
          local nextYear = currentMonthNum == 7 and calendar.oldYear or (currentMonthNum == 12 and calendar.newYear or currentYear)
          print("[Anim]: Month transition from " .. currentMonthLabel .. " to Month " .. nextMonthNum .. "/" .. nextYear)

          updateGlobalDate(1, nextMonthNum, nextYear)
          calendar:getPlayers()

          local newIndexes = {}
          local newEndIndex = nil
          local foundStart = false
          for i, item in ipairs(calendar.playersDataToPublish.data) do
            if item and item.day and item.month and item.year then
              local itemMonthNum = monthMap[item.month]
              local itemDateNum = item.year * 10000 + itemMonthNum * 100 + item.day
              if itemDateNum >= currentDateNum and itemDateNum <= targetEndDateNum then
                if not foundStart and itemDateNum > currentDateNum then
                  foundStart = true
                  table.insert(newIndexes, i)
                elseif foundStart then
                  table.insert(newIndexes, i)
                end
                if itemDateNum == targetEndDateNum then
                  newEndIndex = i
                end
              end
            end
          end

          if not newEndIndex then
            print("[Anim]: Warning: Target date " .. targetEndDateNum .. " not found in new grid, stopping at " .. currentMonthLabel)
            calendar.selectTimerObj = nil
            calendar:setSelectedPlayerIndex(gridIndex)
            calendar:publishPlayerInfo()
            calendar.im.Refresh(bnd_player_list)
            return
          end

          indexes = newIndexes
          print("[Anim]: Rebuilt indexes, new length: " .. #newIndexes .. ", new endIndex: " .. newEndIndex)
          selectNext(1)
        else
          selectNext(index + 1)
        end
      end
    })
    print("[Anim]: Starting timer for gridIndex " .. gridIndex .. " with delay " .. delay .. "s")
    local success, err = pcall(function() calendar.selectTimerObj:start() end)
    if not success then
      print("[Anim]: Failed to start timer: " .. tostring(err))
      calendar.selectTimerObj = nil
      return
    end
  end

  print("[Anim]: Starting animation with selectNext(1)")
  selectNext(1)
end

return Anim