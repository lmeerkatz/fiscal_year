
/*******************************************************************************************************
* @author Laura Meerkatz
* @date 07/12/2013
* @description Test class for utility that calculates fiscal year for a given date
*/

@isTest
private class TEST_UTIL_FiscalYear{
	private static testMethod void testFiscalYearStartMonth() {
        organization o = [select fiscalYearStartMonth, UsesStartDateAsFiscalYearName from organization limit 1];
        Date monthFYStart = Date.newInstance(system.now().year(), o.FiscalYearStartMonth, 1);
        Date monthBefore = Date.newInstance(system.now().year(), o.FiscalYearStartMonth, 1).addMonths(-1);
        Date monthAfter = Date.newInstance(system.now().year(), o.FiscalYearStartMonth, 1).addMonths(1);
        
        // if we could set organization settings for tests, it would be better to test both scenarios
        if (o.UsesStartDateAsFiscalYearName) {
        	// if the start date is the fiscal year name, and the month falls before the fiscal year start month
        	// the fiscal year should be one less than the calendar year
	  		System.assertEquals(system.now().year() - 1, UTIL_FiscalYear.getFiscalYear(monthBefore));
	  		// if the month falls after the fiscal year start month, the fiscal year and calendar year should match
	   		System.assertEquals(system.now().year(), UTIL_FiscalYear.getFiscalYear(monthAfter));
            // if the month matches the month the fiscal year starts, the fiscal year and the calendar year should match
            System.assertEquals(system.now().year(), UTIL_FiscalYear.getFiscalYear(monthFYStart));
        } else {
        	// if the end date is the fiscal year name, and the month falls before the fiscal year start month
        	// the fiscal year should match the calendar year
        	System.assertEquals(system.now().year(), UTIL_FiscalYear.getFiscalYear(monthBefore));
        	// if the month falls after the fiscal year start month
        	// the fiscal year be one more than the calendar year
	    	System.assertEquals(system.now().year() + 1, UTIL_FiscalYear.getFiscalYear(monthAfter));
            // if the month matches the fiscal year start month
        	// the fiscal year be one more than the calendar year
            System.assertEquals(system.now().year() + 1, UTIL_FiscalYear.getFiscalYear(monthFYStart));
        }
        
	}
}