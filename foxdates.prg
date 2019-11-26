*==============================================================================
* Program:           FOXDATES.PRG
* Author:            Rick Borup
* Date Written:      11/23/2019
* Compiler:          Visual FoxPro 09.00.0000.7423 for Windows
* Abstract:          A set of functions for working with dates and datetimes.
*==============================================================================

DEFINE CLASS clsFoxDates AS Custom

*--------------------------------------------------------------------
*   clsFoxDates :: Init
*------------------------------------
*   Function: Class constructor
*       Pass: Nothing
*     Return: Logical
*   Comments: 
*--------------------------------------------------------------------
FUNCTION Init() as Logical
ENDFUNC && Init

*--------------------------------------------------------------------
*   clsFoxDates :: Destroy
*------------------------------------
*   Function: Class destructor
*       Pass: Nothing
*     Return: Nothing
*   Comments: 
*--------------------------------------------------------------------
PROCEDURE Destroy() as VOID
ENDPROC && Destroy

*--------------------------------------------------------------------
*   clsFoxDates :: GetFirstOfMonth
*------------------------------------
*   Function: Calculate the first day of the month
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetFirstOfMonth( tdDate as Date) as Date 
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
RETURN tdDate - DAY( tdDate) + 1 
ENDFUNC && GetFirstOfMonth

*--------------------------------------------------------------------
*   clsFoxDates :: GetLastOfMonth
*------------------------------------
*   Function: Calculate the last day of the month
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetLastOfMonth( tdDate as Date) as Date 
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
RETURN GOMONTH( tdDate - DAY( tdDate) + 1, 1) - 1
*	Another alternative...
*	RETURN GOMONTH( tdDate, 1) - DAY( GOMONTH( tdDate, 1))
ENDFUNC && GetLastOfMonth

*--------------------------------------------------------------------
*   clsFoxDates :: GetDaysInMonth
*------------------------------------
*   Function: Get the number of days in the specified month and year
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Integer - the number of days in the month
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetDaysInMonth( tdDate as Date) as Integer
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL ldDate, lnDaysInMonth
ldDate = DATE( YEAR( tdDate), MONTH( tdDate), 1)	&& first of the month
lnDaysInMonth = GOMONTH( ldDate, 1) - ldDate			&& days in that month
RETURN lnDaysInMonth
ENDFUNC && GetDaysInMonth

*--------------------------------------------------------------------
*   clsFoxDates :: GetLastEOM
*------------------------------------
*   Function: Calculate the last day of the previous month
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetLastEOM( tdDate as Date) as Date
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
RETURN this.GetLastOfMonth( GOMONTH( tdDate, -1))
ENDFUNC && GetLastEOM

*--------------------------------------------------------------------
*   clsFoxDates :: GetBOQ
*------------------------------------
*   Function: Calculate the beginning of the quarter date
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: Calendar quarters are Jan-Mar, Apr-Jun, Jul-Sep, and Oct-Dec
*--------------------------------------------------------------------
FUNCTION GetBOQ( tdDate as Date) as Date
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnMonth
lnMonth = MONTH( tdDate)
lnMonth = ICASE( BETWEEN( lnMonth, 1, 3), 1, ;
					  BETWEEN( lnMonth, 4, 6), 4, ;
					  BETWEEN( lnMonth, 7, 9), 7, ;
					  10)
RETURN DATE( YEAR( tdDate), lnMonth, 1)
ENDFUNC && GetBOQ

*--------------------------------------------------------------------
*   clsFoxDates :: GetEOQ
*------------------------------------
*   Function: Calculate the end of quarter date
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetEOQ( tdDate as Date) as Date
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
IF ( MONTH( tdDate) = 3 and DAY( tdDate) = 31) or ;
	( MONTH( tdDate) = 6 and DAY( tdDate) = 30) or ;
	( MONTH( tdDate) = 9 and DAY( tdDate) = 30) or ;
	( MONTH( tdDate) = 12 and DAY( tdDate) = 31)
	RETURN tdDate
ENDIF 
LOCAL lnYear, lnMonth, lnDay
lnYear = YEAR( tdDate)
DO CASE
	CASE MONTH( tdDate) = 1 OR MONTH( tdDate) = 2 OR MONTH( tdDate) = 3
		  lnMonth = 3
		  lnDay = 31
	CASE MONTH( tdDate) = 4 OR MONTH( tdDate) = 5 OR MONTH( tdDate) = 6
		  lnMonth = 6
		  lnDay = 30
	CASE MONTH( tdDate) = 7 OR MONTH( tdDate) = 8 OR MONTH( tdDate) = 9
		  lnMonth = 9
		  lnDay = 30
	OTHERWISE
		  lnMonth = 12
		  lnDay = 31
ENDCASE
RETURN DATE( lnYear, lnMonth, lnDay)
ENDFUNC && GetEOQ

*--------------------------------------------------------------------
*   clsFoxDates :: GetLastEOQ
*------------------------------------
*   Function: Calculate the most recent end of quarter date
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetLastEOQ( tdDate as Date) as Date
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnYear, lnMonth, lnDay
lnYear = YEAR( tdDate)
DO CASE
	CASE MONTH( tdDate) = 1 OR MONTH( tdDate) = 2 OR MONTH( tdDate) = 3
		lnMonth = 12
		lnDay = 31
		lnYear = lnYear - 1
	CASE MONTH( tdDate) = 4 OR MONTH( tdDate) = 5 OR MONTH( tdDate) = 6
		lnMonth = 3
		lnDay = 31
	CASE MONTH( tdDate) = 7 OR MONTH( tdDate) = 8 OR MONTH( tdDate) = 9
		lnMonth = 6
		lnDay = 30
	OTHERWISE
		lnMonth = 9
		lnDay = 30
ENDCASE
RETURN DATE( lnYear, lnMonth, lnDay)
ENDFUNC && GetLastEOQ

*--------------------------------------------------------------------
*   clsFoxDates :: GetLastEOY
*------------------------------------
*   Function: Calculate the most recent end-of-year date
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetLastEOY( tdDate as Date) as Date
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnYear, lnMonth, lnDay
lnYear = YEAR( tdDate) - 1
lnMonth = 12
lnDay = 31
RETURN DATE( lnYear, lnMonth, lnDay)
ENDFUNC && GetLastEOY

*--------------------------------------------------------------------
*   clsFoxDates :: GetLastMonday
*------------------------------------
*   Function: Calculate last Monday's date
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetLastMonday( tdDate as Date) as Date 
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnDOW, ldMonday
lnDOW = DOW( tdDate)
ldMonday = tdDate
DO CASE
	CASE lnDOW = 1						&& Sunday
		ldMonday = tdDate - 6
	CASE lnDOW = 2						&& Monday
		ldMonday = tdDate - 7
	OTHERWISE 							&& Tuesday thru Saturday
		ldMonday = tdDate - (lnDOW - 2)
ENDCASE 
RETURN ldMonday
ENDFUNC && GetLastMonday

*--------------------------------------------------------------------
*   clsFoxDates :: GetNextMonday
*------------------------------------
*   Function: Calculates next Monday's date
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Date
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetNextMonday( tdDate as Date) as Date
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnDOW, ldMonday
lnDOW = DOW( tdDate)
ldMonday = tdDate
DO CASE
	CASE lnDOW = 1							&& Sunday
		ldMonday = tdDate + 1
	CASE lnDOW = 2							&& Monday
		ldMonday = tdDate + 7
	OTHERWISE 							&& Tuesday thru Saturday
		ldMonday = tdDate + (7 - lnDOW) + 2
ENDCASE
RETURN ldMonday
ENDFUNC && GetNextMonday

*--------------------------------------------------------------------
*   clsFoxDates :: GetDateFromString
*------------------------------------
*   Function: Convert a string in the format of MM/DD/YYYY to a date
*             data type. Allow for variations such as M/D/YY, MM/D/YY, 
*             M/DD/YY, MM-DD-YYY, MM.DD.YYYY, etc.
*       Pass: tcDate - a date in month/day/year string format
*     Return: Date
*   Comments: Returns the empty date if the calculation fails to 
*             produce a valid date (e.g., bad parameter string)
*--------------------------------------------------------------------
FUNCTION GetDateFromString( tcDate as String ) as Date 
IF VARTYPE( tcDate) = "C"
ELSE
	RETURN {}
ENDIF
LOCAL lcDate
lcDate = ALLTRIM( tcDate)				&& Trim leading or trailing spaces.
lcDate = STRTRAN( lcDate, " ", "")	&& Take out any embedded spaces.
lcDate = STRTRAN( lcDate, "-", "/") && Replace any hyphens with slashes.
lcDate = STRTRAN( lcDate, ".", "/") && Replace any periods with slashes.
LOCAL lnSlash1, lnSlash2, lnYear, lnMonth, lnDay

*	Extract the month.
lnSlash1 = AT( "/", lcDate)
IF lnSlash1 > 4
	RETURN {}	&& something's wrong with the date string.
ENDIF
lnMonth = VAL( LEFT( lcDate, lnSlash1 - 1))

*	Extract the day.
lnSlash2 = AT( "/", lcDate, 2)
IF lnSlash2 > 6
	RETURN {}	&& something's wrong with the date string.
ENDIF
lnDay = VAL( SUBSTR( lcDate, lnSlash1 + 1, lnSlash2 - lnSlash1 + 1))

*	Extract the year. If year is only two characters long then we can assume 
*	that the century was left off and needs to be added. The century is added 
*	based on value of SET CENTURY TO nCentury ROLLOVER nYear.
*	SET( "CENTURY", 1) = nCentury
*	SET( "CENTURY", 2) = nYear
LOCAL lcYear
lcYear = SUBSTR( lcDate, lnSlash2 + 1) && Returns characters until the end of the string.
IF LEN( lcYear) = 2
	IF VAL( lcYear) >= SET( "CENTURY", 2)	&& last century, i.e., 1900's
		lnYear = ( SET( "CENTURY", 1) * 100) + VAL( lcYear) 
	ELSE	&& next century, i.e., 2000's
		lnYear = ( ( SET( "CENTURY", 1) + 1) * 100) + VAL( lcYear) 
	ENDIF
ELSE
	lnYear = VAL( lcYear)	
ENDIF

*	Return the date in date format. Trap any errors, which could
*	occur if year is < 100, or day or month is an invalid number.
LOCAL ldReturnDate
TRY
	ldReturnDate = DATE( lnYear, lnMonth, lnDay)
CATCH
	ldReturnDate = {}
ENDTRY
RETURN ldReturnDate
ENDFUNC	&& GetDateFromString()

*--------------------------------------------------------------------
*   clsFoxDates :: IsLeapYear
*------------------------------------
*   Function: Determine if a year is a leap year
*       Pass: txParm - a string, numeric value, or date representing a year
*     Return: Logical
*   Comments: Returns True if the year is a leap year, otherwise
*             returns False.
*--------------------------------------------------------------------
FUNCTION IsLeapYear( txParm as Variant) as Logical
LOCAL lcYear, lcSetDate, lcCentury, llLeapYear
lcSetDate = SET( "date")
lcCentury = SET( "century")
SET DATE AMERICAN 	&& so CTOD will work as expected.
SET CENTURY ON 		&& ditto.
DO CASE
	CASE TYPE( "txParm") = "C"
		lcYear = ALLTRIM( txParm)
	CASE TYPE( "txParm") = "N"
		lcYear = ALLTRIM( STR( txParm))
	CASE TYPE( "txParm") = "D"
		IF !EMPTY( YEAR( txParm))   && If we got a valid date
			lcYear = ALLTRIM( STR( YEAR( txParm)))   && then capture its year.
		ELSE             && Otherwise if we got an invalid date then force
			lcYear = "X"  && '!empty( CTOD( "02/29/" + lcYear))' to be .F.
		ENDIF
ENDCASE
IF TYPE("lcYear") = "C"   && .T. if parameter was type C, N, or D
	llLeapYear = !EMPTY( DATE( VAL( lcYear), 02, 29))	&& to satisfy strictdate
ELSE    && if parameter was not type C, N, or D
	llLeapYear = .F.
ENDIF
SET DATE &lcSetDate
SET CENTURY &lcCentury
RETURN llLeapYear
ENDFUNC && IsLeapYear

*--------------------------------------------------------------------
*   clsFoxDates :: GetDateDayOrdinal
*------------------------------------
*   Function: Returns the day of a date as an ordinal string, as in
*             "first" or "tenth".
*       Pass: tdDate - a date (optional, defaults to the current date)
*     Return: Character
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetDateDayOrdinal( tdDate as Date) as String
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnDay, lcDay
lnDay = DAY( tdDate)
DO CASE
	CASE lnDay = 1
		lcDay = "first"
	CASE lnDay = 2
		lcDay = "second"
	CASE lnDay = 3
		lcDay = "third"
	CASE lnDay = 4
		lcDay = "fourth"
	CASE lnDay = 5
		lcDay = "fifth"
	CASE lnDay = 6
		lcDay = "sixth"
	CASE lnDay = 7
		lcDay = "seventh"
	CASE lnDay = 8
		lcDay = "eighth"
	CASE lnDay = 9
		lcDay = "ninth"
	CASE lnDay = 10
		lcDay = "tenth"
	CASE lnDay = 11
		lcDay = "eleventh"
	CASE lnDay = 12
		lcDay = "twelfth"
	CASE lnDay = 13
		lcDay = "thirteenth"
	CASE lnDay = 14
		lcDay = "fourteenth"
	CASE lnDay = 15
		lcDay = "fifteenth"
	CASE lnDay = 16
		lcDay = "sixteenth"
	CASE lnDay = 17
		lcDay = "seventeenth"
	CASE lnDay = 18
		lcDay = "eighteenth"
	CASE lnDay = 19
		lcDay = "nineteenth"
	CASE lnDay = 20
		lcDay = "twentieth"
	CASE lnDay = 21
		lcDay = "twenty-first"
	CASE lnDay = 22
		lcDay = "twenty-second"
	CASE lnDay = 23
		lcDay = "twenty-third"
	CASE lnDay = 24
		lcDay = "twenty-fourth"
	CASE lnDay = 25
		lcDay = "twenty-fifth"
	CASE lnDay = 26
		lcDay = "twenty-sixth"
	CASE lnDay = 27
		lcDay = "twenty-seventh"
	CASE lnDay = 28
		lcDay = "twenty-eighth"
	CASE lnDay =29
		lcDay = "twenty-ninth"
	CASE lnDay = 30
		lcDay = "thirtieth"
	CASE lnDay = 31
		lcDay = "thirty-first"
	OTHERWISE		&& Shouldn't ever happen, but just in case.
		lcDay = ALLTRIM( STR( lnDay))
ENDCASE
RETURN lcDay
ENDFUNC && GetDateDayOrdinal

*--------------------------------------------------------------------
*   clsFoxDates :: GetFormattedDateString
*------------------------------------
*   Function: Format a date as a string for display.
*       Pass: tdDate - a date (optional, defaults to the current date)
*             tnFormat - 1=format like May 15, 2012 (default)
*                        2=format like Tuesday, May 15, 2012
*     Return: String
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetFormattedDateString( tdDate as Date, tnFormat as Integer ) as String
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lnFormat, lcString
lnFormat = IIF( VARTYPE( tnFormat) = "N" AND BETWEEN( INT( tnFormat), 1, 2), INT( tnFormat), 1)
lcString = CMONTH( tdDate) + SPACE(1) + TRANSFORM( DAY( tdDate)) + ", " + TRANSFORM( YEAR( tdDate)) 
DO CASE 
	CASE lnFormat = 1
		RETURN lcString
	CASE lnFormat = 2
		RETURN CDOW( tdDate) + ", " + lcString
	OTHERWISE 
		RETURN ""
ENDCASE 
ENDFUNC && GetFormattedDateString

*--------------------------------------------------------------------
*   clsFoxDates :: GetNthBusinessDay
*------------------------------------
*   Function: Calculate the date of the nth business of the month
*       Pass: tnMonth       - the desired month
*             tnYear        - the desired year
*             tnBusinessDay - the desired business day of the month
*                             (for example, the 1st business day or
*                              the 3rd business day)
*     Return: Date
*   Comments: This function knows how to adjust for weekends and the 
*             six major holidays in the United States, but it does 
*             not attempt to adjust for the minor holidays.
*
*             This function uses the IsHoliday() method in this class.
*--------------------------------------------------------------------
FUNCTION GetNthBusinessDay( tnMonth as Integer, ;
                            tnYear as Integer, ;
									 tnBusinessDay as Integer) as Date
IF VARTYPE( tnMonth) <> "N" OR VARTYPE( tnYear) <> "N" OR VARTYPE( tnBusinessDay) <> "N"
	RETURN {}
ENDIF
IF NOT BETWEEN( tnMonth, 1, 12)
	RETURN {}
ENDIF
IF NOT BETWEEN( tnYear, 1752, 9999)
	RETURN {}
ENDIF

LOCAL ldDate, lnDaysInMonth
*	Get number of days in the month.
ldDate = DATE( tnYear, tnMonth, 1)		&& first of the month
lnDaysInMonth = this.GetDaysInMonth( ldDate)		&& days in that month

*	The ordinal target business day in a given month must be less than
*	or equal to the actual number of days in that month.
IF BETWEEN( tnBusinessDay, 1, lnDaysInMonth)
ELSE
	RETURN {}
ENDIF

LOCAL lnDay, lnBusinessDay
lnDay = 1
lnBusinessDay = 0
DO WHILE lnDay < lnDaysInMonth
	*	Count business days as Monday through Friday except holidays.
	ldDate = DATE( tnYear, tnMonth, lnDay)
	IF BETWEEN( DOW( ldDate), 2, 6) AND NOT this.IsHoliday( ldDate)
		*	If it's a weekday and not a holiday, then it's a business day.
		lnBusinessDay = lnBusinessDay + 1
	ENDIF
	IF lnBusinessDay = tnBusinessDay
		EXIT
	ENDIF
	lnDay = lnDay + 1
ENDDO
RETURN DATE( YEAR( ldDate), MONTH( ldDate), lnDay)
ENDFUNC && GetNthBusinessDay

*--------------------------------------------------------------------
*   clsFoxDates :: IsHoliday
*------------------------------------
*   Function: Determines is a given date is a holiday.
*       Pass: tdDate - a date (optional, defaults to the current date)
*             tcCountry - optional, defaults to USA
*     Return: Logical - .T. if holiday, otherwise .F.
*   Comments: Future enhancement - add other country codes.
*--------------------------------------------------------------------
FUNCTION IsHoliday( tdDate as Date, tcCountry as String) as Logical
IF VARTYPE( tdDate) = "D" AND NOT EMPTY( tdDate)
ELSE
	tdDate = DATE()
ENDIF
LOCAL lcCountry
IF VARTYPE( tcCountry) = "C"
	lcCountry = UPPER( ALLTRIM( tcCountry))
ELSE
	lcCountry = "USA"
ENDIF
DO CASE 
	CASE lcCountry = "USA"
		RETURN this.IsHolidayUSA( tdDate)
	CASE lcCountry = "CANADA"
		RETURN this.IsHolidayCanada( tdDate)
	OTHERWISE
		RETURN .F.
ENDCASE
ENDFUNC

*--------------------------------------------------------------------
*   clsFoxDates :: IsHolidayUSA
*------------------------------------
*   Function: Determines if the given date is a holiday in the United States
*       Pass: tdDate - the date
*     Return: Logical - True if it's a holiday, otherwise False
*   Comments: This function recognizes the following U.S. holidays:
*             New Year's Day, Memorial Day, Independence Day,
*             Labor Day, Veteran's Day, Thanksgiving Day, and Christmas Day
*--------------------------------------------------------------------
PROTECTED FUNCTION IsHolidayUSA( tdDate as Date) as Logical 
LOCAL lnMonth, lnDay, lnDOW, llHoliday
lnMonth = MONTH( tdDate)
lnDay = DAY( tdDate)
lnDOW = DOW( tdDate)
llHoliday = .F.
DO CASE
	
	*	New Year's Day, 
	CASE lnMonth = 1 AND lnDay = 1	
		llHoliday = .T.
	
	*	Memorial Day (last Monday in May)
	CASE lnMonth = 5 AND lnDOW = 2 AND lnDay > 24
		llHoliday = .T.

	* Independence Day (4th of July)
	CASE lnMonth = 7 AND lnDay = 4
		llHoliday = .T.
		
	*	Labor Day (first Monday in September)
	CASE lnMonth = 9 AND lnDOW = 2 AND lnDay < 8
		llHoliday = .T.
		
	*	Veternan's Day (Remembrance Day)
	CASE lnMonth = 11 AND lnDay = 11 
		llHoliday = .T.
	
	*	Thanksgiving Day (fourth Thursday in November)
	CASE lnMonth = 11 AND lnDOW = 5 AND BETWEEN( lnDay, 22, 28)
		llHoliday = .T.

	*	Christmas Day
	CASE lnMonth = 12 AND lnDay = 25 
		llHoliday = .T.
	
	OTHERWISE
		llHoliday = .F.
ENDCASE
RETURN llHoliday
ENDFUNC && IsHolidayUSA

*--------------------------------------------------------------------
*   clsFoxDates :: IsHolidayCanada
*------------------------------------
*   Function: Determines if the given date is a holiday in Canada
*       Pass: tdDate - the date
*     Return: Logical - True if it's a holiday, otherwise False
*   Comments: This function recognizes the following Canadian holidays:
*             New Year's Day, Victoria Day, Canada Day, Labour Day, 
*             Thanksgiving Day, Remembrance Day, Christmas Day, and Boxing Day.
*
*             Source: https://www.thecanadianencyclopedia.ca/en/article/national-holidays 
*--------------------------------------------------------------------
PROTECTED FUNCTION IsHolidayCanada( tdDate as Date) as Logical 
LOCAL lnMonth, lnDay, lnDOW, llHoliday
lnMonth = MONTH( tdDate)
lnDay = DAY( tdDate)
lnDOW = DOW( tdDate)
llHoliday = .F.
DO CASE
	
	*	New Year's Day (January 1st) 
	CASE lnMonth = 1 AND lnDay = 1	
		llHoliday = .T.
	
	*	Victoria Day (the Monday before May 25)
	CASE lnMonth = 5 AND lnDOW = 2 AND BETWEEN( lnDay, 18, 24)
		llHoliday = .T.

	* Canada Day (July 1st)
	CASE lnMonth = 7 AND lnDay = 1
		llHoliday = .T.
		
	*	Labour Day (first Monday in September)
	CASE lnMonth = 9 AND lnDOW = 2 AND lnDay < 8
		llHoliday = .T.
		
	*	Thanksgiving Day (second Monday in October)
	CASE lnMonth = 10 AND lnDOW = 2 AND BETWEEN( lnDay, 8, 14)
		llHoliday = .T.

	*	Remembrance Day
	CASE lnMonth = 11 AND lnDay = 11 
		llHoliday = .T.
	
	*	Christmas Day
	CASE lnMonth = 12 AND lnDay = 25 
		llHoliday = .T.
	
	*	Boxing Day
	CASE lnMonth = 12 AND lnDay = 26 
		llHoliday = .T.
	
	OTHERWISE
		llHoliday = .F.
ENDCASE
RETURN llHoliday
ENDFUNC && IsHolidayCanada

*--------------------------------------------------------------------
*   clsFoxDates :: GetTimeString
*------------------------------------
*   Function: Format a time as a string in the format hh:mm
*       Pass: tnHours - the hours value (00 - 23)
*             tnMinutes - the minutes value (00 - 59)
*     Return: String
*   Comments: 
*--------------------------------------------------------------------
FUNCTION GetTimeString( tnHours as Integer, tnMinutes as Integer) as String
IF VARTYPE( tnHours) = "N" AND BETWEEN( tnHours, 0, 23) AND ;
	VARTYPE( tnMinutes) = "N" AND BETWEEN( tnMinutes, 0, 59)
ELSE
	RETURN ""
ENDIF
LOCAL lcHours, lcMinutes
lcHours = PADL( ALLTRIM( STR( tnHours)), 2, "0")
lcMinutes = PADL( ALLTRIM( STR( tnMinutes)), 2, "0")
RETURN lcHours + ":" + lcMinutes
ENDFUNC && GetTimeString

*--------------------------------------------------------------------
*   clsFoxDates :: GetDisplayTime
*------------------------------------
*   Function: Format a time string for display
*       Pass: tcTimeString - the time string in the format of hh:mm
*             tlSuppressZero - True to suppress leading zero, or
*                              False to display leading zero (default)
*             tlSuppressAMPM - True to suppress AM or PM
*                      			 False to append AM or PM (default)
*     Return: String
*   Comments: Returns hh:mm AM or hh:mm PM. Subtracts 12 from hh 
*             for PM times. Returns the empty string if tcTimeString
*             is invalid or can't be parsed.
*--------------------------------------------------------------------
FUNCTION GetDisplayTime( tcTimeString as String, ;
								 tlSuppressZero as Logical, ;
								 tlSuppressAMPM as Logical) as String
IF this.IsValidTimeString( tcTimeString)
ELSE 
	RETURN ""
ENDIF
IF PCOUNT() < 2 OR VARTYPE( tlSuppressZero) <> "L"
	tlSuppressZero = .F.
ENDIF
IF PCOUNT() < 3 OR VARTYPE( tlSuppressAMPM) <> "L"
	tlSuppressAMPM = .F.
ENDIF
LOCAL lnHours, lcDisplayTime
lnHours = VAL( LEFT( tcTimeString, 2))
DO CASE 
	CASE lnHours < 12		&& morning
		lcDisplayTime = tcTimeString + IIF( tlSuppressAMPM, "", " AM")
	CASE lnHours = 12		&& 12 noon
		lcDisplayTime = tcTimeString + IIF( tlSuppressAMPM, "", " PM")
	OTHERWISE				&& afternoon
		lcDisplayTime = PADL( ALLTRIM( STR( lnHours - 12)), 2, "0") + ;
							 SUBSTR( tcTimeString, 3, 3) + IIF( tlSuppressAMPM, "", " PM")
ENDCASE
IF tlSuppressZero
	IF LEFT( lcDisplayTime, 1) = "0"
		lcDisplayTime = SUBSTR( lcDisplayTime, 2)
	ENDIF
ENDIF
RETURN lcDisplayTime
ENDFUNC && GetDisplayTime

*--------------------------------------------------------------------
*   clsFoxDates :: GetSecondsFromTimeString
*------------------------------------
*   Function: Convert a time string (hh:mm) into seconds since midnight.
*       Pass: tcTimeString - the time string
*     Return: Integer
*   Comments: Returns zero if parameter is invalid type or can't be parsed
*--------------------------------------------------------------------
FUNCTION GetSecondsFromTimeString( tcTimeString as String) as Integer
IF this.IsValidTimeString( tcTimeString) 
ELSE 
	RETURN 0
ENDIF
LOCAL lnColonPosition
lnColonPosition = AT( ":", tcTimeString)
IF lnColonPosition = 0		&& no colon
	RETURN 0
ENDIF 
LOCAL lnHours, lnMinutes
lnHours = VAL( LEFT( tcTimeString, lnColonPosition - 1))
lnMinutes = VAL( SUBSTR( tcTimeString, lnColonPosition + 1))
RETURN ( lnHours * 3600) + ( lnMinutes * 60)
ENDFUNC && GetSecondsFromTimeString

*--------------------------------------------------------------------
*   clsFoxDates :: GetTimeStringFromSeconds
*------------------------------------
*   Function: Construct a time string hh:mm from a number of seconds
*             past midnight.
*       Pass: tnSeconds - the number of seconds past midnight
*     Return: Character
*   Comments: If tnSeconds is greater than one day the result is
*             adjusted to be relative to the closest previous midnight.
*--------------------------------------------------------------------
FUNCTION GetTimeStringFromSeconds( tnSeconds as Integer) as String
IF VARTYPE( tnSeconds) = "N"
ELSE
	RETURN ""
ENDIF
LOCAL lnSeconds, lnHours, lnMinutes, lcEndTime
IF tnSeconds >= 86400		&& There are 86,400 seconds in 24 hours.
	lnSeconds = MOD( tnSeconds, 86400)
ELSE
	lnSeconds = tnSeconds
ENDIF
lnHours = ( lnSeconds - MOD( lnSeconds, 3600)) / 3600
lnSeconds = MOD( lnSeconds, 3600)	&& minutes remaining after subtracting hours
lnMinutes = ( lnSeconds - MOD( lnSeconds, 60)) / 60
*	Ignore any remaining seconds.
lcEndTime = this.GetTimeString( lnHours, lnMinutes)
RETURN lcEndTime
ENDFUNC && GetTimeStringFromSeconds

*--------------------------------------------------------------------
*   clsFoxDates :: GetEndTime
*------------------------------------
*   Function: Calculate an ending time from a starting time and a duration.
*       Pass: tcStartTime - the starting time, as hh:mm
*             tnDuration  - the duration, in minutes
*     Return: Character
*   Comments: Returns the empty string if tcStartTime is invalid.
*--------------------------------------------------------------------
FUNCTION GetEndTime( tcStartTime as String, tnDuration as Integer) as String
IF this.IsValidTimeString( tcStartTime)
ELSE
	RETURN ""
ENDIF
LOCAL lcStartTime, lnDuration
lcStartTime = LEFT( ALLTRIM( tcStartTime), 5)
lnDuration = IIF( VARTYPE( tnDuration) = "N", tnDuration, 0)
IF ( ISDIGIT( LEFT( lcStartTime, 1)) AND ;
	  ISDIGIT( SUBSTR( lcStartTime, 2, 1)) AND ;
	  SUBSTR( lcStartTime, 3, 1) = ":" AND ;
	  ISDIGIT( SUBSTR( lcStartTime, 4, 1)) AND ;
	  ISDIGIT( SUBSTR( lcStartTime, 5, 1)))
ELSE
	RETURN ""
ENDIF
LOCAL lnStartSeconds, lnEndSeconds, lcEndTime
lnStartSeconds = this.GetSecondsFromTimeString( tcStartTime)
lnEndSeconds = lnStartSeconds + ( lnDuration * 60)
lcEndTime = this.GetTimeStringFromSeconds( lnEndSeconds)
RETURN lcEndTime
ENDFUNC && GetEndTime

*--------------------------------------------------------------------
*   clsFoxDates :: GetDuration
*------------------------------------
*   Function: Get the duration of a time interval, in minutes
*       Pass: tcStartTime - starting time as hh:mm
*             tcEndTime   - ending time as hh:mm
*     Return: Numeric
*   Comments: Assumes both times are on the same date. If end time
*             is earlier than start time, duration is returned as
*             a negative number. Returns 0 if a parameter is invalid.
*--------------------------------------------------------------------
FUNCTION GetDuration( tcStartTime as String, tcEndTime as String) as Integer
IF this.IsValidTimeString( tcStartTime) AND ;
	this.IsValidTimeString( tcEndTime)
ELSE
	RETURN 0
ENDIF
LOCAL lnStartTime, lnEndTime, lnDuration
lnStartTime = this.GetSecondsFromTimeString( tcStartTime)
lnEndTime = this.GetSecondsFromTimeString( tcEndTime)
RETURN ( lnEndTime - lnStartTime) / 60
ENDFUNC && GetDuration

*--------------------------------------------------------------------
*   clsFoxDates :: GetRFC2822
*------------------------------------
*   Function: Get the RFC 2822 time string from a date or datetime.
*       Pass: txDateTime - the date or datetime
*             tcOffset   - the time zone offset as a string (e.g., "-0500")
*     Return: Character
*   Comments: RFC 2822 dates are formatted as "Thu, 21 Jul 2005 16:43:00 +0000"
*             This format is also used by RSS.
*
*             If a date is passed, the time defaults to 12:00:00.
*
*             NOTE - This method does NOT adjust for time zones. If the
*             second paramter is omitted or is not a string value, UTC time
*             (+0000) is used by default.
*
*             Returns the empty string if txDateTime is not a date or a datetime.
*--------------------------------------------------------------------
FUNCTION GetRFC2822( txDateTime as Variant, tcOffset as String) as String
IF ( VARTYPE( txDateTime) = "D" OR VARTYPE( txDateTime) = "T") AND NOT EMPTY( txDateTime)
ELSE
	RETURN ""
ENDIF
LOCAL lcReturnString, lcDay, lcDate, lcMonth, lcYear, lcHour, lcMinute, lcSecond, lcOffset
lcReturnString = ""
lcOffset = IIF( VARTYPE( tcOffset) = "C", tcOffset, "+0000")
DO CASE 
	CASE VARTYPE( txDateTime) = "D"
		lcDay = LEFT( CDOW( txDatetime), 3)
		lcDate = PADL( ALLTRIM( STR( DAY( txDateTime))), 2, "0")
		lcMonth = LEFT( CMONTH( txDateTime), 3)
		lcYear = PADL( ALLTRIM( STR( YEAR( txDateTime))), 4, "0")
		lcHour = "12"
		lcMinute = "00"
		lcSecond = "00"

	CASE VARTYPE( txDateTime) = "T"
		lcDay = LEFT( CDOW( txDatetime), 3)
		lcDate = PADL( ALLTRIM( STR( DAY( txDateTime))), 2, "0")
		lcMonth = LEFT( CMONTH( txDateTime), 3)
		lcYear = PADL( ALLTRIM( STR( YEAR( txDateTime))), 4, "0")
		lcHour = PADL( ALLTRIM( STR( HOUR( txDateTime))), 2, "0")
		lcMinute = PADL( ALLTRIM( STR( MINUTE( txDateTime))), 2, "0")
		lcSecond = PADL( ALLTRIM( STR( SEC( txDateTime))), 2, "0")

	OTHERWISE
		*	Nothing to do
		
ENDCASE
lcReturnString = lcDay + ", " + lcDate + " " + lcMonth + " " + lcYear + " " +  ;
		  lcHour + ":" + lcMinute + ":" + lcSecond + SPACE(1) + lcOffset
RETURN lcReturnString
ENDFUNC && GetRFC2822

*--------------------------------------------------------------------
*   clsFoxDates :: IsValidTimeString
*------------------------------------
*   Function: Check if a time string conforms to the hh:mm format.
*       Pass: tcTime  - the time string
*     Return: Logical - True if valid, otherwise False
*   Comments: 
*--------------------------------------------------------------------
FUNCTION IsValidTimeString( tcTime as String) as Logical
RETURN VARTYPE( tcTime) = "C" AND ;
		 LEN( tcTime) = 5 AND ;
		 ISDIGIT( LEFT( tcTime, 1)) AND ;
		 ISDIGIT( SUBSTR( tcTime, 2, 1)) AND ;
		 SUBSTR( tcTime, 3, 1) = ":" AND ;
		 ISDIGIT( SUBSTR( tcTime, 4, 1)) AND ;
		 ISDIGIT( RIGHT( tcTime, 1)) AND ;
		 BETWEEN( VAL( LEFT( tcTime, 2)), 00, 23) AND ;
		 BETWEEN( VAL( RIGHT( tcTime, 2)), 00, 59)
ENDFUNC && IsValidTimeString

*--------------------------------------------------------------------
*   clsFoxDates :: Get24HourTimeString
*------------------------------------
*   Function: Convert a string into a 24-hr time value
*       Pass: tcTime - a string representing a time
*     Return: Character
*   Comments: Returns the empty string if the input parameter is not 
*             recognized as one of the acceptable formats.
*
*             Acceptable formats are:
*             - a value from 1 to 12 (e.g., "1", "12")
*             - a value from 1 to 12 optionally followed by a colon
*               followed by a value from 0 to 59 (e.g., "1:00", "3:30")
*             - either of the above, optionally followed by "a", "am", 
*               "p", or "pm" (e.g. "10am", "1p", "3:30pm")
*--------------------------------------------------------------------
FUNCTION Get24HourTimeString( tcTime as String) as String
IF VARTYPE( tcTime) = "C" AND NOT EMPTY( tcTime)
ELSE
	RETURN ""
ENDIF 
LOCAL lcTime
lcTime = ALLTRIM( tcTime)
lcTime = STRTRAN( lcTime, SPACE(1), "")
LOCAL lcAMPM, lnHour, lnMinute
lcAMPM = ICASE( AT( "A", UPPER( lcTime)) > 0, "AM", ;
						AT( "P", UPPER( lcTime)) > 0, "PM", ;
						"")
LOCAL lni, lcCharacter, lcCleanTime
lcCleanTime = ""
FOR lni = 1 TO LEN( lcTime)
	lcCharacter = SUBSTR( lcTime, lni, 1)
	IF ISDIGIT( lcCharacter) OR lcCharacter = ":"
		lcCleanTime = lcCleanTime + lcCharacter
	ENDIF 
ENDFOR
lcTime = lcCleanTime
IF EMPTY( lcCleanTime) OR ALLTRIM( lcCleanTime) = ":"	&& no numerals in the input parameter
	RETURN ""
ENDIF 
LOCAL lnColonPosition, lcHour, lnHour, lcMinute, lnMinute
lnColonPosition = AT( ":", lcTime)
IF lnColonPosition > 0
	lcHour = LEFT( lcTime, lnColonPosition - 1)
	lcMinute = SUBSTR( lcTime, lnColonPosition + 1)
ELSE
	lcHour = lcTime
	lcMinute = ""
ENDIF
IF BETWEEN( INT( VAL( lcHour)), 0, 12) AND ;
	BETWEEN( INT( VAL( lcMinute)), 0, 59)
ELSE
	RETURN ""
ENDIF
IF EMPTY( lcAMPM)
	lcAMPM = IIF( lcHour = "12", "PM", "AM")
ENDIF
IF lcAMPM = "PM" AND VAL( lcHour) < 12
	lcHour = ALLTRIM( STR( VAL( lcHour) + 12))
ENDIF
IF lcAMPM = "AM" AND VAL( lcHour) = 12
	lcHour = "0"
ENDIF
lcHour = PADL( lcHour, 2, "0")
lcMinute = PADL( lcMinute, 2, "0")
RETURN lcHour + lcMinute
ENDFUNC && Get24HourTimeString

*--------------------------------------------------------------------
*   clsFoxDates :: GetIntervalDays
*------------------------------------
*   Function: Get the number of days between two dates
*       Pass: tdStartDate    - the starting date
*             tdEndDate      - the ending date
*             tnIntervalType - 0 = semi-open interval (default)
*                                  includes the start date but not the end date
*                              1 = closed interval 
*                                  includes both dates
*                              2 = open interval
*                                  does not include either date
*     Return: Integer
*   Comments: Returns 0 if date parameters are missing or invalid.
*--------------------------------------------------------------------
FUNCTION GetIntervalDays( tdStartDate as Date, ;
								  tdEndDate as Date, ;
								  tnIntervalType as Integer) as Integer 
IF VARTYPE( tdStartDate) = "D" AND NOT EMPTY( tdStartDate)
ELSE
	RETURN 0
ENDIF
IF VARTYPE( tdEndDate) = "D" AND NOT EMPTY( tdEndDate)
ELSE
	RETURN 0
ENDIF
IF tdStartDate = tdEndDate		&& special case, interval is zero regardless of interval type
	RETURN 0
ENDIF
IF VARTYPE( tnIntervalType) = "N" AND BETWEEN( tnIntervalType, 0, 2)
ELSE
	tnIntervalType = 0	&& default is semi-open interval
ENDIF
LOCAL lnInterval
lnInterval = ABS( tdEndDate - tdStartDate)
DO CASE 
	CASE tnIntervalType = 1		&& closed interval, counts both dates
		lnInterval = lnInterval + 1
	CASE tnintervalType = 2		&& open interval, does not count either date
		lnInterval = lnInterval - 1
	OTHERWISE
		*	no change
ENDCASE
RETURN INT( lnInterval)
ENDFUNC && GetIntervalDays

ENDDEFINE	&& clsFoxDates
