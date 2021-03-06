/*******************************************************************************************************
* @author Laura Meerkatz
* @date 07/12/2013
* @description Utility that calculates fiscal year for a given date based on organization's fiscal year start month and whether they name fiscal years by the starting or ending month
*/

public without sharing class UTIL_FiscalYear {
	public static integer getFiscalYear(Date theDate) {
		Integer fy = theDate.year();
		  
        // UsesStartDateAsFiscalYearName: 
        // Indicates whether the calendar year when the fiscal year begins is referred to as the year of the company's fiscal year (true) or not (false). 
        // For example, if the fiscal year begins in February 2006, a true value means the fiscal year is FY2006, 
        // and a false value means the fiscal year is FY2007.
        
        organization o = [select fiscalYearStartMonth, UsesStartDateAsFiscalYearName from organization limit 1];
        // if the organization bases the FY name off of the start month (FY2013 starts July 1, 2013),
        // adjust any date that falls in the first part of the year
        if (o.FiscalYearStartMonth > theDate.month() && o.UsesStartDateAsFiscalYearName) {
            fy--;
        } 
        // if the organization bases the FY name off of the end month (FY2013 starts July 1, 2012),
        // adjust any date that falls in the latter part of the year
        else if (o.FiscalYearStartMonth <= theDate.month() && !o.UsesStartDateAsFiscalYearName) {
        	fy++;
        }
        return fy;
	}
}
