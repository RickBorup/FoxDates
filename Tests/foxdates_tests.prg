**********************************************************************
DEFINE CLASS foxdates_tests as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS clsFoxDates OF FoxDates.prg
	#ENDIF
	
	*  
	*  declare properties here that are used by one or
	*  more individual test methods of this class
	*
	*  for example, if you create an object to a custom
	*  THIS.Property in THIS.Setup(), estabish the property
	*  here, where it will be available (to IntelliSense)
	*  throughout:
	*
	ioObjectToBeTested = .NULL.
	icSetClassLib = SPACE(0)


	* the icTestPrefix property in the base FxuTestCase class defaults
	* to "TEST" (not case sensitive). There is a setting on the interface
	* tab of the options form (accessible via right-clicking on the
	* main FoxUnit form and choosing the options item) labeld as
	* "Load and run only tests with the specified icTestPrefix value in test classes"
	*
	* If this is checked, then only tests in any test class that start with the
	* prefix specified with the icTestPrefix property value will be loaded
	* into FoxUnit and run. You can override this prefix on a per-class basis.
	*
	* This makes it possible to create ancillary methods in your test classes
	* that can be shared amongst other test methods without being run as
	* tests themselves. Additionally, this means you can quickly and easily 
	* disable a test by modifying it and changing it's test prefix from
	* that specified by the icTestPrefix property
	
	* Additionally, you could set this in the INIT() method of your derived class
	* but make sure you dodefault() first. When the option to run only
	* tests with the icTestPrefix specified is checked in the options form,
	* the test classes are actually all instantiated individually to pull
	* the icTestPrefix value.

*!*		icTestPrefix = "<Your preferred prefix here>"
	
	********************************************************************
	FUNCTION Setup
	********************************************************************
	*
	*  put common setup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can instantiate all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
*!*		THIS.icSetClassLib = SET("CLASSLIB")
*!*		SET CLASSLIB TO MyApplicationClassLib.VCX ADDITIVE
*!*		THIS.ioObjectToBeTested = CREATEOBJECT("MyNewClassImWriting")

		this.ioObjectToBeTested = NEWOBJECT( "clsFoxDates", "FoxDates.prg")

	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION TearDown
	********************************************************************
	*
	*  put common cleanup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can release  all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
*!*	   THIS.ioObjectToBeTested = .NULL.
*!*		LOCAL lcSetClassLib
*!*		lcSetClassLib = THIS.icSetClassLib
*!*		SET CLASSLIB TO &lcSetClassLib        

	********************************************************************
	ENDFUNC
	********************************************************************	

	*
	*  test methods can use any method name not already used by
	*  the parent FXUTestCase class
	*    MODIFY COMMAND FXUTestCase
	*  DO NOT override any test methods except for the abstract 
	*  test methods Setup() and TearDown(), as described above
	*
	*  the three important inherited methods that you call
	*  from your test methods are:
	*    THIS.AssertTrue(<Expression>, "Failure message")
	*    THIS.AssertEquals(<ExpectedValue>, <Expression>, "Failure message")
	*    THIS.AssertNotNull(<Expression>, "Failure message")
	*  all test methods either pass or fail -- the assertions
	*  either succeed or fail
    
	*
	*  here's a simple AssertNotNull example test method
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectWasCreated
*!*		*********************************************************************
*!*		THIS.AssertNotNull(THIS.ioObjectToBeTested, ;
*!*			"Object was not instantiated during Setup()")
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  here's one for AssertTrue
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod 
*!*		*********************************************************************
*!*		THIS.AssertTrue(THIS.ioObjectToBeTested.CustomMethod()), ;
			"Object.CustomMethod() failed")
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  and one for AssertEquals
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod100ReturnValue 
*!*		*********************************************************************
*!*
*!*		* Please note that string Comparisons with AssertEquals are
*!*		* case sensitive. 
*!*
*!*		THIS.AssertEquals("John Smith", ;
*!*			            THIS.ioObjectToBeTested.Object.CustomMethod100(), ;
*!*			            "Object.CustomMethod100() did not return 'John Smith'",
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************



	FUNCTION TestObjectWasCreated
	THIS.AssertNotNull(THIS.ioObjectToBeTested, ;
		"Object was not instantiated during Setup()")
	ENDFUNC

*!*		FUNCTION testReturnsCharacter
*!*		* 1. Change the name of the test to reflect its purpose. Test one thing only.
*!*		* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
*!*		RETURN This.AssertNotImplemented()
*!*		ENDFUNC


*---------------------------------------------------------------------
*	Tests for GetFirstOFMonth()
*---------------------------------------------------------------------
FUNCTION TestGetFirstOfMonth_NoInput_ReturnsBOMofCurrentDate
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetFirstOfMonth(), ;
						 "GetFirstOfMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetFirstOfMonth_BadInput_ReturnsBOMofCurrentDate
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetFirstOfMonth( .F.), ;
						 "GetFirstOfMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetFirstOfMonth_EmptyDate_ReturnsBOMofCurrentDate
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetFirstOfMonth( {}), ;
						 "GetFirstOfMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetFirstOfMonth_TodaysDate_ReturnsBOMofCurrentDate
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetFirstOfMonth( DATE()), ;
						 "GetFirstOfMonth() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetLastOFMonth()
*---------------------------------------------------------------------
FUNCTION TestGetLastOFMonth_NoInput_ReturnsEOMofCurrentDate
LOCAL ldToday, lnLastDay
ldToday = DATE()
lnLastDay = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( MONTH( ldToday), 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
LOCAL ldExpected
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth(), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_BadInput_ReturnsEOMofCurrentDate
LOCAL ldToday, lnLastDay
ldToday = DATE()
lnLastDay = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( MONTH( ldToday), 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
LOCAL ldExpected
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( .F.), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_EmptyDate_ReturnsEOMofCurrentDate
LOCAL ldToday, lnLastDay
ldToday = DATE()
lnLastDay = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( MONTH( ldToday), 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
LOCAL ldExpected
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( {}), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_TodaysDate_ReturnsEOMofCurrentDate
LOCAL ldToday, lnLastDay
ldToday = DATE()
lnLastDay = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( MONTH( ldToday), 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
LOCAL ldExpected
ldExpected = DATE( YEAR( ldToday), MONTH( ldToday), lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( ldToday), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_JanuaryDate_ReturnsTheThirtyFirst
LOCAL ldExpected
ldExpected = {^2019-01-31}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( {^2019-01-01}), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_AprilDate_ReturnsTheThirtieth
LOCAL ldExpected
ldExpected = {^2019-04-30}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( {^2019-04-01}), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_FebruaryNotLeapYear_ReturnsTheTwentyEighth
LOCAL ldExpected
ldExpected = {^2019-02-28}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( {^2019-02-01}), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastOFMonth_FebruaryLeapYear_ReturnsTheTwentyNinth
LOCAL ldExpected
ldExpected = {^2020-02-29}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastOFMonth( {^2020-02-01}), ;
						 "GetLastOFMonth() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetDaysInMonth()
*---------------------------------------------------------------------
FUNCTION TestGetDaysInMonth_NoInput_ReturnsDaysInCurrentMonth
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						  MONTH( ldToday) = 2, IIF( this.IsLeapYear( YEAR( ldToday)), 29, 28), ;
						  30)
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth(), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

FUNCTION TestGetDaysInMonth_BadInput_ReturnsDaysInCurrentMonth
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						  MONTH( ldToday) = 2, IIF( this.IsLeapYear( YEAR( ldToday)), 29, 28), ;
						  30)
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( .F.), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

FUNCTION TestGetDaysInMonth_EmptyDate_ReturnsDaysInCurrentMonth
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = ICASE( INLIST( MONTH( ldToday), 1, 3, 5, 7, 8, 10, 12), 31, ;
						  MONTH( ldToday) = 2, IIF( this.IsLeapYear( YEAR( ldToday)), 29, 28), ;
						  30)
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	January
FUNCTION TestGetDaysInMonth_January_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-01-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	February (not a leap year)
FUNCTION TestGetDaysInMonth_FebruaryNotLeapYear_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 28
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-02-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	February (leap year)
FUNCTION TestGetDaysInMonth_FebruaryLeapYear_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 29
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2020-02-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	March
FUNCTION TestGetDaysInMonth_March_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-03-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	April
FUNCTION TestGetDaysInMonth_April_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 30
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-04-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	May
FUNCTION TestGetDaysInMonth_May_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-05-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	June
FUNCTION TestGetDaysInMonth_June_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 30
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-06-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	July
FUNCTION TestGetDaysInMonth_July_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-07-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	August
FUNCTION TestGetDaysInMonth_August_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-08-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	September
FUNCTION TestGetDaysInMonth_September_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 30
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-09-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	October
FUNCTION TestGetDaysInMonth_October_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-10-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	November
FUNCTION TestGetDaysInMonth_November_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 30
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-11-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*	December
FUNCTION TestGetDaysInMonth_December_ReturnsDaysInCurrentMonth
LOCAL lnExpected
lnExpected = 31
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDaysInMonth( {^2019-12-01}), ;
						 "GetLastOFMonth() did not return the expected values")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetLastEOM()
*---------------------------------------------------------------------
FUNCTION TestGetLastEOM_NoInput_ReturnsEOMofLastMonth
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = IIF( MONTH( ldToday) = 1, 12, MONTH( ldToday) - 1)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOM(), ;
						 "GetLastEOM() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOM_BadInput_ReturnsEOMofLastMonth
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = IIF( MONTH( ldToday) = 1, 12, MONTH( ldToday) - 1)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOM( .F.), ;
						 "GetLastEOM() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOM_EmptyDate_ReturnsEOMofLastMonth
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = IIF( MONTH( ldToday) = 1, 12, MONTH( ldToday) - 1)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOM( {}), ;
						 "GetLastEOM() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOM_TodaysDate_ReturnsEOMofLastMonth
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = IIF( MONTH( ldToday) = 1, 12, MONTH( ldToday) - 1)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOM( ldToday), ;
						 "GetLastEOM() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetBOQ()
*---------------------------------------------------------------------
FUNCTION TestGetBOQ_NoInput_ReturnsBOQofCurrentDate
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = ICASE( INLIST( MONTH( ldToday), 1, 2, 3), 1, ;
					  INLIST( MONTH( ldToday), 4, 5, 6), 4, ;
					  INLIST( MONTH( ldToday), 7, 8, 9), 7, ;
					  10)
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
This.AssertEquals( ldDate, this.ioObjectToBeTested.GetBOQ(), ;
						 "GetBOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetBOQ_BadInput_ReturnsBOQofCurrentDate
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = ICASE( INLIST( MONTH( ldToday), 1, 2, 3), 1, ;
					  INLIST( MONTH( ldToday), 4, 5, 6), 4, ;
					  INLIST( MONTH( ldToday), 7, 8, 9), 7, ;
					  10)
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
This.AssertEquals( ldDate, this.ioObjectToBeTested.GetBOQ( .F.), ;
						 "GetBOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetBOQ_EmptyDate_ReturnsBOQofCurrentDate
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = ICASE( INLIST( MONTH( ldToday), 1, 2, 3), 1, ;
					  INLIST( MONTH( ldToday), 4, 5, 6), 4, ;
					  INLIST( MONTH( ldToday), 7, 8, 9), 7, ;
					  10)
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
This.AssertEquals( ldDate, this.ioObjectToBeTested.GetBOQ( {}), ;
						 "GetBOQ() did not return the expected date")
ENDFUNC

*	January
FUNCTION TestGetBOQ_Jan1_ReturnsJan1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 1
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 1, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Jan1) did not return January 1")
ENDFUNC

*	February
FUNCTION TestGetBOQ_Feb1_ReturnsJan1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 2
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 1, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Feb1) did not return January 1")
ENDFUNC

*	March
FUNCTION TestGetBOQ_Mar1_ReturnsJan1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 3
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 1, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Mar1) did not return January 1")
ENDFUNC

*	April
FUNCTION TestGetBOQ_Apr1_ReturnsApr1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 4
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 4, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Apr1) did not return April 1")
ENDFUNC

*	May
FUNCTION TestGetBOQ_May1_ReturnsApr1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 5
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 4, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(May1) did not return April 1")
ENDFUNC

*	June
FUNCTION TestGetBOQ_Jun1_ReturnsApr1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 6
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 4, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Jun1) did not return April 1")
ENDFUNC

*	July
FUNCTION TestGetBOQ_Jul1_ReturnsJul1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 7
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 7, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Jul1) did not return July 1")
ENDFUNC

*	August
FUNCTION TestGetBOQ_Aug1_ReturnsJul1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 8
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 7, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Aug1) did not return July 1")
ENDFUNC

*	September
FUNCTION TestGetBOQ_Sep1_ReturnsJul1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 9
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 7, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Sep1) did not return July 1")
ENDFUNC

*	October
FUNCTION TestGetBOQ_Oct1_ReturnsOct1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 10
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 10, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Oct1) did not return October 1")
ENDFUNC

*	November
FUNCTION TestGetBOQ_Nov1_ReturnsOct1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 11
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 10, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Nov1) did not return October 1")
ENDFUNC

*	December
FUNCTION TestGetBOQ_Dec1_ReturnsOct1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 12
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 10, 1)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetBOQ( ldDate), ;
						 "GetBOQ(Dec1) did not return October 1")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetEOQ()
*---------------------------------------------------------------------
FUNCTION TestGetEOQ_NoInput_ReturnsEOQofCurrentDate
LOCAL ldToday, lnYear, lnMonth, lnDay, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = ICASE( INLIST( MONTH( ldToday), 1, 2, 3), 3, ;
					  INLIST( MONTH( ldToday), 4, 5, 6), 6, ;
					  INLIST( MONTH( ldToday), 7, 8, 9), 9, ;
					  12)
lnDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
					INLIST( lnMonth, 4, 6, 9, 11), 30, ;
					28)	&& change to 29 if testing in a leap year
ldExpected = DATE( lnYear, lnMonth, lnDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ(), ;
						 "GetEOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetEOQ_BadInput_ReturnsEOQofCurrentDate
LOCAL ldToday, lnYear, lnMonth, lnDay, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = ICASE( INLIST( MONTH( ldToday), 1, 2, 3), 3, ;
					  INLIST( MONTH( ldToday), 4, 5, 6), 6, ;
					  INLIST( MONTH( ldToday), 7, 8, 9), 9, ;
					  12)
lnDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
					INLIST( lnMonth, 4, 6, 9, 11), 30, ;
					28)	&& change to 29 if testing in a leap year
ldExpected = DATE( lnYear, lnMonth, lnDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( .F.), ;
						 "GetEOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetEOQ_EmptyDate_ReturnsEOQofCurrentDate
LOCAL ldToday, lnYear, lnMonth, lnDay, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = ICASE( INLIST( MONTH( ldToday), 1, 2, 3), 3, ;
					  INLIST( MONTH( ldToday), 4, 5, 6), 6, ;
					  INLIST( MONTH( ldToday), 7, 8, 9), 9, ;
					  12)
lnDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
					INLIST( lnMonth, 4, 6, 9, 11), 30, ;
					28)	&& change to 29 if testing in a leap year
ldExpected = DATE( lnYear, lnMonth, lnDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( {}), ;
						 "GetEOQ() did not return the expected date")
ENDFUNC

*	January
FUNCTION TestGetEOQ_Jan1_ReturnsMarch31
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 1
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 3, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Jan1) did not return March 31")
ENDFUNC

*	February
FUNCTION TestGetEOQ_Feb1_ReturnsMarch31
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 2
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 3, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Feb1) did not return March 31")
ENDFUNC

*	March
FUNCTION TestGetEOQ_Mar1_ReturnsMarch31
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 3
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 3, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Mar1) did not return March 31")
ENDFUNC

*	April
FUNCTION TestGetEOQ_Apr1_ReturnsJune30
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 4
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 6, 30)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Apr1) did not return April 30")
ENDFUNC

*	May
FUNCTION TestGetEOQ_May1_ReturnsJune1
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 5
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 6, 30)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(May1) did not return June 30")
ENDFUNC

*	June
FUNCTION TestGetEOQ_Jun1_ReturnsJune30
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 6
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 6, 30)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Jun1) did not return June 30")
ENDFUNC

*	July
FUNCTION TestGetEOQ_Jul1_ReturnsSept30
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 7
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 9, 30)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Jul1) did not return September 30")
ENDFUNC

*	August
FUNCTION TestGetEOQ_Aug1_ReturnsSept30
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 8
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 9, 30)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Aug1) did not return September 30")
ENDFUNC

*	September
FUNCTION TestGetEOQ_Sep1_ReturnsSept30
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 9
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 9, 30)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Sep1) did not return September 30")
ENDFUNC

*	October
FUNCTION TestGetEOQ_Oct1_ReturnsDec31
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 10
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Oct1) did not return December 31")
ENDFUNC

*	November
FUNCTION TestGetEOQ_Nov1_ReturnsDec31
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 11
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Nov1) did not return December 31")
ENDFUNC

*	December
FUNCTION TestGetEOQ_Dec1_ReturnsDec31
LOCAL ldToday, lnYear, lnMonth, lnDay, ldDate, ldExpected
ldToday = DATE()
lnYear = YEAR( ldToday)
lnMonth = 12
lnDay = 1
ldDate = DATE( lnYear, lnMonth, lnDay)
ldExpected = DATE( lnYear, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetEOQ( ldDate), ;
						 "GetEOQ(Dec1) did not return December 31")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetLastEOQ()
*---------------------------------------------------------------------
FUNCTION TestGetLastEOQ_NoInput_ReturnsEOQofLastQuarter
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = ICASE( BETWEEN( MONTH( ldToday), 1, 3), 12, ;
					  BETWEEN( MONTH( ldToday), 4, 6), 3, ;
					  BETWEEN( MONTH( ldToday), 7, 9), 6, ;
					  9)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOQ(), ;
						 "GetLastEOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOQ_BadInput_ReturnsEOQofLastQuarter
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = ICASE( BETWEEN( MONTH( ldToday), 1, 3), 12, ;
					  BETWEEN( MONTH( ldToday), 4, 6), 3, ;
					  BETWEEN( MONTH( ldToday), 7, 9), 6, ;
					  9)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOQ( .F.), ;
						 "GetLastEOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOQ_EmptyDate_ReturnsEOQofLastQuarter
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = ICASE( BETWEEN( MONTH( ldToday), 1, 3), 12, ;
					  BETWEEN( MONTH( ldToday), 4, 6), 3, ;
					  BETWEEN( MONTH( ldToday), 7, 9), 6, ;
					  9)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOQ( {}), ;
						 "GetLastEOQ() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOQ_TodaysDate_ReturnsEOQofLastQuarter
LOCAL ldToday, ldExpected, lnYear, lnMonth, lnLastDay
ldToday = DATE()
lnYear = IIF( MONTH( ldToday) = 1, YEAR( ldToday) - 1, YEAR( ldToday))
lnMonth = ICASE( BETWEEN( MONTH( ldToday), 1, 3), 12, ;
					  BETWEEN( MONTH( ldToday), 4, 6), 3, ;
					  BETWEEN( MONTH( ldToday), 7, 9), 6, ;
					  9)
lnLastDay = ICASE( INLIST( lnMonth, 1, 3, 5, 7, 8, 10, 12), 31, ;
						 INLIST( lnMonth, 4, 6, 9, 11), 30, ;
						 28)  && change to 29 if testing during a leap year
ldExpected = DATE( lnYear, lnMonth, lnLastDay)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOQ( ldToday), ;
						 "GetLastEOQ() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetLastEOY()
*---------------------------------------------------------------------
FUNCTION TestGetLastEOY_NoInput_ReturnsEOYofLastYear
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday) - 1, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOY(), ;
						 "GetLastEOY() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOY_BadInput_ReturnsEOYofLastYear
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday) - 1, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOY( .F.), ;
						 "GetLastEOY() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOY_EmptyDate_ReturnsEOYofLastYear
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday) - 1, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOY( {}), ;
						 "GetLastEOY() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastEOY_TodaysDate_ReturnsEOYofLastYear
LOCAL ldToday, ldExpected
ldToday = DATE()
ldExpected = DATE( YEAR( ldToday) - 1, 12, 31)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastEOY( ldToday), ;
						 "GetLastEOY() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetLastMonday()
*---------------------------------------------------------------------
FUNCTION TestGetLastMonday_NoInput_ReturnsLastMonday
LOCAL ldToday, lnDOW, ldExpected
ldToday = DATE()
lnDOW = DOW( ldToday)
ldExpected = ICASE( lnDOW = 1, ldToday - 6, ; 
				 		  lnDOW = 2, ldToday - 7, ;
				 		  ldToday - ( lnDOW - 2))
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday(), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastMonday_BadInput_ReturnsLastMonday
LOCAL ldToday, lnDOW, ldExpected
ldToday = DATE()
lnDOW = DOW( ldToday)
ldExpected = ICASE( lnDOW = 1, ldToday - 6, ; 
				 		  lnDOW = 2, ldToday - 7, ;
				 		  ldToday - ( lnDOW - 2))
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( .F.), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

FUNCTION TestGetLastMonday_EmptyDate_ReturnsLastMonday
LOCAL ldToday, lnDOW, ldExpected
ldToday = DATE()
lnDOW = DOW( ldToday)
ldExpected = ICASE( lnDOW = 1, ldToday - 6, ; 
				 		  lnDOW = 2, ldToday - 7, ;
				 		  ldToday - ( lnDOW - 2))
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Sunday
FUNCTION TestGetLastMonday_Sunday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-11}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-17}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Monday
FUNCTION TestGetLastMonday_Monday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-11}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-18}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Tuesday
FUNCTION TestGetLastMonday_Tuesday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-18}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-19}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Wednesday
FUNCTION TestGetLastMonday_Wednesday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-18}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-20}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Thursday
FUNCTION TestGetLastMonday_Thursday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-18}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-21}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Friday
FUNCTION TestGetLastMonday_Friday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-18}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-22}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*	Saturday
FUNCTION TestGetLastMonday_Saturday_ReturnsLastMonday
LOCAL ldExpected
ldExpected = {^2019-11-18}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetLastMonday( {^2019-11-23}), ;
						 "GetLastMonday() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetNextMonday()
*---------------------------------------------------------------------
FUNCTION TestGetNextMonday_NoInput_ReturnsNextMonday
LOCAL ldToday, lnDOW, ldExpected
ldToday = DATE()
lnDOW = DOW( ldToday)
ldExpected = ICASE( lnDOW = 1, ldToday + 1, ; 
				 		  lnDOW = 2, ldToday + 7, ;
				 		  ldToday + ( 7 - lnDOW) + 2)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday(), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

FUNCTION TestGetNextMonday_BadInput_ReturnsNextMonday
LOCAL ldToday, lnDOW, ldExpected
ldToday = DATE()
lnDOW = DOW( ldToday)
ldExpected = ICASE( lnDOW = 1, ldToday + 1, ; 
				 		  lnDOW = 2, ldToday + 7, ;
				 		  ldToday + ( 7 - lnDOW) + 2)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( .F.), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

FUNCTION TestGetNextMonday_EmptyDate_ReturnsNextMonday
LOCAL ldToday, lnDOW, ldExpected
ldToday = DATE()
lnDOW = DOW( ldToday)
ldExpected = ICASE( lnDOW = 1, ldToday + 1, ; 
				 		  lnDOW = 2, ldToday + 7, ;
				 		  ldToday + ( 7 - lnDOW) + 2)
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Sunday
FUNCTION TestGetNextMonday_Sunday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-18}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-17}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Monday
FUNCTION TestGetNextMonday_Monday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-25}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-18}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Tuesday
FUNCTION TestGetNextMonday_Tuesday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-25}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-19}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Wednesday
FUNCTION TestGetNextMonday_Wednesday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-25}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-20}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Thursday
FUNCTION TestGetNextMonday_Thursday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-25}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-21}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Friday
FUNCTION TestGetNextMonday_Friday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-25}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-22}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*	Saturday
FUNCTION TestGetNextMonday_Saturday_ReturnsNextMonday
LOCAL ldExpected
ldExpected = {^2019-11-25}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNextMonday( {^2019-11-23}), ;
						 "GetNextMonday() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetDateFromString()
*---------------------------------------------------------------------
FUNCTION TestGetDateFromString_NoInput_ReturnsEmptyDate
LOCAL ldExpected
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetDateFromString(), ;
						 "GetDateFromString() did not return the expected date")
ENDFUNC

FUNCTION TestGetDateFromString_BadInput_ReturnsEmptyString
LOCAL ldExpected
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetDateFromString( .F.), ;
						 "GetDateFromString() did not return the expected date")
ENDFUNC

FUNCTION TestGetDateFromString_InvalidDateString_ReturnsEmptyString
LOCAL ldExpected
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetDateFromString( "11/32/2019"), ;
						 "GetDateFromString() did not return the expected date")
ENDFUNC

FUNCTION TestGetDateFromString_DateWithSlashes_ReturnsDate
LOCAL ldExpected
ldExpected = {^2019-11-22}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetDateFromString( "11/22/2019"), ;
						 "GetDateFromString() did not return the expected date")
ENDFUNC

FUNCTION TestGetDateFromString_DateWithHyphens_ReturnsDate
LOCAL ldExpected
ldExpected = {^2019-11-22}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetDateFromString( "11-22-2019"), ;
						 "GetDateFromString() did not return the expected date")
ENDFUNC

FUNCTION TestGetDateFromString_DateWithPeriods_ReturnsDate
LOCAL ldExpected
ldExpected = {^2019-11-22}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetDateFromString( "11.22.2019"), ;
						 "GetDateFromString() did not return the expected date")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for IsLeapYear()
*---------------------------------------------------------------------
FUNCTION TestIsLeapYear_1900_ReturnsFalse	&& centuries are not leap years
This.AssertFalse( this.ioObjectToBeTested.IsLeapYear(1900), ;
					   "IsLeapYear did not return False for the year 1900")
ENDFUNC

FUNCTION TestIsLeapYear_2000_ReturnsTrue	&& millenia are leap years
This.AssertTrue( this.ioObjectToBeTested.IsLeapYear(2000), ;
					  "IsLeapYear did not return True for the year 2000")
ENDFUNC

FUNCTION TestIsLeapYear_2017_ReturnsFalse	
This.AssertFalse( this.ioObjectToBeTested.IsLeapYear(2017), ;
					   "IsLeapYear did not return False for the year 2017")
ENDFUNC

FUNCTION TestIsLeapYear_2018_ReturnsFalse	
This.AssertFalse( this.ioObjectToBeTested.IsLeapYear(2018), ;
					   "IsLeapYear did not return False for the year 2018")
ENDFUNC

FUNCTION TestIsLeapYear_2019_ReturnsFalse	
This.AssertFalse( this.ioObjectToBeTested.IsLeapYear(2019), ;
					   "IsLeapYear did not return False for the year 2019")
ENDFUNC

FUNCTION TestIsLeapYear_2020_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsLeapYear(2020), ;
					  "IsLeapYear did not return True for the year 2020")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetDateDayOrdinal()
*---------------------------------------------------------------------
FUNCTION TestGetDateDayOrdinal_Day1_ReturnsFirst
This.AssertEquals( "first", this.ioObjectToBeTested.GetDateDayOrdinal( {^2019-11-1}), ;
						 "GetDateDayOrdinal() did not return the expected value")
ENDFUNC

FUNCTION TestGetDateDayOrdinal_Day10_ReturnsTenth
This.AssertEquals( "tenth", this.ioObjectToBeTested.GetDateDayOrdinal( {^2019-11-10}), ;
						 "GetDateDayOrdinal() did not return the expected value")
ENDFUNC

FUNCTION TestGetDateDayOrdinal_Day19_ReturnsNineteenth
This.AssertEquals( "nineteenth", this.ioObjectToBeTested.GetDateDayOrdinal( {^2019-11-19}), ;
						 "GetDateDayOrdinal() did not return the expected value")
ENDFUNC

FUNCTION TestGetDateDayOrdinal_Day22_ReturnsTwentySecond
This.AssertEquals( "twenty-second", this.ioObjectToBeTested.GetDateDayOrdinal( {^2019-11-22}), ;
						 "GetDateDayOrdinal() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetFormattedDateString()
*---------------------------------------------------------------------
FUNCTION TestGetFormattedDateString_TypeOmitted_ReturnsExpected
This.AssertEquals( "November 19, 2019", this.ioObjectToBeTested.GetFormattedDateString( {^2019-11-19}), ;
						 "GetFormattedDateString() did not return the expected value")
ENDFUNC

FUNCTION TestGetFormattedDateString_Type1_ReturnsExpected
This.AssertEquals( "November 19, 2019", this.ioObjectToBeTested.GetFormattedDateString( {^2019-11-19}, 1), ;
						 "GetFormattedDateString() did not return the expected value")
ENDFUNC

FUNCTION TestGetFormattedDateString_Type2_ReturnsExpected
This.AssertEquals( "Tuesday, November 19, 2019", this.ioObjectToBeTested.GetFormattedDateString( {^2019-11-19}, 2), ;
						 "GetFormattedDateString() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetNthBusinessDay()
*---------------------------------------------------------------------
FUNCTION TestGetNthBusinessDay_ParametersOmitted_ReturnsEmptyDate
LOCAL ldExpected
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay(), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_BadMonth_ReturnsEmptyDate
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 13
lnYear = 2019
lnBusinessDay = 16
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_BadYear_ReturnsEmptyDate
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 11
lnYear = 0
lnBusinessDay = 16
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_BadBusinessDay_ReturnsEmptyDate
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 11
lnYear = 2019
lnBusinessDay = 0
ldExpected = {}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_Test1_ReturnsExpected
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 11
lnYear = 2019
lnBusinessDay = 16
ldExpected = {^2019-11-25}		&& November 11 is the Veteran's Day holiday
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_Test2_ReturnsExpected
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 1
lnYear = 2020
lnBusinessDay = 1
ldExpected = {^2020-01-02}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_Test3_ReturnsExpected
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 9
lnYear = 2019
lnBusinessDay = 1
ldExpected = {^2019-09-03}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

FUNCTION TestGetNthBusinessDay_Test4_ReturnsExpected
LOCAL lnMonth, lnYear, lnBusinessDay, ldExpected
lnMonth = 10
lnYear = 2019
lnBusinessDay = 23
ldExpected = {^2019-10-31}
This.AssertEquals( ldExpected, this.ioObjectToBeTested.GetNthBusinessDay( lnMonth, lnYear, lnBusinessDay), ;
						 "GetNthBusinessDay() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for IsHoliday() - no country specified (should default to USA)
*---------------------------------------------------------------------
FUNCTION TestIsHoliday_NoInput_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday(), ;
					   "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_BadInput_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday(.F.), ;
					   "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_NotAHoliday_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday( {^2019-11-19}), ;
						"IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsNewYearsDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-01-01}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsMemorialDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-05-27}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsIndependenceDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-07-04}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsLaborDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-09-02}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsVeteransDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-11-11}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsThanksgivingDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-11-28}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsChristmasDay_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-12-25}), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for IsHoliday() - USA
*---------------------------------------------------------------------
FUNCTION TestIsHoliday_NoInputUSA_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday(), ;
					   "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_BadInputUSA_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday(.F.), ;
					   "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_NotAHolidayUSA_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday( {^2019-11-19}, "USA"), ;
						"IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsNewYearsDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-01-01}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsMemorialDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-05-27}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsIndependenceDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-07-04}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsLaborDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-09-02}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsVeteransDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-11-11}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsThanksgivingDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-11-28}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsChristmasDayUSA_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-12-25}, "USA"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for IsHoliday() - Canada
*---------------------------------------------------------------------
FUNCTION TestIsHoliday_NoInputCanada_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday(), ;
					   "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_BadInputCanada_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday(.F.), ;
					   "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_NotAHolidayCanada_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsHoliday( {^2019-11-19}, "Canada"), ;
						"IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsNewYearsDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-01-01}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsVictoriaDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-05-20}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsCanadaDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-07-01}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsLaborDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-09-02}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsThanksgivingDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-10-14}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsVeteransDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-11-11}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsChristmasDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-12-25}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

FUNCTION TestIsHoliday_IsBoxingDayCanada_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsHoliday({^2019-12-26}, "Canada"), ;
					  "IsHoliday() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetTimeString()
*---------------------------------------------------------------------
FUNCTION TestGetTimeString_NoInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeString(), ;
						 "GetTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeString_BadInputType_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeString(.F.), ;
						 "GetTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeString_BadInputValue1_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeString( 99, 15), ;
						 "GetTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeString_BadInputValue2_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeString( 13, 99), ;
						 "GetTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeString_Test1_ReturnsExpected
LOCAL lcExpected
lcExpected = "05:11"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeString( 5, 11), ;
						 "GetTimeString() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetDisplayTime()
*---------------------------------------------------------------------
FUNCTION TestGetDisplayTime_NoInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetDisplayTime(), ;
						 "GetDisplayTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetDisplayTime_BadInputType_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetDisplayTime(.F.), ;
						 "GetDisplayTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetDisplayTime_OneParameterAM_ReturnsExpected
LOCAL lcExpected
lcExpected = "05:11 AM"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetDisplayTime( "05:11"), ;
						 "GetDisplayTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetDisplayTime_OneParameterPM_ReturnsExpected
LOCAL lcExpected
lcExpected = "05:11 PM"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetDisplayTime( "17:11"), ;
						 "GetDisplayTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetDisplayTime_SuppressZero_ReturnsExpected
LOCAL lcExpected
lcExpected = "5:11 AM"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetDisplayTime( "05:11", .T.), ;
						 "GetDisplayTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetDisplayTime_SuppressZeroAndAMPM_ReturnsExpected
LOCAL lcExpected
lcExpected = "5:11"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetDisplayTime( "05:11", .T., .T.), ;
						 "GetDisplayTime() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetSecondsFromTimeString()
*---------------------------------------------------------------------
FUNCTION TestGetSecondsFromTimeString_NoInput_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetSecondsFromTimeString(), ;
						 "GetSecondsFromTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetSecondsFromTimeString_BadInput_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetSecondsFromTimeString( .F.), ;
						 "GetSecondsFromTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetSecondsFromTimeString_NoColon_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetSecondsFromTimeString( "0511"), ;
						 "GetSecondsFromTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestGetSecondsFromTimeString_GoodParameter_ReturnsExpected
LOCAL lnExpected
lnExpected = 18660
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetSecondsFromTimeString( "05:11"), ;
						 "GetSecondsFromTimeString() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetTimeStringFromSeconds()
*---------------------------------------------------------------------
FUNCTION TestGetTimeStringFromSeconds_NoInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeStringFromSeconds(), ;
						 "GetTimeStringFromSeconds() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeStringFromSeconds_BadInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeStringFromSeconds( .F.), ;
						 "GetTimeStringFromSeconds() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeStringFromSeconds_SameDay_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "05:11"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeStringFromSeconds( 18660), ;
						 "GetTimeStringFromSeconds() did not return the expected value")
ENDFUNC

FUNCTION TestGetTimeStringFromSeconds_NextDay_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "05:11"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetTimeStringFromSeconds( 86400 + 18660), ;
						 "GetTimeStringFromSeconds() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetEndTime()
*---------------------------------------------------------------------
FUNCTION TestGetEndTime_NoInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetEndTime(), ;
						 "GetEndTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetEndTime_BadInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetEndTime( .F.), ;
						 "GetEndTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetEndTime_NoDuration_ReturnsStartTime
LOCAL lcExpected
lcExpected = "05:11"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetEndTime( "05:11"), ;
						 "GetEndTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetEndTime_Test1_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "05:41"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetEndTime( "05:11", 30), ;
						 "GetEndTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetEndTime_Test2_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "05:41"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetEndTime( "05:11", 30), ;
						 "GetEndTime() did not return the expected value")
ENDFUNC

FUNCTION TestGetEndTime_Test3_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "17:11"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetEndTime( "05:11", 720), ;
						 "GetEndTime() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetDuration()
*---------------------------------------------------------------------
FUNCTION TestGetDuration_NoInput_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDuration(), ;
						 "GetDuration() did not return the expected value")
ENDFUNC

FUNCTION TestGetDuration_BadInput_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDuration( .F.), ;
						 "GetDuration() did not return the expected value")
ENDFUNC

FUNCTION TestGetDuration_Test1_ReturnsExpectedValue
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDuration( "05:11", "05:11"), ;
						 "GetDuration() did not return the expected value")
ENDFUNC

FUNCTION TestGetDuration_Test2_ReturnsExpectedValue
LOCAL lnExpected
lnExpected = 30
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDuration( "05:11", "05:41"), ;
						 "GetDuration() did not return the expected value")
ENDFUNC

FUNCTION TestGetDuration_Test3_ReturnsExpectedValue
LOCAL lnExpected
lnExpected = 720
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetDuration( "05:11", "17:11"), ;
						 "GetDuration() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetRFC2822()
*---------------------------------------------------------------------
FUNCTION TestGetRFC2822_NoInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822(), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_BadInput_ReturnsEmptyString
LOCAL lcExpected
lcExpected = ""
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( .F.), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateNoOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +0000"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithNegativeOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 -0600"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, "-0600"), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithNegativeTwelveOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 -1200"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, "-1200"), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithPositiveOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +0600"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, "+0600"), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithPositiveTwelveOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +1200"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, "+1200"), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithZeroNumericOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +0000"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, 0), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithNegativeNumericOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 -0600"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, -6), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithNegativeTwelveNumericOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 -1200"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, -12), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithPositiveNumericOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +0600"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, +6), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithPositiveTwelveNumericOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +1200"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, +12), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithPositiveNumericNoSignOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +0600"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, 6), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWith15MinuteOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +1000"  && not supported, no time zones use 15 minute offset
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, 10.25), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWith30MinuteOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +1030"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, 10.5), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWith45MinuteOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 12:00:00 +0845"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19}, 8.75), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateTimeNoOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 17:11:00 +0000"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19 17:11:00}), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

FUNCTION TestGetRFC2822_DateWithOffset_ReturnsExpectedValue
LOCAL lcExpected
lcExpected = "Tue, 19 Nov 2019 17:11:00 -0600"
This.AssertEquals( lcExpected, this.ioObjectToBeTested.GetRFC2822( {^2019-11-19 17:11:00}, "-0600"), ;
						 "GetRFC2822() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for IsValidTimeString()
*---------------------------------------------------------------------
FUNCTION TestIsValidTimeString_NoInput_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsValidTimeString(), ;
					   "IsValidTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestIsValidTimeString_BadInput_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsValidTimeString(.F.), ;
					   "IsValidTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestIsValidTimeString_InvalidTimeString_ReturnsFalse
This.AssertFalse( this.ioObjectToBeTested.IsValidTimeString( "0511"), ;
						"IsValidTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestIsValidTimeString_ValidTimeStringAM_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsValidTimeString( "05:11"), ;
					  "IsValidTimeString() did not return the expected value")
ENDFUNC

FUNCTION TestIsValidTimeString_ValidTimeStringPM_ReturnsTrue
This.AssertTrue( this.ioObjectToBeTested.IsValidTimeString( "17:11"), ;
					  "IsValidTimeString() did not return the expected value")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for Get24HourTimeString()
*---------------------------------------------------------------------

FUNCTION TestGet24HourTimeString_NoInput_ReturnsEmptyString
This.AssertEquals( "", this.ioObjectToBeTested.Get24HourTimeString(), ;
						 "Get24HourTimeString() did not return the empty string")
ENDFUNC

FUNCTION TestGet24HourTimeString_InputLogical_ReturnsEmptyString
This.AssertEquals( "", this.ioObjectToBeTested.Get24HourTimeString(.F.), ;
						 "Get24HourTimeString(.F.) did not return the empty string")
ENDFUNC

FUNCTION TestGet24HourTimeString_InputNumeric_ReturnsEmptyString
This.AssertEquals( "", this.ioObjectToBeTested.Get24HourTimeString(1), ;
						 "Get24HourTimeString(1) did not return the empty string")
ENDFUNC

FUNCTION TestGet24HourTimeString_BadHour_ReturnsEmptyString
This.AssertEquals( "", this.ioObjectToBeTested.Get24HourTimeString("13"), ;
						 "Get24HourTimeString('13') did not return the empty string")
ENDFUNC
  
FUNCTION TestGet24HourTimeString_BadMinute_ReturnsEmptyString
This.AssertEquals( "", this.ioObjectToBeTested.Get24HourTimeString("1:99"), ;
						 "Get24HourTimeString('1:99') did not return the empty string")
ENDFUNC
  
FUNCTION TestGet24HourTimeString_BadAMPM1_Returns0100
This.AssertEquals( "0100", this.ioObjectToBeTested.Get24HourTimeString("1z"), ;
						 "Get24HourTimeString('1z') did not return '0100'")
ENDFUNC
  
FUNCTION TestGet24HourTimeString_BadAMPM12_Returns1200
This.AssertEquals( "1200", this.ioObjectToBeTested.Get24HourTimeString("12z"), ;
						 "Get24HourTimeString('1z') did not return '1200'")
ENDFUNC
  
*	Tests without AM or PM

FUNCTION TestGet24HourTimeString_Input0_Returns0000
This.AssertEquals( "0000", this.ioObjectToBeTested.Get24HourTimeString("0"), ;
						 "Get24HourTimeString('1') did not return '0000'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input1_Returns0100
This.AssertEquals( "0100", this.ioObjectToBeTested.Get24HourTimeString("1"), ;
						 "Get24HourTimeString('1') did not return '0100'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input2_Returns0200
This.AssertEquals( "0200", this.ioObjectToBeTested.Get24HourTimeString("2"), ;
						 "Get24HourTimeString('2') did not return '0200'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input3_Returns0300
This.AssertEquals( "0300", this.ioObjectToBeTested.Get24HourTimeString("3"), ;
						 "Get24HourTimeString('3') did not return '0300'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input4_Returns0400
This.AssertEquals( "0400", this.ioObjectToBeTested.Get24HourTimeString("4"), ;
						 "Get24HourTimeString('4') did not return '0400'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input5_Returns0500
This.AssertEquals( "0500", this.ioObjectToBeTested.Get24HourTimeString("5"), ;
						 "Get24HourTimeString('5') did not return '0500'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input6_Returns0600
This.AssertEquals( "0600", this.ioObjectToBeTested.Get24HourTimeString("6"), ;
						 "Get24HourTimeString('6') did not return '0600'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input7_Returns0700
This.AssertEquals( "0700", this.ioObjectToBeTested.Get24HourTimeString("7"), ;
						 "Get24HourTimeString('7') did not return '0700'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input8_Returns0800
This.AssertEquals( "0800", this.ioObjectToBeTested.Get24HourTimeString("8"), ;
						 "Get24HourTimeString('8') did not return '0800'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input9_Returns0900
This.AssertEquals( "0900", this.ioObjectToBeTested.Get24HourTimeString("9"), ;
						 "Get24HourTimeString('9') did not return '0900'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input10_Returns1000
This.AssertEquals( "1000", this.ioObjectToBeTested.Get24HourTimeString("10"), ;
						 "Get24HourTimeString('10') did not return '1000'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input11_Returns1100
This.AssertEquals( "1100", this.ioObjectToBeTested.Get24HourTimeString("11"), ;
						 "Get24HourTimeString('11') did not return '1100'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input12_Returns1200
This.AssertEquals( "1200", this.ioObjectToBeTested.Get24HourTimeString("12"), ;
						 "Get24HourTimeString('12') did not return '1200'")
ENDFUNC

*	AM tests
FUNCTION TestGet24HourTimeString_Input1a_Returns0100
This.AssertEquals( "0100", this.ioObjectToBeTested.Get24HourTimeString("1a"), ;
						 "Get24HourTimeString('1a') did not return '0100'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input2a_Returns0200
This.AssertEquals( "0200", this.ioObjectToBeTested.Get24HourTimeString("2a"), ;
						 "Get24HourTimeString('2a') did not return '0200'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input3a_Returns0300
This.AssertEquals( "0300", this.ioObjectToBeTested.Get24HourTimeString("3a"), ;
						 "Get24HourTimeString('3a') did not return '0300'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input4a_Returns0400
This.AssertEquals( "0400", this.ioObjectToBeTested.Get24HourTimeString("4a"), ;
						 "Get24HourTimeString('4a') did not return '0400'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input5a_Returns0500
This.AssertEquals( "0500", this.ioObjectToBeTested.Get24HourTimeString("5a"), ;
						 "Get24HourTimeString('5a') did not return '0500'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input6a_Returns0600
This.AssertEquals( "0600", this.ioObjectToBeTested.Get24HourTimeString("6a"), ;
						 "Get24HourTimeString('6a') did not return '0600'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input7a_Returns0700
This.AssertEquals( "0700", this.ioObjectToBeTested.Get24HourTimeString("7a"), ;
						 "Get24HourTimeString('7a') did not return '0700'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input8a_Returns0800
This.AssertEquals( "0800", this.ioObjectToBeTested.Get24HourTimeString("8a"), ;
						 "Get24HourTimeString('8a') did not return '0800'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input9a_Returns0900
This.AssertEquals( "0900", this.ioObjectToBeTested.Get24HourTimeString("9a"), ;
						 "Get24HourTimeString('9a') did not return '0900'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input10a_Returns1000
This.AssertEquals( "1000", this.ioObjectToBeTested.Get24HourTimeString("10a"), ;
						 "Get24HourTimeString('10a') did not return '1000'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input11a_Returns1100
This.AssertEquals( "1100", this.ioObjectToBeTested.Get24HourTimeString("11a"), ;
						 "Get24HourTimeString('11a') did not return '1100'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input12a_Returns1200
This.AssertEquals( "0000", this.ioObjectToBeTested.Get24HourTimeString("12a"), ;
						 "Get24HourTimeString('12a') did not return '0000'")
ENDFUNC

*	PM tests
FUNCTION TestGet24HourTimeString_Input1p_Returns1300
This.AssertEquals( "1300", this.ioObjectToBeTested.Get24HourTimeString("1p"), ;
						 "Get24HourTimeString('1p') did not return '1300'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input2p_Returns1400
This.AssertEquals( "1400", this.ioObjectToBeTested.Get24HourTimeString("2p"), ;
						 "Get24HourTimeString('2p') did not return '1400'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input3p_Returns1500
This.AssertEquals( "1500", this.ioObjectToBeTested.Get24HourTimeString("3p"), ;
						 "Get24HourTimeString('3p') did not return '1500'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input4p_Returns1600
This.AssertEquals( "1600", this.ioObjectToBeTested.Get24HourTimeString("4p"), ;
						 "Get24HourTimeString('4p') did not return '1600'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input5p_Returns1700
This.AssertEquals( "1700", this.ioObjectToBeTested.Get24HourTimeString("5p"), ;
						 "Get24HourTimeString('5p') did not return '1700'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input6p_Returns1800
This.AssertEquals( "1800", this.ioObjectToBeTested.Get24HourTimeString("6p"), ;
						 "Get24HourTimeString('6p') did not return '1800'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input7p_Returns1900
This.AssertEquals( "1900", this.ioObjectToBeTested.Get24HourTimeString("7p"), ;
						 "Get24HourTimeString('7p') did not return '1900'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input8p_Returns2000
This.AssertEquals( "2000", this.ioObjectToBeTested.Get24HourTimeString("8p"), ;
						 "Get24HourTimeString('8p') did not return '2000'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input9p_Returns2100
This.AssertEquals( "2100", this.ioObjectToBeTested.Get24HourTimeString("9p"), ;
						 "Get24HourTimeString('9p') did not return '2100'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input10p_Returns2200
This.AssertEquals( "2200", this.ioObjectToBeTested.Get24HourTimeString("10p"), ;
						 "Get24HourTimeString('10p') did not return '2200'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input11p_Returns2300
This.AssertEquals( "2300", this.ioObjectToBeTested.Get24HourTimeString("11p"), ;
						 "Get24HourTimeString('11p') did not return '2300'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input12p_Returns1200
This.AssertEquals( "1200", this.ioObjectToBeTested.Get24HourTimeString("12p"), ;
						 "Get24HourTimeString('12p') did not return '1200'")
ENDFUNC

*	Tests for input times with colons and minutes

FUNCTION TestGet24HourTimeString_Input1015am_Returns1015
This.AssertEquals( "1015", this.ioObjectToBeTested.Get24HourTimeString("10:15am"), ;
						 "Get24HourTimeString('10:15am') did not return '1015'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input100pm_Returns1300
This.AssertEquals( "1300", this.ioObjectToBeTested.Get24HourTimeString("1:00pm"), ;
						 "Get24HourTimeString('1:00pm') did not return '1300'")
ENDFUNC

FUNCTION TestGet24HourTimeString_Input230pm_Returns1430
This.AssertEquals( "1430", this.ioObjectToBeTested.Get24HourTimeString("2:30pm"), ;
						 "Get24HourTimeString('2:30pm') did not return '1430'")
ENDFUNC

*	Tests for funky input strings
FUNCTION TestGet24HourTimeString_FunkyInput1_Returns1430
This.AssertEquals( "1430", this.ioObjectToBeTested.Get24HourTimeString("2p:30"), ;
						 "Get24HourTimeString('2p:30') did not return '1430'")
ENDFUNC

FUNCTION TestGet24HourTimeString_FunkyInput2_ReturnsEmptyString
This.AssertEquals( "", this.ioObjectToBeTested.Get24HourTimeString("Foo"), ;
						 "Get24HourTimeString('Foo') did not return the empty string")
ENDFUNC

*---------------------------------------------------------------------
*	Tests for GetIntervalDays
*---------------------------------------------------------------------
FUNCTION TestGetIntervalDays_NoInput_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetIntervalDays(), ;
						 "GetIntervalDays() did not return the expected value")
ENDFUNC

FUNCTION TestGetIntervalDays_BadInput_ReturnsZero
LOCAL lnExpected
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetIntervalDays( .F.), ;
						 "GetIntervalDays() did not return the expected value")
ENDFUNC

FUNCTION TestGetIntervalDays_IntervalTypeOmitted_ReturnsExpectedValue
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = 1
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetIntervalDays( ldToday, ldToday + 1 ), ;
						 "GetIntervalDays() did not return the expected value")
ENDFUNC

FUNCTION TestGetIntervalDays_IntervalType0_ReturnsExpectedValue
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = 1
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetIntervalDays( ldToday, ldToday + 1, 0 ), ;
						 "GetIntervalDays() did not return the expected value")
ENDFUNC

FUNCTION TestGetIntervalDays_IntervalType1_ReturnsExpectedValue
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = 2
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetIntervalDays( ldToday, ldToday + 1, 1 ), ;
						 "GetIntervalDays() did not return the expected value")
ENDFUNC

FUNCTION TestGetIntervalDays_IntervalType2_ReturnsExpectedValue
LOCAL ldToday, lnExpected
ldToday = DATE()
lnExpected = 0
This.AssertEquals( lnExpected, this.ioObjectToBeTested.GetIntervalDays( ldToday, ldToday + 1, 2 ), ;
						 "GetIntervalDays() did not return the expected value")
ENDFUNC


*---------------------------------------------------------------------
*	Tests not yet implemented
*---------------------------------------------------------------------
*!*	HIDDEN FUNCTION TestGetFirstOfMonth_NotImplemented
*!*	This.AssertNotImplemented( "This test is not yet implemented")
*!*	*	The following two lines can be used in place of AssertNotImplemented()
*!*	*	if AssertNotImplemented() returns .F. but you'd prefer it to return .T.
*!*	*!*	This.ioAssert.ReportNotImplemented("TestGetFirstOfMonth is not implemented yet")
*!*	*!*	RETURN .T.
*!*	ENDFUNC

FUNCTION testNewTest
* 1. Change the name of the test to reflect its purpose. Test one thing only.
* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
RETURN This.AssertNotImplemented()
ENDFUNC

**********************************************************************
ENDDEFINE
**********************************************************************
