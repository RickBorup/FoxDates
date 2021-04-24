# FoxDates

**Date and Time Functions for Visual FoxPro**

Project Manager: [Rick Borup](https://github.com/RickBorup)

To use, instantiate *clsFoxDates* from [foxdates.prg](foxdates.prg) and call the desired method.

Examples:
```foxpro
oFoxDates = NEWOBJECT( "clsFoxDates", "foxdates.prg")
oFoxDates.GetLastOfMonth( {^2019-11-12})  && returns 11/30/2019
oFoxDates.GetLastOfMonth( {^2019-02-01})  && returns 02/28/2019 (not a leap year)
oFoxDates.GetLastOfMonth( {^2020-02-01})  && returns 02/29/2020 (is a leap year)
```
*If you make changes, run the FoxUnit test suite in [foxdates_tests.prg](Tests/foxdates_tests.prg) to ensure all tests still pass. Note: some functions in this class depend on other functions in this class, so changes to one function can affect others.*

## Table of Contents

### [Date Functions](#DateFunctions)
[GetFirstOfMonth](#GetFirstOfMonth)     
[GetLastOfMonth](#GetLastOfMonth)  
[GetDaysInMonth](#GetDaysInMonth)  
[GetLastEOM](#GetLastEOM)  
[GetBOQ](#GetBOQ)  
[GetLastBOQ](#GetLastBOQ)  
[GetEOQ](#GetEOQ)  
[GetLastEOQ](#GetLastEOQ)  
[GetLastEOY](#GetLastEOY)  
[GetLastMonday](#GetLastMonday)  
[GetNextMonday](#GetNextMonday)  
[GetDateFromString](#GetDateFromString)  
[IsLeapYear](#IsLeapYear)  
[GetDateDayOrdinal](#GetDateDayOrdinal)  
[GetFormattedDateString](#GetFormattedDateString)  
[GetNthBusinessDay](#GetFormattedDateString)  
[IsHoliday](#IsHoliday)  
[GetRFC2822](#GetRFC2822)  
[GetIntervalDays](#GetIntervalDays)  

### [Time Functions](#TimeFunctions)  
[GetTimeString](#GetTimeString)  
[GetDisplayTime](#GetDisplayTime)  
[GetSecondsFromTimeString](#GetSecondsFromTimeString)  
[GetTimeStringFromSeconds](#GetTimeStringFromSeconds)  
[GetEndTime](#GetEndTime)  
[GetDuration](#GetDuration)  
[IsValidTimeString](#IsValidTimeString)  
[Get24HourTimeString](#Get24HourTimeString)  

## Date Functions <a name="DateFunctions"></a>

### GetFirstOfMonth() <a name="GetFirstOfMonth"></a>
Pass a date, get back the date of the first day of that month. 
If a datetime is passed, the time portion of the return value is 00:00:00.
```foxpro
oFoxDates.GetFirstOfMonth( {^2019-11-19})          && returns 11/01/2019
oFoxDates.GetFirstOfMonth( {^2019-11-19 12:34:56}) && returns 11/01/2019 00:00:00
```

### GetLastOfMonth() <a name="GetLastOfMonth"></a>
Pass a date, get back the date of the last day of that month.
If a datetime is passed, the time portion of the return value is 23:59:59.
```foxpro
oFoxDates.GetLastOfMonth( {^2019-11-19})          && returns 11/30/2019
oFoxDates.GetLastOfMonth( {^2019-11-19 12:34:56}) && returns 11/30/2019 23:59:59
```

### GetDaysInMonth() <a name="GetDaysInMonth"></a>
Pass a date, get back the number of days in that month.
```foxpro
oFoxDates.GetDaysInMonth( {^2019-11-19})    && returns 30
```

### GetLastEOM() <a name="GetLastEOM"></a>
Pass a date, get back the ending date of the previous month.
If a datetime is passed, the time portion of the return value is 23:59:59.
```foxpro
oFoxDates.GetLastEOM( {^2019-11-19})          && returns 10/31/2019
oFoxDates.GetLastEOM( {^2019-11-19 12:34:56}) && returns 10/31/2019 23:59:59
```

### GetBOQ() <a name="GetBOQ"></a>
Pass a date, get back the beginning date of the current calendar quarter.
If a datetime is passed, the time portion of the return value is 00:00:00.
```foxpro
oFoxDates.GetBOQ( {^2019-11-19})          && returns 10/01/2019
oFoxDates.GetBOQ( {^2019-11-19 12:34:56}) && returns 10/01/2019 00:00:00
```

### GetLastBOQ() <a name="GetLastBOQ"></a>
Pass a date, get back the beginning date of the previous calendar quarter.
If a datetime is passed, the time portion of the return value is 00:00:00.
```foxpro
oFoxDates.GetLastBOQ( {^2019-11-19})          && returns 07/01/2019
oFoxDates.GetLastBOQ( {^2019-11-19 12:34:56}) && returns 07/01/2019 00:00:00
```

### GetEOQ() <a name="GetEOQ"></a>
Pass a date, get back the ending date of the current calendar quarter.
If a datetime is passed, the time portion of the return value is 23:59:59.
```foxpro
oFoxDates.GetEOQ( {^2019-11-19})          && returns 12/31/2019
oFoxDates.GetEOQ( {^2019-11-19 12:45:56}) && returns 12/31/2019 23:59:59
```

### GetLastEOQ() <a name="GetLastEOQ"></a>
Pass a date, get back the ending date of the previous calendar quarter.
If a datetime is passed, the time portion of the return value is 23:59:59.
```foxpro
oFoxDates.GetLastEOQ( {^2019-11-19})          && returns 09/30/2019
oFoxDates.GetLastEOQ( {^2019-11-19 12:34:56}) && returns 09/30/2019 23:59:59
```

### GetLastEOY() <a name="GetLastEOY"></a>
Pass a date, get back the ending date of the previous year.
If a datetime is passed, the time portion of the return value is 23:59:59.
```foxpro
oFoxDates.GetLastEOY( {^2019-11-19})          && returns 12/31/2018
oFoxDates.GetLastEOY( {^2019-11-19 12:34:56}) && returns 12/31/2018 23:59:59
```

### GetLastMonday() <a name="GetLastMonday"></a>
Pass a date, get back the date of the preceding Monday.
If a datetime is passed, the time is preserved - i.e., 'same time last Monday'.
```foxpro
oFoxDates.GetLastMonday( {^2019-11-19})          && returns 11/18/2019
oFoxDates.GetLastMonday( {^2019-11-19 12:34:56}) && returns 11/18/2019 12:34:56
```

### GetNextMonday() <a name="GetNextMonday"></a>
Pass a date, get back the date of the next Monday.
If a datetime is passed, the time is preserved - i.e., 'same time next Monday'.
```foxpro
oFoxDates.GetNextMonday( {^2019-11-19})          && returns 11/25/2019
oFoxDates.GetNextMonday( {^2019-11-19 12:34:56}) && returns 11/25/2019 12:34:56
```

### GetDateFromString() <a name="GetDateFromString"></a>
Pass a date as a string in mm/dd/yyyy or similar format, get it back as a VFP date.
```foxpro
oFoxDates.GetDateFromString( "11/19/2019")    && returns 11/19/2019 as a VFP date
oFoxDates.GetDateFromString( "11-19-2019")    && returns 11/19/2019 as a VFP date
oFoxDates.GetDateFromString( "11.19.2019")    && returns 11/19/2019 as a VFP date
```

### IsLeapYear() <a name="IsLeapYear"></a>
Pass a date, find out whether it's a leap year.
```foxpro
oFoxDates.IsLeapYear( {^2019-11-19})    && returns .F.
oFoxDates.IsLeapYear( {^2020-11-19})    && returns .T.
```

### GetDateDayOrdinal() <a name="GetDateDayOrdinal"></a>
Pass a date, get back the day of the month as an ordinal value like "first",  "tenth", "nineteenth", or "thirty-first".
```foxpro
oFoxDates.GetDateDayOrdinal( {^2019-11-19})    && returns "nineteenth"
```

### GetFormattedDateString() <a name="GetFormattedDateString"></a>
Pass a date, get back a string formatted for display. 
```foxpro
oFoxDates.GetFormattedDateString( {^2019-11-19}, 1)    && returns "November 19, 2019"
oFoxDates.GetFormattedDateString( {^2019-11-19}, 2)    && returns "Tuesday, November 19, 2019"
```

### GetNthBusinessDay() <a name="GetNthBusinessDay"></a>
Pass the month, the year, and the desired business day, get back the date.
```foxpro
oFoxDates.GetNthBusinessDay( 11, 2019, 10)    && returns 11/14/2019 (the 10th business day)
```

### IsHoliday() <a name="IsHoliday"></a>
Pass a date and an optional country code, find out if it's a holiday. Country code defaults to USA. The only other option at this time is Canada.
```foxpro
oFoxDates.IsHoliday( {^2019-11-19})    && returns .F.
oFoxDates.IsHoliday( {^2019-11-28})    && returns .T. (Thanksgiving Day in the USA)
oFoxDates.IsHoliday( {^2019-11-28}, "Canada")    && returns .F. (not Thanksgiving Day in Canada)
oFoxDates.IsHoliday( {^2019-10-14}, "Canada")    && returns .T. (is Thanksgiving Day in Canada)

```  

### GetRFC2822() <a name="GetRFC2822"></a>
Pass a date or a datetime, get back a string in RFC 2822 format.

***Note - does NOT adjust for time zones. All times are assumed to be UTC (+0000) unless an offset  is passed as the second parameter. The offset can be passed as a string like '-0600' or '+0600' or as a numeric value like -6 or 6 (same as +6). The numeric values support .5 and .75 for those time zones that use them. (Reference: https://www.timeanddate.com/time/current-number-time-zones.html)***
```foxpro
oFoxDates.GetRFC2822( {^2019-11-19})           && returns "Tue, 19 Nov 2019 12:00:00 +0000"
oFoxDates.GetRFC2822( {^2019-11-19 17:11:00})  && returns "Tue, 19 Nov 2019 17:11:00 +0000"
oFoxDates.GetRFC2822( DATETIME(), "-0600")     && returns "Tue, 19 Nov 2019 13:12:02 -0600"
oFoxDates.GetRFC2822( DATETIME(), -6)          && returns "Tue, 19 Nov 2019 13:12:02 -0600"
oFoxDates.GetRFC2822( DATETIME(), 10.5)        && returns "Tue, 19 Nov 2019 12:00:00 +1030"
```

### GetIntervalDays() <a name="GetIntervalDays"></a>  
Pass two dates, get back the number of days in the interval between them. Optional third parameter determines if the result is a semi-closed interval (default - includes the start date but not the end date), a closed interval (includes both dates), or an open interval (does not include either date).
```foxpro
oFoxDates.GetIntervalDays( DATE(), DATE() + 1)       && returns 1
oFoxDates.GetIntervalDays( DATE(), DATE() + 1, 0)    && returns 1
oFoxDates.GetIntervalDays( DATE(), DATE() + 1, 1)    && returns 2
oFoxDates.GetIntervalDays( DATE(), DATE() + 1, 2)    && returns 0
```

## Time Functions <a name="TimeFunctions"></a>

### GetTimeString() <a name="GetTimeString"></a>
Pass numeric values for hours and minutes, get back a string formatted as a time.
```foxpro
oFoxDates.GetTimeString( 5, 11)    && returns "05:11"
```

### GetDisplayTime() <a name="GetDisplayTime"></a>
Pass a time as a string like hh:mm, get back a string that includes AM or PM.
```foxpro
oFoxDates.GetDisplayTime( "05:11")    && returns "05:11 AM"
oFoxDates.GetDisplayTime( "17:11")    && returns "05:11 PM"
```

### GetSecondsFromTimeString() <a name="GetSecondsFromTimeString"></a>
Pass a time as a string like hh:mm, get back the number of seconds since midnight.
```foxpro
oFoxDates.GetSecondsFromTimeString( "05:11")    && returns 18660.00
```

### GetTimeStringFromSeconds() <a name="GetTimeStringFromSeconds"></a>
Pass the number of seconds since midnight, get back a time string like hh:mm.
```foxpro
oFoxDates.GetTimeStringFromSeconds( 18660.00)    && returns "05:11"
```

### GetEndTime() <a name="GetEndTime"></a>
Pass a starting time and a duration, get back the ending time.
```foxpro
oFoxDates.GetEndTime( "05:11", 30)    && returns "05:41"
```

### GetDuration() <a name="GetDuration"></a>
Pass a start time and an end time, get back the duration in minutes.
```foxpro
oFoxDates.GetDuration( "05:11", "05:41")    && returns 30.0000
```

### IsValidTimeString() <a name="IsValidTimeString"></a>
Pass a time string, find out if it conforms to a valid time in hh:mm format.
```foxpro
oFoxDates.ValidateTimeString( "5pm")      && returns .F.
oFoxDates.ValidateTimeString( "05:11")    && returns .T.
```

### Get24HourTimeString() <a name="Get24HourTimeString"></a>
Pass a time in a common format like 10am, 1p, or 3:30pm and get back a string in 24-hour clock format as hhmm (no colon). Useful for storing time strings that can later be compared using VAL().
```foxpro
oFoxDates.Get24HourTimeString( "10am")    && returns "1000"
oFoxDates.Get24HourTimeString( "1p")      && returns "1300"
oFoxDates.Get24HourTimeString( "3:30pm")  && returns "1530"
```
