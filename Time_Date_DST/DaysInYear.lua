-- This Lua script is part of the Time_Date_DST Rainmeter skin
function Update()

  yearArg = os.date('%Y')

  if yearArg%4==0 and (yearArg%100~=0 or yearArg%400==0) then
		return 366
	else
		return 365
	end

end