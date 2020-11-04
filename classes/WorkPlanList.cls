public with sharing class WorkPlanList {
    
    public List<User> currentUsers {get;private set;}
    
    public WorkPlanList() {
        currentUsers = [Select u.dealer__Flat_Rate_Hourly_Wage__c, u.Username, u.UserType, u.UserRoleId, u.Title, u.TimeZoneSidKey, u.SystemModstamp, 
                                u.Street, u.State, u.SmallPhotoUrl, u.ReceivesInfoEmails, u.ReceivesAdminInfoEmails, u.ProfileId, u.PostalCode, u.Phone, 
                                u.Name, u.MobilePhone, u.ManagerId, u.LocaleSidKey, u.LastPasswordChangeDate, u.LastName, u.LastModifiedDate, u.LastModifiedById, 
                                u.LastLoginDate, u.IsActive, u.Id, u.FullPhotoUrl, u.ForecastEnabled, u.FirstName,
                                u.Fax, u.Extension, u.EmployeeNumber, u.EmailEncodingKey, u.Email, u.Division, u.DigestFrequency, u.Department, u.DelegatedApproverId, 
                                u.DefaultGroupNotificationFrequency, u.CreatedDate, u.CreatedById, u.Country, u.ContactId, u.CompanyName, 
                                u.CommunityNickname, u.City, u.CallCenterId, u.Alias, u.AccountId, u.AboutMe 
                                From User u
                                Where u.IsActive=true
                                limit 100];
    }
}