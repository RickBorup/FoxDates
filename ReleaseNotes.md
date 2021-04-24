# FoxDates

## Release Notes

**Version 2021.0**

Released 24 April 2021

1. All functions that accept a date as a parameter now also accept a datetime. This is particularly useful when working with date fields in a cursor created by a SQL Server query. 
* If a date is passed the return value is a date.
* If a datetime is passed the return value is a datetime.
* For functions like GetFirstOfMonth() that return the beginning of a period, the time portion of a datetime return value is 00:00:00.
* For functions like GetLastOfMonth() that return the end of a period, the time portion of a datetime return value is 23:59:59.
* GetLastMonday() and GetNextMonday() preserve the time portion if a datetime is passed.

2. Added new function GetLastBOQ().

3. Added ReleaseNotes.md (this document).
