---
layout: default
---
# MetadataService

Copyright (c), FinancialForce.com, inc
All rights reserved.
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
- Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
- Neither the name of the FinancialForce.com, inc nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Fields

### `public SOAP_M_URI` → `String`


---
## Classes
### ReportTypeColumnTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LightningBoltFeatures
#### Fields

##### `public description` → `String`


##### `public order` → `Integer`


##### `public title` → `String`


##### `private description_type_info` → `String`


##### `private order_type_info` → `String`


##### `private title_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportFilterItem
#### Fields

##### `public column` → `String`


##### `public columnToColumn` → `Boolean`


##### `public isUnlocked` → `Boolean`


##### `public operator` → `String`


##### `public snapshot` → `String`


##### `public value` → `String`


##### `private column_type_info` → `String`


##### `private columnToColumn_type_info` → `String`


##### `private isUnlocked_type_info` → `String`


##### `private operator_type_info` → `String`


##### `private snapshot_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowElementReferenceOrValue
#### Fields

##### `public booleanValue` → `Boolean`


##### `public dateTimeValue` → `DateTime`


##### `public dateValue` → `Date`


##### `public elementReference` → `String`


##### `public numberValue` → `Double`


##### `public stringValue` → `String`


##### `private booleanValue_type_info` → `String`


##### `private dateTimeValue_type_info` → `String`


##### `private dateValue_type_info` → `String`


##### `private elementReference_type_info` → `String`


##### `private numberValue_type_info` → `String`


##### `private stringValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowWaitEventOutputParameter

**Inheritance**

FlowWaitEventOutputParameter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public assignToReference` → `String`


##### `public name` → `String`


##### `private assignToReference_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### MacroSettings
#### Fields

##### `public enableAdvancedSearch` → `Boolean`


##### `private enableAdvancedSearch_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeSuggestedArticlesSettings
#### Fields

##### `public caseFields` → `MetadataService`


##### `public useSuggestedArticlesForCase` → `Boolean`


##### `public workOrderFields` → `MetadataService`


##### `public workOrderLineItemFields` → `MetadataService`


##### `private caseFields_type_info` → `String`


##### `private useSuggestedArticlesForCase_type_info` → `String`


##### `private workOrderFields_type_info` → `String`


##### `private workOrderLineItemFields_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SaveResult
#### Fields

##### `public errors` → `MetadataService.Error`


##### `public fullName` → `String`


##### `public success` → `Boolean`


##### `private errors_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private success_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ExtendedErrorDetails
#### Fields

##### `public extendedErrorCode` → `String`


##### `private extendedErrorCode_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingOwnerRule

**Inheritance**

SharingOwnerRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessLevel` → `String`


##### `public accountSettings` → `MetadataService`


##### `public description` → `String`


##### `public label` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessLevel_type_info` → `String`


##### `private accountSettings_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `public sharedFrom` → `MetadataService`


##### `private sharedFrom_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomExperienceTabSet
#### Fields

##### `public customTab` → `String`


##### `public defaultTab` → `String`


##### `public standardTab` → `String`


##### `private customTab_type_info` → `String`


##### `private defaultTab_type_info` → `String`


##### `private standardTab_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldMappingField
#### Fields

##### `public dataServiceField` → `String`


##### `public dataServiceObjectName` → `String`


##### `public priority` → `Integer`


##### `private dataServiceField_type_info` → `String`


##### `private dataServiceObjectName_type_info` → `String`


##### `private priority_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CaseSettings

**Inheritance**

CaseSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public caseAssignNotificationTemplate` → `String`


##### `public caseCloseNotificationTemplate` → `String`


##### `public caseCommentNotificationTemplate` → `String`


##### `public caseCreateNotificationTemplate` → `String`


##### `public caseFeedItemSettings` → `MetadataService.FeedItemSettings`


##### `public closeCaseThroughStatusChange` → `Boolean`


##### `public defaultCaseOwner` → `String`


##### `public defaultCaseOwnerType` → `String`


##### `public defaultCaseUser` → `String`


##### `public emailActionDefaultsHandlerClass` → `String`


##### `public emailToCase` → `MetadataService`


##### `public enableCaseFeed` → `Boolean`


##### `public enableDraftEmails` → `Boolean`


##### `public enableEarlyEscalationRuleTriggers` → `Boolean`


##### `public enableEmailActionDefaultsHandler` → `Boolean`


##### `public enableSuggestedArticlesApplication` → `Boolean`


##### `public enableSuggestedArticlesCustomerPortal` → `Boolean`


##### `public enableSuggestedArticlesPartnerPortal` → `Boolean`


##### `public enableSuggestedSolutions` → `Boolean`


##### `public keepRecordTypeOnAssignmentRule` → `Boolean`


##### `public notifyContactOnCaseComment` → `Boolean`


##### `public notifyDefaultCaseOwner` → `Boolean`


##### `public notifyOwnerOnCaseComment` → `Boolean`


##### `public notifyOwnerOnCaseOwnerChange` → `Boolean`


##### `public showEmailAttachmentsInCaseAttachmentsRL` → `Boolean`


##### `public showFewerCloseActions` → `Boolean`


##### `public systemUserEmail` → `String`


##### `public useSystemEmailAddress` → `Boolean`


##### `public useSystemUserAsDefaultCaseUser` → `Boolean`


##### `public webToCase` → `MetadataService`


##### `private caseAssignNotificationTemplate_type_info` → `String`


##### `private caseCloseNotificationTemplate_type_info` → `String`


##### `private caseCommentNotificationTemplate_type_info` → `String`


##### `private caseCreateNotificationTemplate_type_info` → `String`


##### `private caseFeedItemSettings_type_info` → `String`


##### `private closeCaseThroughStatusChange_type_info` → `String`


##### `private defaultCaseOwner_type_info` → `String`


##### `private defaultCaseOwnerType_type_info` → `String`


##### `private defaultCaseUser_type_info` → `String`


##### `private emailActionDefaultsHandlerClass_type_info` → `String`


##### `private emailToCase_type_info` → `String`


##### `private enableCaseFeed_type_info` → `String`


##### `private enableDraftEmails_type_info` → `String`


##### `private enableEarlyEscalationRuleTriggers_type_info` → `String`


##### `private enableEmailActionDefaultsHandler_type_info` → `String`


##### `private enableSuggestedArticlesApplication_type_info` → `String`


##### `private enableSuggestedArticlesCustomerPortal_type_info` → `String`


##### `private enableSuggestedArticlesPartnerPortal_type_info` → `String`


##### `private enableSuggestedSolutions_type_info` → `String`


##### `private keepRecordTypeOnAssignmentRule_type_info` → `String`


##### `private notifyContactOnCaseComment_type_info` → `String`


##### `private notifyDefaultCaseOwner_type_info` → `String`


##### `private notifyOwnerOnCaseComment_type_info` → `String`


##### `private notifyOwnerOnCaseOwnerChange_type_info` → `String`


##### `private showEmailAttachmentsInCaseAttachmentsRL_type_info` → `String`


##### `private showFewerCloseActions_type_info` → `String`


##### `private systemUserEmail_type_info` → `String`


##### `private useSystemEmailAddress_type_info` → `String`


##### `private useSystemUserAsDefaultCaseUser_type_info` → `String`


##### `private webToCase_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### readMetadataResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecommendationDefinition
#### Fields

##### `public recommendationDefinitionDetails` → `MetadataService.RecommendationDefinitionDetail`


##### `private recommendationDefinitionDetails_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### MiniLayout
#### Fields

##### `public fields` → `String`


##### `public relatedLists` → `MetadataService.RelatedListItem`


##### `private fields_type_info` → `String`


##### `private relatedLists_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldValue
#### Fields

##### `public name` → `String`


##### `public value` → `String`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LicensedCustomPermissions
#### Fields

##### `public customPermission` → `String`


##### `public licenseDefinition` → `String`


##### `private customPermission_type_info` → `String`


##### `private licenseDefinition_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### UpsertResult
#### Fields

##### `public created` → `Boolean`


##### `public errors` → `MetadataService.Error`


##### `public fullName` → `String`


##### `public success` → `Boolean`


##### `private created_type_info` → `String`


##### `private errors_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private success_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdDimension
#### Fields

##### `public customActions` → `MetadataService.WaveXmdDimensionCustomAction`


##### `public customActionsEnabled` → `Boolean`


##### `public dateFormat` → `String`


##### `public description` → `String`


##### `public field` → `String`


##### `public fullyQualifiedName` → `String`


##### `public imageTemplate` → `String`


##### `public isDerived` → `Boolean`


##### `public isMultiValue` → `Boolean`


##### `public label` → `String`


##### `public linkTemplate` → `String`


##### `public linkTemplateEnabled` → `Boolean`


##### `public linkTooltip` → `String`


##### `public members` → `MetadataService.WaveXmdDimensionMember`


##### `public origin` → `String`


##### `public recordDisplayFields` → `MetadataService.WaveXmdRecordDisplayLookup`


##### `public recordIdField` → `String`


##### `public recordOrganizationIdField` → `String`


##### `public salesforceActions` → `MetadataService.WaveXmdDimensionSalesforceAction`


##### `public salesforceActionsEnabled` → `Boolean`


##### `public showDetailsDefaultFieldIndex` → `Integer`


##### `public showInExplorer` → `Boolean`


##### `public sortIndex` → `Integer`


##### `private customActions_type_info` → `String`


##### `private customActionsEnabled_type_info` → `String`


##### `private dateFormat_type_info` → `String`


##### `private description_type_info` → `String`


##### `private field_type_info` → `String`


##### `private fullyQualifiedName_type_info` → `String`


##### `private imageTemplate_type_info` → `String`


##### `private isDerived_type_info` → `String`


##### `private isMultiValue_type_info` → `String`


##### `private label_type_info` → `String`


##### `private linkTemplate_type_info` → `String`


##### `private linkTemplateEnabled_type_info` → `String`


##### `private linkTooltip_type_info` → `String`


##### `private members_type_info` → `String`


##### `private origin_type_info` → `String`


##### `private recordDisplayFields_type_info` → `String`


##### `private recordIdField_type_info` → `String`


##### `private recordOrganizationIdField_type_info` → `String`


##### `private salesforceActions_type_info` → `String`


##### `private salesforceActionsEnabled_type_info` → `String`


##### `private showDetailsDefaultFieldIndex_type_info` → `String`


##### `private showInExplorer_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppAttribute
#### Fields

##### `public formula` → `String`


##### `public key` → `String`


##### `private formula_type_info` → `String`


##### `private key_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppSessionPolicy
#### Fields

##### `public policyAction` → `String`


##### `public sessionLevel` → `String`


##### `public sessionTimeout` → `Integer`


##### `private policyAction_type_info` → `String`


##### `private sessionLevel_type_info` → `String`


##### `private sessionTimeout_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OauthCustomScopeApp
#### Fields

##### `public connectedApp` → `String`


##### `private connectedApp_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppSettings
#### Fields

##### `public connectedAppName` → `String`


##### `public enabled` → `Boolean`


##### `private connectedAppName_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowFieldUpdate

**Inheritance**

WorkflowFieldUpdate

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public field` → `String`


##### `public formula` → `String`


##### `public literalValue` → `String`


##### `public lookupValue` → `String`


##### `public lookupValueType` → `String`


##### `public name` → `String`


##### `public notifyAssignee` → `Boolean`


##### `public operation` → `String`


##### `public protected_x` → `Boolean`


##### `public reevaluateOnChange` → `Boolean`


##### `public targetObject` → `String`


##### `private description_type_info` → `String`


##### `private field_type_info` → `String`


##### `private formula_type_info` → `String`


##### `private literalValue_type_info` → `String`


##### `private lookupValue_type_info` → `String`


##### `private lookupValueType_type_info` → `String`


##### `private name_type_info` → `String`


##### `private notifyAssignee_type_info` → `String`


##### `private operation_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private reevaluateOnChange_type_info` → `String`


##### `private targetObject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### AssignmentRule

**Inheritance**

AssignmentRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public ruleEntry` → `MetadataService.RuleEntry`


##### `private active_type_info` → `String`


##### `private ruleEntry_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValueSettings
#### Fields

##### `public controllingFieldValue` → `String`


##### `public valueName` → `String`


##### `private controllingFieldValue_type_info` → `String`


##### `private valueName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveChatButtonDeployments
#### Fields

##### `public deployment` → `String`


##### `private deployment_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DataCategoryGroup

**Inheritance**

DataCategoryGroup

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public dataCategory` → `MetadataService`


##### `public description` → `String`


##### `public label` → `String`


##### `public objectUsage` → `MetadataService`


##### `private active_type_info` → `String`


##### `private dataCategory_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private objectUsage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardGridComponent
#### Fields

##### `public colSpan` → `Integer`


##### `public columnIndex` → `Integer`


##### `public dashboardComponent` → `MetadataService`


##### `public rowIndex` → `Integer`


##### `public rowSpan` → `Integer`


##### `private colSpan_type_info` → `String`


##### `private columnIndex_type_info` → `String`


##### `private dashboardComponent_type_info` → `String`


##### `private rowIndex_type_info` → `String`


##### `private rowSpan_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomDataTypeComponent
#### Fields

##### `public developerSuffix` → `String`


##### `public enforceFieldRequiredness` → `Boolean`


##### `public label` → `String`


##### `public length` → `Integer`


##### `public precision` → `Integer`


##### `public scale` → `Integer`


##### `public sortOrder` → `String`


##### `public sortPriority` → `Integer`


##### `public type_x` → `String`


##### `private developerSuffix_type_info` → `String`


##### `private enforceFieldRequiredness_type_info` → `String`


##### `private label_type_info` → `String`


##### `private length_type_info` → `String`


##### `private precision_type_info` → `String`


##### `private scale_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private sortPriority_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### NetworkBranding

**Inheritance**

NetworkBranding

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public loginFooterText` → `String`


##### `public loginLogo` → `String`


##### `public loginLogoName` → `String`


##### `public loginPrimaryColor` → `String`


##### `public loginQuaternaryColor` → `String`


##### `public loginRightFrameUrl` → `String`


##### `public network` → `String`


##### `public pageFooter` → `String`


##### `public pageHeader` → `String`


##### `public primaryColor` → `String`


##### `public primaryComplementColor` → `String`


##### `public quaternaryColor` → `String`


##### `public quaternaryComplementColor` → `String`


##### `public secondaryColor` → `String`


##### `public staticLogoImageUrl` → `String`


##### `public tertiaryColor` → `String`


##### `public tertiaryComplementColor` → `String`


##### `public zeronaryColor` → `String`


##### `public zeronaryComplementColor` → `String`


##### `private loginFooterText_type_info` → `String`


##### `private loginLogo_type_info` → `String`


##### `private loginLogoName_type_info` → `String`


##### `private loginPrimaryColor_type_info` → `String`


##### `private loginQuaternaryColor_type_info` → `String`


##### `private loginRightFrameUrl_type_info` → `String`


##### `private network_type_info` → `String`


##### `private pageFooter_type_info` → `String`


##### `private pageHeader_type_info` → `String`


##### `private primaryColor_type_info` → `String`


##### `private primaryComplementColor_type_info` → `String`


##### `private quaternaryColor_type_info` → `String`


##### `private quaternaryComplementColor_type_info` → `String`


##### `private secondaryColor_type_info` → `String`


##### `private staticLogoImageUrl_type_info` → `String`


##### `private tertiaryColor_type_info` → `String`


##### `private tertiaryComplementColor_type_info` → `String`


##### `private zeronaryColor_type_info` → `String`


##### `private zeronaryComplementColor_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### UserCriteria

**Inheritance**

UserCriteria

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public creationAgeInSeconds` → `Integer`


##### `public description` → `String`


##### `public lastChatterActivityAgeInSeconds` → `Integer`


##### `public masterLabel` → `String`


##### `public profiles` → `String`


##### `public userTypes` → `String`


##### `private creationAgeInSeconds_type_info` → `String`


##### `private description_type_info` → `String`


##### `private lastChatterActivityAgeInSeconds_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private profiles_type_info` → `String`


##### `private userTypes_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeSitesSettings
#### Fields

##### `public site` → `String`


##### `private site_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LightningBoltImages
#### Fields

##### `public image` → `String`


##### `public order` → `Integer`


##### `private image_type_info` → `String`


##### `private order_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SearchLayouts
#### Fields

##### `public customTabListAdditionalFields` → `String`


##### `public excludedStandardButtons` → `String`


##### `public listViewButtons` → `String`


##### `public lookupDialogsAdditionalFields` → `String`


##### `public lookupFilterFields` → `String`


##### `public lookupPhoneDialogsAdditionalFields` → `String`


##### `public searchFilterFields` → `String`


##### `public searchResultsAdditionalFields` → `String`


##### `public searchResultsCustomButtons` → `String`


##### `private customTabListAdditionalFields_type_info` → `String`


##### `private excludedStandardButtons_type_info` → `String`


##### `private listViewButtons_type_info` → `String`


##### `private lookupDialogsAdditionalFields_type_info` → `String`


##### `private lookupFilterFields_type_info` → `String`


##### `private lookupPhoneDialogsAdditionalFields_type_info` → `String`


##### `private searchFilterFields_type_info` → `String`


##### `private searchResultsAdditionalFields_type_info` → `String`


##### `private searchResultsCustomButtons_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### retrieve_element
#### Fields

##### `public retrieveRequest` → `MetadataService`


##### `private retrieveRequest_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AssignmentRules

**Inheritance**

AssignmentRules

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public assignmentRule` → `MetadataService.AssignmentRule`


##### `private assignmentRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DeleteResult
#### Fields

##### `public errors` → `MetadataService.Error`


##### `public fullName` → `String`


##### `public success` → `Boolean`


##### `private errors_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private success_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PackageTypeMembers
#### Fields

##### `public members` → `String`


##### `public name` → `String`


##### `private members_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardFilter
#### Fields

##### `public dashboardFilterOptions` → `MetadataService.DashboardFilterOption`


##### `public name` → `String`


##### `private dashboardFilterOptions_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecommendationAudience
#### Fields

##### `public recommendationAudienceDetails` → `MetadataService.RecommendationAudienceDetail`


##### `private recommendationAudienceDetails_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileApplicationVisibility
#### Fields

##### `public application` → `String`


##### `public default_x` → `Boolean`


##### `public visible` → `Boolean`


##### `private application_type_info` → `String`


##### `private default_x_type_info` → `String`


##### `private visible_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportParam
#### Fields

##### `public name` → `String`


##### `public value` → `String`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RelatedListItem
#### Fields

##### `public customButtons` → `String`


##### `public excludeButtons` → `String`


##### `public fields` → `String`


##### `public relatedList` → `String`


##### `public sortField` → `String`


##### `public sortOrder` → `String`


##### `private customButtons_type_info` → `String`


##### `private excludeButtons_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private relatedList_type_info` → `String`


##### `private sortField_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SynonymDictionary

**Inheritance**

SynonymDictionary

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public groups` → `MetadataService.SynonymGroup`


##### `public isProtected` → `Boolean`


##### `public label` → `String`


##### `private groups_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmd

**Inheritance**

WaveXmd

#### Fields

##### `public application` → `String`


##### `public dataset` → `String`


##### `public datasetConnector` → `String`


##### `public datasetFullyQualifiedName` → `String`


##### `public dates` → `MetadataService.WaveXmdDate`


##### `public dimensions` → `MetadataService.WaveXmdDimension`


##### `public measures` → `MetadataService.WaveXmdMeasure`


##### `public organizations` → `MetadataService.WaveXmdOrganization`


##### `public origin` → `String`


##### `public type_x` → `String`


##### `public waveVisualization` → `String`


##### `private application_type_info` → `String`


##### `private dataset_type_info` → `String`


##### `private datasetConnector_type_info` → `String`


##### `private datasetFullyQualifiedName_type_info` → `String`


##### `private dates_type_info` → `String`


##### `private dimensions_type_info` → `String`


##### `private measures_type_info` → `String`


##### `private organizations_type_info` → `String`


##### `private origin_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private waveVisualization_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WebLinkTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LightningExperienceTheme
#### Fields

##### `public defaultBrandingSet` → `String`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public shouldOverrideLoadingImage` → `Boolean`


##### `private defaultBrandingSet_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private shouldOverrideLoadingImage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileCategoryGroupVisibility
#### Fields

##### `public dataCategories` → `String`


##### `public dataCategoryGroup` → `String`


##### `public visibility` → `String`


##### `private dataCategories_type_info` → `String`


##### `private dataCategoryGroup_type_info` → `String`


##### `private visibility_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomTabTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PackageVersion
#### Fields

##### `public majorNumber` → `Integer`


##### `public minorNumber` → `Integer`


##### `public namespace` → `String`


##### `private majorNumber_type_info` → `String`


##### `private minorNumber_type_info` → `String`


##### `private namespace_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DescribeMetadataObject
#### Fields

##### `public childXmlNames` → `String`


##### `public directoryName` → `String`


##### `public inFolder` → `Boolean`


##### `public metaFile` → `Boolean`


##### `public suffix` → `String`


##### `public xmlName` → `String`


##### `private childXmlNames_type_info` → `String`


##### `private directoryName_type_info` → `String`


##### `private inFolder_type_info` → `String`


##### `private metaFile_type_info` → `String`


##### `private suffix_type_info` → `String`


##### `private xmlName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveAgentSettings

**Inheritance**

LiveAgentSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableLiveAgent` → `Boolean`


##### `private enableLiveAgent_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowFlowAction
#### Fields

##### `public description` → `String`


##### `public flow` → `String`


##### `public flowInputs` → `MetadataService.WorkflowFlowActionParameter`


##### `public label` → `String`


##### `public language` → `String`


##### `public protected_x` → `Boolean`


##### `private description_type_info` → `String`


##### `private flow_type_info` → `String`


##### `private flowInputs_type_info` → `String`


##### `private label_type_info` → `String`


##### `private language_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveApplication

**Inheritance**

WaveApplication

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public assetIcon` → `String`


##### `public description` → `String`


##### `public folder` → `String`


##### `public masterLabel` → `String`


##### `public shares` → `MetadataService.FolderShare`


##### `public templateOrigin` → `String`


##### `public templateVersion` → `String`


##### `private assetIcon_type_info` → `String`


##### `private description_type_info` → `String`


##### `private folder_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private shares_type_info` → `String`


##### `private templateOrigin_type_info` → `String`


##### `private templateVersion_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### AllOrNoneHeader_element
#### Fields

##### `public allOrNone` → `Boolean`


##### `private allOrNone_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowTaskTranslation
#### Fields

##### `public description` → `String`


##### `public name` → `String`


##### `public subject` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `private subject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SearchSettings

**Inheritance**

SearchSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public documentContentSearchEnabled` → `Boolean`


##### `public optimizeSearchForCJKEnabled` → `Boolean`


##### `public recentlyViewedUsersForBlankLookupEnabled` → `Boolean`


##### `public searchSettingsByObject` → `MetadataService`


##### `public sidebarAutoCompleteEnabled` → `Boolean`


##### `public sidebarDropDownListEnabled` → `Boolean`


##### `public sidebarLimitToItemsIOwnCheckboxEnabled` → `Boolean`


##### `public singleSearchResultShortcutEnabled` → `Boolean`


##### `public spellCorrectKnowledgeSearchEnabled` → `Boolean`


##### `private documentContentSearchEnabled_type_info` → `String`


##### `private optimizeSearchForCJKEnabled_type_info` → `String`


##### `private recentlyViewedUsersForBlankLookupEnabled_type_info` → `String`


##### `private searchSettingsByObject_type_info` → `String`


##### `private sidebarAutoCompleteEnabled_type_info` → `String`


##### `private sidebarDropDownListEnabled_type_info` → `String`


##### `private sidebarLimitToItemsIOwnCheckboxEnabled_type_info` → `String`


##### `private singleSearchResultShortcutEnabled_type_info` → `String`


##### `private spellCorrectKnowledgeSearchEnabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### listMetadata_element
#### Fields

##### `public queries` → `MetadataService.ListMetadataQuery`


##### `public asOfVersion` → `Double`


##### `private queries_type_info` → `String`


##### `private asOfVersion_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AuraDefinitionBundle

**Inheritance**

AuraDefinitionBundle

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public SVGContent` → `String`


##### `public apiVersion` → `Double`


##### `public controllerContent` → `String`


##### `public description` → `String`


##### `public designContent` → `String`


##### `public documentationContent` → `String`


##### `public helperContent` → `String`


##### `public markup` → `String`


##### `public modelContent` → `String`


##### `public packageVersions` → `MetadataService.PackageVersion`


##### `public rendererContent` → `String`


##### `public styleContent` → `String`


##### `public testsuiteContent` → `String`


##### `public type_x` → `String`


##### `private SVGContent_type_info` → `String`


##### `private apiVersion_type_info` → `String`


##### `private controllerContent_type_info` → `String`


##### `private description_type_info` → `String`


##### `private designContent_type_info` → `String`


##### `private documentationContent_type_info` → `String`


##### `private helperContent_type_info` → `String`


##### `private markup_type_info` → `String`


##### `private modelContent_type_info` → `String`


##### `private packageVersions_type_info` → `String`


##### `private rendererContent_type_info` → `String`


##### `private styleContent_type_info` → `String`


##### `private testsuiteContent_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Queue

**Inheritance**

Queue

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public doesSendEmailToMembers` → `Boolean`


##### `public email` → `String`


##### `public name` → `String`


##### `public queueMembers` → `MetadataService`


##### `public queueRoutingConfig` → `String`


##### `public queueSobject` → `MetadataService.QueueSobject`


##### `private doesSendEmailToMembers_type_info` → `String`


##### `private email_type_info` → `String`


##### `private name_type_info` → `String`


##### `private queueMembers_type_info` → `String`


##### `private queueRoutingConfig_type_info` → `String`


##### `private queueSobject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CleanDataService
#### Fields

##### `public cleanRules` → `MetadataService.CleanRule`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public matchEngine` → `String`


##### `private cleanRules_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private matchEngine_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### HomePageLayout

**Inheritance**

HomePageLayout

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public narrowComponents` → `String`


##### `public wideComponents` → `String`


##### `private narrowComponents_type_info` → `String`


##### `private wideComponents_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveLens

**Inheritance**

WaveLens

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public application` → `String`


##### `public datasets` → `String`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public templateAssetSourceName` → `String`


##### `public visualizationType` → `String`


##### `private application_type_info` → `String`


##### `private datasets_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private templateAssetSourceName_type_info` → `String`


##### `private visualizationType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionSendEmailOptions
#### Fields

##### `public defaultEmailTemplateName` → `String`


##### `public ignoreDefaultEmailTemplateSubject` → `Boolean`


##### `private defaultEmailTemplateName_type_info` → `String`


##### `private ignoreDefaultEmailTemplateSubject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowCategoryItems
#### Fields

##### `public flow` → `String`


##### `private flow_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppPreferences
#### Fields

##### `public enableCustomizeMyTabs` → `Boolean`


##### `public enableKeyboardShortcuts` → `Boolean`


##### `public enableListViewHover` → `Boolean`


##### `public enableListViewReskin` → `Boolean`


##### `public enableMultiMonitorComponents` → `Boolean`


##### `public enablePinTabs` → `Boolean`


##### `public enableTabHover` → `Boolean`


##### `public enableTabLimits` → `Boolean`


##### `public saveUserSessions` → `Boolean`


##### `private enableCustomizeMyTabs_type_info` → `String`


##### `private enableKeyboardShortcuts_type_info` → `String`


##### `private enableListViewHover_type_info` → `String`


##### `private enableListViewReskin_type_info` → `String`


##### `private enableMultiMonitorComponents_type_info` → `String`


##### `private enablePinTabs_type_info` → `String`


##### `private enableTabHover_type_info` → `String`


##### `private enableTabLimits_type_info` → `String`


##### `private saveUserSessions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SocialCustomerServiceSettings

**Inheritance**

SocialCustomerServiceSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public caseSubjectOption` → `String`


##### `private caseSubjectOption_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### MilestoneType

**Inheritance**

MilestoneType

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public recurrenceType` → `String`


##### `private description_type_info` → `String`


##### `private recurrenceType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WeightedSourceCategory
#### Fields

##### `public sourceCategoryApiName` → `String`


##### `public weight` → `Double`


##### `private sourceCategoryApiName_type_info` → `String`


##### `private weight_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalProcess

**Inheritance**

ApprovalProcess

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public allowRecall` → `Boolean`


##### `public allowedSubmitters` → `MetadataService.ApprovalSubmitter`


##### `public approvalPageFields` → `MetadataService`


##### `public approvalStep` → `MetadataService.ApprovalStep`


##### `public description` → `String`


##### `public emailTemplate` → `String`


##### `public enableMobileDeviceAccess` → `Boolean`


##### `public entryCriteria` → `MetadataService`


##### `public finalApprovalActions` → `MetadataService`


##### `public finalApprovalRecordLock` → `Boolean`


##### `public finalRejectionActions` → `MetadataService`


##### `public finalRejectionRecordLock` → `Boolean`


##### `public initialSubmissionActions` → `MetadataService`


##### `public label` → `String`


##### `public nextAutomatedApprover` → `MetadataService`


##### `public postTemplate` → `String`


##### `public recallActions` → `MetadataService`


##### `public recordEditability` → `String`


##### `public showApprovalHistory` → `Boolean`


##### `private active_type_info` → `String`


##### `private allowRecall_type_info` → `String`


##### `private allowedSubmitters_type_info` → `String`


##### `private approvalPageFields_type_info` → `String`


##### `private approvalStep_type_info` → `String`


##### `private description_type_info` → `String`


##### `private emailTemplate_type_info` → `String`


##### `private enableMobileDeviceAccess_type_info` → `String`


##### `private entryCriteria_type_info` → `String`


##### `private finalApprovalActions_type_info` → `String`


##### `private finalApprovalRecordLock_type_info` → `String`


##### `private finalRejectionActions_type_info` → `String`


##### `private finalRejectionRecordLock_type_info` → `String`


##### `private initialSubmissionActions_type_info` → `String`


##### `private label_type_info` → `String`


##### `private nextAutomatedApprover_type_info` → `String`


##### `private postTemplate_type_info` → `String`


##### `private recallActions_type_info` → `String`


##### `private recordEditability_type_info` → `String`


##### `private showApprovalHistory_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmbeddedServiceQuickAction
#### Fields

##### `public embeddedServiceLiveAgent` → `String`


##### `public order` → `Integer`


##### `public quickActionDefinition` → `String`


##### `private embeddedServiceLiveAgent_type_info` → `String`


##### `private order_type_info` → `String`


##### `private quickActionDefinition_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EntitlementProcess

**Inheritance**

EntitlementProcess

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public SObjectType` → `String`


##### `public active` → `Boolean`


##### `public businessHours` → `String`


##### `public description` → `String`


##### `public entryStartDateField` → `String`


##### `public exitCriteriaBooleanFilter` → `String`


##### `public exitCriteriaFilterItems` → `MetadataService.FilterItem`


##### `public exitCriteriaFormula` → `String`


##### `public isRecordTypeApplied` → `Boolean`


##### `public isVersionDefault` → `Boolean`


##### `public milestones` → `MetadataService.EntitlementProcessMilestoneItem`


##### `public name` → `String`


##### `public recordType` → `String`


##### `public versionMaster` → `String`


##### `public versionNotes` → `String`


##### `public versionNumber` → `Integer`


##### `private SObjectType_type_info` → `String`


##### `private active_type_info` → `String`


##### `private businessHours_type_info` → `String`


##### `private description_type_info` → `String`


##### `private entryStartDateField_type_info` → `String`


##### `private exitCriteriaBooleanFilter_type_info` → `String`


##### `private exitCriteriaFilterItems_type_info` → `String`


##### `private exitCriteriaFormula_type_info` → `String`


##### `private isRecordTypeApplied_type_info` → `String`


##### `private isVersionDefault_type_info` → `String`


##### `private milestones_type_info` → `String`


##### `private name_type_info` → `String`


##### `private recordType_type_info` → `String`


##### `private versionMaster_type_info` → `String`


##### `private versionNotes_type_info` → `String`


##### `private versionNumber_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowRecordDelete

**Inheritance**

FlowRecordDelete

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public connector` → `MetadataService`


##### `public faultConnector` → `MetadataService`


##### `public filters` → `MetadataService.FlowRecordFilter`


##### `public inputReference` → `String`


##### `public object_x` → `String`


##### `private connector_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private filters_type_info` → `String`


##### `private inputReference_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenFieldTranslation
#### Fields

##### `public fieldText` → `String`


##### `public helpText` → `String`


##### `public name` → `String`


##### `public validationRule` → `MetadataService`


##### `private fieldText_type_info` → `String`


##### `private helpText_type_info` → `String`


##### `private name_type_info` → `String`


##### `private validationRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApexTestSuite

**Inheritance**

ApexTestSuite

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public testClassName` → `String`


##### `private testClassName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### GlobalQuickActionTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Holiday
#### Fields

##### `public activityDate` → `Date`


##### `public businessHours` → `String`


##### `public description` → `String`


##### `public endTime` → `DateTime`


##### `public isRecurring` → `Boolean`


##### `public name` → `String`


##### `public recurrenceDayOfMonth` → `Integer`


##### `public recurrenceDayOfWeek` → `String`


##### `public recurrenceDayOfWeekMask` → `Integer`


##### `public recurrenceEndDate` → `Date`


##### `public recurrenceInstance` → `String`


##### `public recurrenceInterval` → `Integer`


##### `public recurrenceMonthOfYear` → `String`


##### `public recurrenceStartDate` → `Date`


##### `public recurrenceType` → `String`


##### `public startTime` → `DateTime`


##### `private activityDate_type_info` → `String`


##### `private businessHours_type_info` → `String`


##### `private description_type_info` → `String`


##### `private endTime_type_info` → `String`


##### `private isRecurring_type_info` → `String`


##### `private name_type_info` → `String`


##### `private recurrenceDayOfMonth_type_info` → `String`


##### `private recurrenceDayOfWeek_type_info` → `String`


##### `private recurrenceDayOfWeekMask_type_info` → `String`


##### `private recurrenceEndDate_type_info` → `String`


##### `private recurrenceInstance_type_info` → `String`


##### `private recurrenceInterval_type_info` → `String`


##### `private recurrenceMonthOfYear_type_info` → `String`


##### `private recurrenceStartDate_type_info` → `String`


##### `private recurrenceType_type_info` → `String`


##### `private startTime_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Layout

**Inheritance**

Layout

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public customButtons` → `String`


##### `public customConsoleComponents` → `MetadataService`


##### `public emailDefault` → `Boolean`


##### `public excludeButtons` → `String`


##### `public feedLayout` → `MetadataService`


##### `public headers` → `String`


##### `public layoutSections` → `MetadataService.LayoutSection`


##### `public miniLayout` → `MetadataService`


##### `public multilineLayoutFields` → `String`


##### `public platformActionList` → `MetadataService`


##### `public quickActionList` → `MetadataService`


##### `public relatedContent` → `MetadataService`


##### `public relatedLists` → `MetadataService.RelatedListItem`


##### `public relatedObjects` → `String`


##### `public runAssignmentRulesDefault` → `Boolean`


##### `public showEmailCheckbox` → `Boolean`


##### `public showHighlightsPanel` → `Boolean`


##### `public showInteractionLogPanel` → `Boolean`


##### `public showKnowledgeComponent` → `Boolean`


##### `public showRunAssignmentRulesCheckbox` → `Boolean`


##### `public showSolutionSection` → `Boolean`


##### `public showSubmitAndAttachButton` → `Boolean`


##### `public summaryLayout` → `MetadataService`


##### `private customButtons_type_info` → `String`


##### `private customConsoleComponents_type_info` → `String`


##### `private emailDefault_type_info` → `String`


##### `private excludeButtons_type_info` → `String`


##### `private feedLayout_type_info` → `String`


##### `private headers_type_info` → `String`


##### `private layoutSections_type_info` → `String`


##### `private miniLayout_type_info` → `String`


##### `private multilineLayoutFields_type_info` → `String`


##### `private platformActionList_type_info` → `String`


##### `private quickActionList_type_info` → `String`


##### `private relatedContent_type_info` → `String`


##### `private relatedLists_type_info` → `String`


##### `private relatedObjects_type_info` → `String`


##### `private runAssignmentRulesDefault_type_info` → `String`


##### `private showEmailCheckbox_type_info` → `String`


##### `private showHighlightsPanel_type_info` → `String`


##### `private showInteractionLogPanel_type_info` → `String`


##### `private showKnowledgeComponent_type_info` → `String`


##### `private showRunAssignmentRulesCheckbox_type_info` → `String`


##### `private showSolutionSection_type_info` → `String`


##### `private showSubmitAndAttachButton_type_info` → `String`


##### `private summaryLayout_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveChatButton

**Inheritance**

LiveChatButton

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public animation` → `String`


##### `public autoGreeting` → `String`


##### `public chasitorIdleTimeout` → `Integer`


##### `public chasitorIdleTimeoutWarning` → `Integer`


##### `public chatPage` → `String`


##### `public customAgentName` → `String`


##### `public deployments` → `MetadataService`


##### `public enableQueue` → `Boolean`


##### `public inviteEndPosition` → `String`


##### `public inviteImage` → `String`


##### `public inviteStartPosition` → `String`


##### `public isActive` → `Boolean`


##### `public label` → `String`


##### `public numberOfReroutingAttempts` → `Integer`


##### `public offlineImage` → `String`


##### `public onlineImage` → `String`


##### `public optionsCustomRoutingIsEnabled` → `Boolean`


##### `public optionsHasChasitorIdleTimeout` → `Boolean`


##### `public optionsHasInviteAfterAccept` → `Boolean`


##### `public optionsHasInviteAfterReject` → `Boolean`


##### `public optionsHasRerouteDeclinedRequest` → `Boolean`


##### `public optionsIsAutoAccept` → `Boolean`


##### `public optionsIsInviteAutoRemove` → `Boolean`


##### `public overallQueueLength` → `Integer`


##### `public perAgentQueueLength` → `Integer`


##### `public postChatPage` → `String`


##### `public postChatUrl` → `String`


##### `public preChatFormPage` → `String`


##### `public preChatFormUrl` → `String`


##### `public pushTimeOut` → `Integer`


##### `public routingType` → `String`


##### `public site` → `String`


##### `public skills` → `MetadataService`


##### `public timeToRemoveInvite` → `Integer`


##### `public type_x` → `String`


##### `public windowLanguage` → `String`


##### `private animation_type_info` → `String`


##### `private autoGreeting_type_info` → `String`


##### `private chasitorIdleTimeout_type_info` → `String`


##### `private chasitorIdleTimeoutWarning_type_info` → `String`


##### `private chatPage_type_info` → `String`


##### `private customAgentName_type_info` → `String`


##### `private deployments_type_info` → `String`


##### `private enableQueue_type_info` → `String`


##### `private inviteEndPosition_type_info` → `String`


##### `private inviteImage_type_info` → `String`


##### `private inviteStartPosition_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private label_type_info` → `String`


##### `private numberOfReroutingAttempts_type_info` → `String`


##### `private offlineImage_type_info` → `String`


##### `private onlineImage_type_info` → `String`


##### `private optionsCustomRoutingIsEnabled_type_info` → `String`


##### `private optionsHasChasitorIdleTimeout_type_info` → `String`


##### `private optionsHasInviteAfterAccept_type_info` → `String`


##### `private optionsHasInviteAfterReject_type_info` → `String`


##### `private optionsHasRerouteDeclinedRequest_type_info` → `String`


##### `private optionsIsAutoAccept_type_info` → `String`


##### `private optionsIsInviteAutoRemove_type_info` → `String`


##### `private overallQueueLength_type_info` → `String`


##### `private perAgentQueueLength_type_info` → `String`


##### `private postChatPage_type_info` → `String`


##### `private postChatUrl_type_info` → `String`


##### `private preChatFormPage_type_info` → `String`


##### `private preChatFormUrl_type_info` → `String`


##### `private pushTimeOut_type_info` → `String`


##### `private routingType_type_info` → `String`


##### `private site_type_info` → `String`


##### `private skills_type_info` → `String`


##### `private timeToRemoveInvite_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private windowLanguage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowDefinitionTranslation
#### Fields

##### `public flows` → `MetadataService.FlowTranslation`


##### `public fullName` → `String`


##### `public label` → `String`


##### `private flows_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2SettingsOpportunityFilter
#### Fields

##### `public apexClassName` → `String`


##### `public enableFilter` → `Boolean`


##### `public runOnCreate` → `Boolean`


##### `private apexClassName_type_info` → `String`


##### `private enableFilter_type_info` → `String`


##### `private runOnCreate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ActivitiesSettings

**Inheritance**

ActivitiesSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public allowUsersToRelateMultipleContactsToTasksAndEvents` → `Boolean`


##### `public autoRelateEventAttendees` → `Boolean`


##### `public enableActivityReminders` → `Boolean`


##### `public enableClickCreateEvents` → `Boolean`


##### `public enableDragAndDropScheduling` → `Boolean`


##### `public enableEmailTracking` → `Boolean`


##### `public enableGroupTasks` → `Boolean`


##### `public enableListViewScheduling` → `Boolean`


##### `public enableLogNote` → `Boolean`


##### `public enableMultidayEvents` → `Boolean`


##### `public enableRecurringEvents` → `Boolean`


##### `public enableRecurringTasks` → `Boolean`


##### `public enableSidebarCalendarShortcut` → `Boolean`


##### `public enableSimpleTaskCreateUI` → `Boolean`


##### `public enableUNSTaskDelegatedToNotifications` → `Boolean`


##### `public meetingRequestsLogo` → `String`


##### `public showCustomLogoMeetingRequests` → `Boolean`


##### `public showEventDetailsMultiUserCalendar` → `Boolean`


##### `public showHomePageHoverLinksForEvents` → `Boolean`


##### `public showMyTasksHoverLinks` → `Boolean`


##### `private allowUsersToRelateMultipleContactsToTasksAndEvents_type_info` → `String`


##### `private autoRelateEventAttendees_type_info` → `String`


##### `private enableActivityReminders_type_info` → `String`


##### `private enableClickCreateEvents_type_info` → `String`


##### `private enableDragAndDropScheduling_type_info` → `String`


##### `private enableEmailTracking_type_info` → `String`


##### `private enableGroupTasks_type_info` → `String`


##### `private enableListViewScheduling_type_info` → `String`


##### `private enableLogNote_type_info` → `String`


##### `private enableMultidayEvents_type_info` → `String`


##### `private enableRecurringEvents_type_info` → `String`


##### `private enableRecurringTasks_type_info` → `String`


##### `private enableSidebarCalendarShortcut_type_info` → `String`


##### `private enableSimpleTaskCreateUI_type_info` → `String`


##### `private enableUNSTaskDelegatedToNotifications_type_info` → `String`


##### `private meetingRequestsLogo_type_info` → `String`


##### `private showCustomLogoMeetingRequests_type_info` → `String`


##### `private showEventDetailsMultiUserCalendar_type_info` → `String`


##### `private showHomePageHoverLinksForEvents_type_info` → `String`


##### `private showMyTasksHoverLinks_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowWaitEvent

**Inheritance**

FlowWaitEvent

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public conditionLogic` → `String`


##### `public conditions` → `MetadataService.FlowCondition`


##### `public connector` → `MetadataService`


##### `public eventType` → `String`


##### `public inputParameters` → `MetadataService.FlowWaitEventInputParameter`


##### `public label` → `String`


##### `public outputParameters` → `MetadataService.FlowWaitEventOutputParameter`


##### `private conditionLogic_type_info` → `String`


##### `private conditions_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private eventType_type_info` → `String`


##### `private inputParameters_type_info` → `String`


##### `private label_type_info` → `String`


##### `private outputParameters_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApexComponent

**Inheritance**

ApexComponent

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public apiVersion` → `Double`


##### `public description` → `String`


##### `public label` → `String`


##### `public packageVersions` → `MetadataService.PackageVersion`


##### `private apiVersion_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private packageVersions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### StrategyNode
#### Fields

##### `public definition` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `public parentNode` → `String`


##### `public type_x` → `Integer`


##### `private definition_type_info` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `private parentNode_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AutoResponseRule

**Inheritance**

AutoResponseRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public ruleEntry` → `MetadataService.RuleEntry`


##### `private active_type_info` → `String`


##### `private ruleEntry_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### NamedCredential

**Inheritance**

NamedCredential

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public allowMergeFieldsInBody` → `Boolean`


##### `public allowMergeFieldsInHeader` → `Boolean`


##### `public authProvider` → `String`


##### `public certificate` → `String`


##### `public endpoint` → `String`


##### `public generateAuthorizationHeader` → `Boolean`


##### `public label` → `String`


##### `public oauthRefreshToken` → `String`


##### `public oauthScope` → `String`


##### `public oauthToken` → `String`


##### `public password` → `String`


##### `public principalType` → `String`


##### `public protocol` → `String`


##### `public username` → `String`


##### `private allowMergeFieldsInBody_type_info` → `String`


##### `private allowMergeFieldsInHeader_type_info` → `String`


##### `private authProvider_type_info` → `String`


##### `private certificate_type_info` → `String`


##### `private endpoint_type_info` → `String`


##### `private generateAuthorizationHeader_type_info` → `String`


##### `private label_type_info` → `String`


##### `private oauthRefreshToken_type_info` → `String`


##### `private oauthScope_type_info` → `String`


##### `private oauthToken_type_info` → `String`


##### `private password_type_info` → `String`


##### `private principalType_type_info` → `String`


##### `private protocol_type_info` → `String`


##### `private username_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickAction

**Inheritance**

QuickAction

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public canvas` → `String`


##### `public description` → `String`


##### `public fieldOverrides` → `MetadataService.FieldOverride`


##### `public flowDefinition` → `String`


##### `public height` → `Integer`


##### `public icon` → `String`


##### `public isProtected` → `Boolean`


##### `public label` → `String`


##### `public lightningComponent` → `String`


##### `public optionsCreateFeedItem` → `Boolean`


##### `public page_x` → `String`


##### `public quickActionLayout` → `MetadataService`


##### `public quickActionSendEmailOptions` → `MetadataService`


##### `public standardLabel` → `String`


##### `public successMessage` → `String`


##### `public targetObject` → `String`


##### `public targetParentField` → `String`


##### `public targetRecordType` → `String`


##### `public type_x` → `String`


##### `public width` → `Integer`


##### `private canvas_type_info` → `String`


##### `private description_type_info` → `String`


##### `private fieldOverrides_type_info` → `String`


##### `private flowDefinition_type_info` → `String`


##### `private height_type_info` → `String`


##### `private icon_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private label_type_info` → `String`


##### `private lightningComponent_type_info` → `String`


##### `private optionsCreateFeedItem_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private quickActionLayout_type_info` → `String`


##### `private quickActionSendEmailOptions_type_info` → `String`


##### `private standardLabel_type_info` → `String`


##### `private successMessage_type_info` → `String`


##### `private targetObject_type_info` → `String`


##### `private targetParentField_type_info` → `String`


##### `private targetRecordType_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingCriteriaRule

**Inheritance**

SharingCriteriaRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessLevel` → `String`


##### `public accountSettings` → `MetadataService`


##### `public description` → `String`


##### `public label` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessLevel_type_info` → `String`


##### `private accountSettings_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `public booleanFilter` → `String`


##### `public criteriaItems` → `MetadataService.FilterItem`


##### `private booleanFilter_type_info` → `String`


##### `private criteriaItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowAssignment

**Inheritance**

FlowAssignment

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public assignmentItems` → `MetadataService.FlowAssignmentItem`


##### `public connector` → `MetadataService`


##### `private assignmentItems_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### MatchingRules

**Inheritance**

MatchingRules

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public matchingRules` → `MetadataService.MatchingRule`


##### `private matchingRules_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Index
#### Fields

##### `public fields` → `MetadataService.IndexField`


##### `public label` → `String`


##### `private fields_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Attachment
#### Fields

##### `public content` → `String`


##### `public name` → `String`


##### `private content_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PathAssistantStep
#### Fields

##### `public fieldNames` → `String`


##### `public info` → `String`


##### `public picklistValueName` → `String`


##### `private fieldNames_type_info` → `String`


##### `private info_type_info` → `String`


##### `private picklistValueName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChannelLayoutItem
#### Fields

##### `public field` → `String`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomValue

**Inheritance**

CustomValue

#### Fields

##### `public color` → `String`


##### `public default_x` → `Boolean`


##### `public description` → `String`


##### `public isActive` → `Boolean`


##### `public label` → `String`


---

### ListView

**Inheritance**

ListView

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public booleanFilter` → `String`


##### `public columns` → `String`


##### `public division` → `String`


##### `public filterScope` → `String`


##### `public filters` → `MetadataService.ListViewFilter`


##### `public label` → `String`


##### `public language` → `String`


##### `public queue` → `String`


##### `public sharedTo` → `MetadataService`


##### `private booleanFilter_type_info` → `String`


##### `private columns_type_info` → `String`


##### `private division_type_info` → `String`


##### `private filterScope_type_info` → `String`


##### `private filters_type_info` → `String`


##### `private label_type_info` → `String`


##### `private language_type_info` → `String`


##### `private queue_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomApplicationTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeCaseSettings
#### Fields

##### `public articlePDFCreationProfile` → `String`


##### `public articlePublicSharingCommunities` → `MetadataService`


##### `public articlePublicSharingSites` → `MetadataService`


##### `public articlePublicSharingSitesChatterAnswers` → `MetadataService`


##### `public assignTo` → `String`


##### `public customizationClass` → `String`


##### `public defaultContributionArticleType` → `String`


##### `public editor` → `String`


##### `public enableArticleCreation` → `Boolean`


##### `public enableArticlePublicSharingSites` → `Boolean`


##### `public enableCaseDataCategoryMapping` → `Boolean`


##### `public useProfileForPDFCreation` → `Boolean`


##### `private articlePDFCreationProfile_type_info` → `String`


##### `private articlePublicSharingCommunities_type_info` → `String`


##### `private articlePublicSharingSites_type_info` → `String`


##### `private articlePublicSharingSitesChatterAnswers_type_info` → `String`


##### `private assignTo_type_info` → `String`


##### `private customizationClass_type_info` → `String`


##### `private defaultContributionArticleType_type_info` → `String`


##### `private editor_type_info` → `String`


##### `private enableArticleCreation_type_info` → `String`


##### `private enableArticlePublicSharingSites_type_info` → `String`


##### `private enableCaseDataCategoryMapping_type_info` → `String`


##### `private useProfileForPDFCreation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FiscalYearSettings
#### Fields

##### `public fiscalYearNameBasedOn` → `String`


##### `public startMonth` → `String`


##### `private fiscalYearNameBasedOn_type_info` → `String`


##### `private startMonth_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Approver
#### Fields

##### `public name` → `String`


##### `public type_x` → `String`


##### `private name_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ObjectNameCaseValue
#### Fields

##### `public article` → `String`


##### `public caseType` → `String`


##### `public plural` → `Boolean`


##### `public possessive` → `String`


##### `public value` → `String`


##### `private article_type_info` → `String`


##### `private caseType_type_info` → `String`


##### `private plural_type_info` → `String`


##### `private possessive_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SiteWebAddress
#### Fields

##### `public certificate` → `String`


##### `public domainName` → `String`


##### `public primary` → `Boolean`


##### `private certificate_type_info` → `String`


##### `private domainName_type_info` → `String`


##### `private primary_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowInputValidationRule
#### Fields

##### `public errorMessage` → `String`


##### `public formulaExpression` → `String`


##### `private errorMessage_type_info` → `String`


##### `private formulaExpression_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CompanySettings

**Inheritance**

CompanySettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public fiscalYear` → `MetadataService`


##### `private fiscalYear_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenField

**Inheritance**

FlowScreenField

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public choiceReferences` → `String`


##### `public dataType` → `String`


##### `public defaultSelectedChoiceReference` → `String`


##### `public defaultValue` → `MetadataService`


##### `public extensionName` → `String`


##### `public fieldText` → `String`


##### `public fieldType` → `String`


##### `public helpText` → `String`


##### `public inputParameters` → `MetadataService.FlowScreenFieldInputParameter`


##### `public isRequired` → `Boolean`


##### `public isVisible` → `Boolean`


##### `public outputParameters` → `MetadataService.FlowScreenFieldOutputParameter`


##### `public scale` → `Integer`


##### `public validationRule` → `MetadataService`


##### `private choiceReferences_type_info` → `String`


##### `private dataType_type_info` → `String`


##### `private defaultSelectedChoiceReference_type_info` → `String`


##### `private defaultValue_type_info` → `String`


##### `private extensionName_type_info` → `String`


##### `private fieldText_type_info` → `String`


##### `private fieldType_type_info` → `String`


##### `private helpText_type_info` → `String`


##### `private inputParameters_type_info` → `String`


##### `private isRequired_type_info` → `String`


##### `private isVisible_type_info` → `String`


##### `private outputParameters_type_info` → `String`


##### `private scale_type_info` → `String`


##### `private validationRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LookupFilterTranslation
#### Fields

##### `public errorMessage` → `String`


##### `public informationalMessage` → `String`


##### `private errorMessage_type_info` → `String`


##### `private informationalMessage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LetterheadLine
#### Fields

##### `public color` → `String`


##### `public height` → `Integer`


##### `private color_type_info` → `String`


##### `private height_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValidationRule

**Inheritance**

ValidationRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public description` → `String`


##### `public errorConditionFormula` → `String`


##### `public errorDisplayField` → `String`


##### `public errorMessage` → `String`


##### `private active_type_info` → `String`


##### `private description_type_info` → `String`


##### `private errorConditionFormula_type_info` → `String`


##### `private errorDisplayField_type_info` → `String`


##### `private errorMessage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChatterAnswersReputationLevel
#### Fields

##### `public name` → `String`


##### `public value` → `Integer`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Role
#### Fields

##### `public parentRole` → `String`


##### `private parentRole_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdDate
#### Fields

##### `public alias` → `String`


##### `public compact` → `Boolean`


##### `public dateFieldDay` → `String`


##### `public dateFieldEpochDay` → `String`


##### `public dateFieldEpochSecond` → `String`


##### `public dateFieldFiscalMonth` → `String`


##### `public dateFieldFiscalQuarter` → `String`


##### `public dateFieldFiscalWeek` → `String`


##### `public dateFieldFiscalYear` → `String`


##### `public dateFieldFullYear` → `String`


##### `public dateFieldHour` → `String`


##### `public dateFieldMinute` → `String`


##### `public dateFieldMonth` → `String`


##### `public dateFieldQuarter` → `String`


##### `public dateFieldSecond` → `String`


##### `public dateFieldWeek` → `String`


##### `public dateFieldYear` → `String`


##### `public description` → `String`


##### `public firstDayOfWeek` → `Integer`


##### `public fiscalMonthOffset` → `Integer`


##### `public isYearEndFiscalYear` → `Boolean`


##### `public label` → `String`


##### `public showInExplorer` → `Boolean`


##### `public sortIndex` → `Integer`


##### `private alias_type_info` → `String`


##### `private compact_type_info` → `String`


##### `private dateFieldDay_type_info` → `String`


##### `private dateFieldEpochDay_type_info` → `String`


##### `private dateFieldEpochSecond_type_info` → `String`


##### `private dateFieldFiscalMonth_type_info` → `String`


##### `private dateFieldFiscalQuarter_type_info` → `String`


##### `private dateFieldFiscalWeek_type_info` → `String`


##### `private dateFieldFiscalYear_type_info` → `String`


##### `private dateFieldFullYear_type_info` → `String`


##### `private dateFieldHour_type_info` → `String`


##### `private dateFieldMinute_type_info` → `String`


##### `private dateFieldMonth_type_info` → `String`


##### `private dateFieldQuarter_type_info` → `String`


##### `private dateFieldSecond_type_info` → `String`


##### `private dateFieldWeek_type_info` → `String`


##### `private dateFieldYear_type_info` → `String`


##### `private description_type_info` → `String`


##### `private firstDayOfWeek_type_info` → `String`


##### `private fiscalMonthOffset_type_info` → `String`


##### `private isYearEndFiscalYear_type_info` → `String`


##### `private label_type_info` → `String`


##### `private showInExplorer_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PublicGroups
#### Fields

##### `public publicGroup` → `String`


##### `private publicGroup_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FeedLayoutFilter
#### Fields

##### `public feedFilterName` → `String`


##### `public feedFilterType` → `String`


##### `public feedItemType` → `String`


##### `private feedFilterName_type_info` → `String`


##### `private feedFilterType_type_info` → `String`


##### `private feedItemType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowAction

**Inheritance**

WorkflowAction


### State
#### Fields

##### `public active` → `Boolean`


##### `public integrationValue` → `String`


##### `public isoCode` → `String`


##### `public label` → `String`


##### `public standard` → `Boolean`


##### `public visible` → `Boolean`


##### `private active_type_info` → `String`


##### `private integrationValue_type_info` → `String`


##### `private isoCode_type_info` → `String`


##### `private label_type_info` → `String`


##### `private standard_type_info` → `String`


##### `private visible_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SupervisorAgentConfigSkills
#### Fields

##### `public skill` → `String`


##### `private skill_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### describeValueTypeResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ActionOverride
#### Fields

##### `public actionName` → `String`


##### `public comment` → `String`


##### `public content` → `String`


##### `public formFactor` → `String`


##### `public skipRecordTypeSelect` → `Boolean`


##### `public type_x` → `String`


##### `private actionName_type_info` → `String`


##### `private comment_type_info` → `String`


##### `private content_type_info` → `String`


##### `private formFactor_type_info` → `String`


##### `private skipRecordTypeSelect_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Translations

**Inheritance**

Translations

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public customApplications` → `MetadataService.CustomApplicationTranslation`


##### `public customDataTypeTranslations` → `MetadataService.CustomDataTypeTranslation`


##### `public customLabels` → `MetadataService.CustomLabelTranslation`


##### `public customPageWebLinks` → `MetadataService.CustomPageWebLinkTranslation`


##### `public customTabs` → `MetadataService.CustomTabTranslation`


##### `public flowDefinitions` → `MetadataService.FlowDefinitionTranslation`


##### `public quickActions` → `MetadataService.GlobalQuickActionTranslation`


##### `public reportTypes` → `MetadataService.ReportTypeTranslation`


##### `public scontrols` → `MetadataService.ScontrolTranslation`


##### `private customApplications_type_info` → `String`


##### `private customDataTypeTranslations_type_info` → `String`


##### `private customLabels_type_info` → `String`


##### `private customPageWebLinks_type_info` → `String`


##### `private customTabs_type_info` → `String`


##### `private flowDefinitions_type_info` → `String`


##### `private quickActions_type_info` → `String`


##### `private reportTypes_type_info` → `String`


##### `private scontrols_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WebToCaseSettings
#### Fields

##### `public caseOrigin` → `String`


##### `public defaultResponseTemplate` → `String`


##### `public enableWebToCase` → `Boolean`


##### `private caseOrigin_type_info` → `String`


##### `private defaultResponseTemplate_type_info` → `String`


##### `private enableWebToCase_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomMetadata

**Inheritance**

CustomMetadata

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public protected_x` → `Boolean`


##### `public values` → `MetadataService.CustomMetadataValue`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private values_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowNode

**Inheritance**

FlowNode

#### Fields

##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


---

### FileProperties
#### Fields

##### `public createdById` → `String`


##### `public createdByName` → `String`


##### `public createdDate` → `DateTime`


##### `public fileName` → `String`


##### `public fullName` → `String`


##### `public id` → `String`


##### `public lastModifiedById` → `String`


##### `public lastModifiedByName` → `String`


##### `public lastModifiedDate` → `DateTime`


##### `public manageableState` → `String`


##### `public namespacePrefix` → `String`


##### `public type_x` → `String`


##### `private createdById_type_info` → `String`


##### `private createdByName_type_info` → `String`


##### `private createdDate_type_info` → `String`


##### `private fileName_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private id_type_info` → `String`


##### `private lastModifiedById_type_info` → `String`


##### `private lastModifiedByName_type_info` → `String`


##### `private lastModifiedDate_type_info` → `String`


##### `private manageableState_type_info` → `String`


##### `private namespacePrefix_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OrderSettings

**Inheritance**

OrderSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableNegativeQuantity` → `Boolean`


##### `public enableOrders` → `Boolean`


##### `public enableReductionOrders` → `Boolean`


##### `public enableZeroQuantity` → `Boolean`


##### `private enableNegativeQuantity_type_info` → `String`


##### `private enableOrders_type_info` → `String`


##### `private enableReductionOrders_type_info` → `String`


##### `private enableZeroQuantity_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportTimeFrameFilter
#### Fields

##### `public dateColumn` → `String`


##### `public endDate` → `Date`


##### `public interval` → `String`


##### `public startDate` → `Date`


##### `private dateColumn_type_info` → `String`


##### `private endDate_type_info` → `String`


##### `private interval_type_info` → `String`


##### `private startDate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ContentAssetLink
#### Fields

##### `public access` → `String`


##### `public isManagingWorkspace` → `Boolean`


##### `public name` → `String`


##### `private access_type_info` → `String`


##### `private isManagingWorkspace_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### StandardValue

**Inheritance**

StandardValue

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public color` → `String`


##### `public default_x` → `Boolean`


##### `public description` → `String`


##### `public isActive` → `Boolean`


##### `public label` → `String`


##### `private color_type_info` → `String`


##### `private default_x_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private label_type_info` → `String`


##### `public allowEmail` → `Boolean`


##### `public closed` → `Boolean`


##### `public converted` → `Boolean`


##### `public cssExposed` → `Boolean`


##### `public forecastCategory` → `String`


##### `public groupingString` → `String`


##### `public highPriority` → `Boolean`


##### `public probability` → `Integer`


##### `public reverseRole` → `String`


##### `public reviewed` → `Boolean`


##### `public won` → `Boolean`


##### `private allowEmail_type_info` → `String`


##### `private closed_type_info` → `String`


##### `private converted_type_info` → `String`


##### `private cssExposed_type_info` → `String`


##### `private forecastCategory_type_info` → `String`


##### `private groupingString_type_info` → `String`


##### `private highPriority_type_info` → `String`


##### `private probability_type_info` → `String`


##### `private reverseRole_type_info` → `String`


##### `private reviewed_type_info` → `String`


##### `private won_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### NavigationSubMenu
#### Fields

##### `public navigationMenuItem` → `MetadataService.NavigationMenuItem`


##### `private navigationMenuItem_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProductSettings

**Inheritance**

ProductSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableCascadeActivateToRelatedPrices` → `Boolean`


##### `public enableQuantitySchedule` → `Boolean`


##### `public enableRevenueSchedule` → `Boolean`


##### `private enableCascadeActivateToRelatedPrices_type_info` → `String`


##### `private enableQuantitySchedule_type_info` → `String`


##### `private enableRevenueSchedule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowTask

**Inheritance**

WorkflowTask

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public assignedTo` → `String`


##### `public assignedToType` → `String`


##### `public description` → `String`


##### `public dueDateOffset` → `Integer`


##### `public notifyAssignee` → `Boolean`


##### `public offsetFromField` → `String`


##### `public priority` → `String`


##### `public protected_x` → `Boolean`


##### `public status` → `String`


##### `public subject` → `String`


##### `private assignedTo_type_info` → `String`


##### `private assignedToType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private dueDateOffset_type_info` → `String`


##### `private notifyAssignee_type_info` → `String`


##### `private offsetFromField_type_info` → `String`


##### `private priority_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private status_type_info` → `String`


##### `private subject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### GlobalValueSetTranslation
#### Fields

##### `public valueTranslation` → `MetadataService.ValueTranslation`


##### `private valueTranslation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### deployResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FeedItemSettings
#### Fields

##### `public characterLimit` → `Integer`


##### `public collapseThread` → `Boolean`


##### `public displayFormat` → `String`


##### `public feedItemType` → `String`


##### `private characterLimit_type_info` → `String`


##### `private collapseThread_type_info` → `String`


##### `private displayFormat_type_info` → `String`


##### `private feedItemType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmbeddedServiceFieldService
#### Fields

##### `public appointmentBookingFlowName` → `String`


##### `public cancelApptBookingFlowName` → `String`


##### `public embeddedServiceConfig` → `String`


##### `public enabled` → `Boolean`


##### `public fieldServiceConfirmCardImg` → `String`


##### `public fieldServiceHomeImg` → `String`


##### `public fieldServiceLogoImg` → `String`


##### `public masterLabel` → `String`


##### `public modifyApptBookingFlowName` → `String`


##### `public shouldShowExistingAppointment` → `Boolean`


##### `public shouldShowNewAppointment` → `Boolean`


##### `private appointmentBookingFlowName_type_info` → `String`


##### `private cancelApptBookingFlowName_type_info` → `String`


##### `private embeddedServiceConfig_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private fieldServiceConfirmCardImg_type_info` → `String`


##### `private fieldServiceHomeImg_type_info` → `String`


##### `private fieldServiceLogoImg_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private modifyApptBookingFlowName_type_info` → `String`


##### `private shouldShowExistingAppointment_type_info` → `String`


##### `private shouldShowNewAppointment_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AgentConfigAssignments
#### Fields

##### `public profiles` → `MetadataService`


##### `public users` → `MetadataService`


##### `private profiles_type_info` → `String`


##### `private users_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalStepApprover
#### Fields

##### `public approver` → `MetadataService.Approver`


##### `public whenMultipleApprovers` → `String`


##### `private approver_type_info` → `String`


##### `private whenMultipleApprovers_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApexTrigger

**Inheritance**

ApexTrigger

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public apiVersion` → `Double`


##### `public packageVersions` → `MetadataService.PackageVersion`


##### `public status` → `String`


##### `private apiVersion_type_info` → `String`


##### `private packageVersions_type_info` → `String`


##### `private status_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomConsoleComponents
#### Fields

##### `public primaryTabComponents` → `MetadataService`


##### `public subtabComponents` → `MetadataService`


##### `private primaryTabComponents_type_info` → `String`


##### `private subtabComponents_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### TouchMobileSettings
#### Fields

##### `public enableTouchAppIPad` → `Boolean`


##### `public enableTouchAppIPhone` → `Boolean`


##### `public enableTouchBrowserIPad` → `Boolean`


##### `public enableTouchIosPhone` → `Boolean`


##### `public enableVisualforceInTouch` → `Boolean`


##### `private enableTouchAppIPad_type_info` → `String`


##### `private enableTouchAppIPhone_type_info` → `String`


##### `private enableTouchBrowserIPad_type_info` → `String`


##### `private enableTouchIosPhone_type_info` → `String`


##### `private enableVisualforceInTouch_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppMenu

**Inheritance**

AppMenu

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public appMenuItems` → `MetadataService.AppMenuItem`


##### `private appMenuItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DebuggingInfo_element
#### Fields

##### `public debugLog` → `String`


##### `private debugLog_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Report

**Inheritance**

Report

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public aggregates` → `MetadataService.ReportAggregate`


##### `public block` → `MetadataService.Report`


##### `public blockInfo` → `MetadataService`


##### `public buckets` → `MetadataService.ReportBucketField`


##### `public chart` → `MetadataService`


##### `public colorRanges` → `MetadataService.ReportColorRange`


##### `public columns` → `MetadataService.ReportColumn`


##### `public crossFilters` → `MetadataService.ReportCrossFilter`


##### `public currency_x` → `String`


##### `public dataCategoryFilters` → `MetadataService.ReportDataCategoryFilter`


##### `public description` → `String`


##### `public division` → `String`


##### `public filter` → `MetadataService`


##### `public folderName` → `String`


##### `public format` → `String`


##### `public groupingsAcross` → `MetadataService.ReportGrouping`


##### `public groupingsDown` → `MetadataService.ReportGrouping`


##### `public historicalSelector` → `MetadataService`


##### `public name` → `String`


##### `public numSubscriptions` → `Integer`


##### `public params` → `MetadataService.ReportParam`


##### `public reportType` → `String`


##### `public roleHierarchyFilter` → `String`


##### `public rowLimit` → `Integer`


##### `public scope` → `String`


##### `public showCurrentDate` → `Boolean`


##### `public showDetails` → `Boolean`


##### `public sortColumn` → `String`


##### `public sortOrder` → `String`


##### `public territoryHierarchyFilter` → `String`


##### `public timeFrameFilter` → `MetadataService`


##### `public userFilter` → `String`


##### `private aggregates_type_info` → `String`


##### `private block_type_info` → `String`


##### `private blockInfo_type_info` → `String`


##### `private buckets_type_info` → `String`


##### `private chart_type_info` → `String`


##### `private colorRanges_type_info` → `String`


##### `private columns_type_info` → `String`


##### `private crossFilters_type_info` → `String`


##### `private currency_x_type_info` → `String`


##### `private dataCategoryFilters_type_info` → `String`


##### `private description_type_info` → `String`


##### `private division_type_info` → `String`


##### `private filter_type_info` → `String`


##### `private folderName_type_info` → `String`


##### `private format_type_info` → `String`


##### `private groupingsAcross_type_info` → `String`


##### `private groupingsDown_type_info` → `String`


##### `private historicalSelector_type_info` → `String`


##### `private name_type_info` → `String`


##### `private numSubscriptions_type_info` → `String`


##### `private params_type_info` → `String`


##### `private reportType_type_info` → `String`


##### `private roleHierarchyFilter_type_info` → `String`


##### `private rowLimit_type_info` → `String`


##### `private scope_type_info` → `String`


##### `private showCurrentDate_type_info` → `String`


##### `private showDetails_type_info` → `String`


##### `private sortColumn_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private territoryHierarchyFilter_type_info` → `String`


##### `private timeFrameFilter_type_info` → `String`


##### `private userFilter_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeSettings

**Inheritance**

KnowledgeSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public answers` → `MetadataService`


##### `public cases` → `MetadataService`


##### `public defaultLanguage` → `String`


##### `public enableChatterQuestionKBDeflection` → `Boolean`


##### `public enableCreateEditOnArticlesTab` → `Boolean`


##### `public enableExternalMediaContent` → `Boolean`


##### `public enableKnowledge` → `Boolean`


##### `public enableLightningKnowledge` → `Boolean`


##### `public languages` → `MetadataService`


##### `public showArticleSummariesCustomerPortal` → `Boolean`


##### `public showArticleSummariesInternalApp` → `Boolean`


##### `public showArticleSummariesPartnerPortal` → `Boolean`


##### `public showValidationStatusField` → `Boolean`


##### `public suggestedArticles` → `MetadataService`


##### `private answers_type_info` → `String`


##### `private cases_type_info` → `String`


##### `private defaultLanguage_type_info` → `String`


##### `private enableChatterQuestionKBDeflection_type_info` → `String`


##### `private enableCreateEditOnArticlesTab_type_info` → `String`


##### `private enableExternalMediaContent_type_info` → `String`


##### `private enableKnowledge_type_info` → `String`


##### `private enableLightningKnowledge_type_info` → `String`


##### `private languages_type_info` → `String`


##### `private showArticleSummariesCustomerPortal_type_info` → `String`


##### `private showArticleSummariesInternalApp_type_info` → `String`


##### `private showArticleSummariesPartnerPortal_type_info` → `String`


##### `private showValidationStatusField_type_info` → `String`


##### `private suggestedArticles_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### StaticResource

**Inheritance**

StaticResource

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public cacheControl` → `String`


##### `public contentType` → `String`


##### `public description` → `String`


##### `private cacheControl_type_info` → `String`


##### `private contentType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportTypeColumn
#### Fields

##### `public checkedByDefault` → `Boolean`


##### `public displayNameOverride` → `String`


##### `public field` → `String`


##### `public table` → `String`


##### `private checkedByDefault_type_info` → `String`


##### `private displayNameOverride_type_info` → `String`


##### `private field_type_info` → `String`


##### `private table_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalStep
#### Fields

##### `public allowDelegate` → `Boolean`


##### `public approvalActions` → `MetadataService`


##### `public assignedApprover` → `MetadataService`


##### `public description` → `String`


##### `public entryCriteria` → `MetadataService`


##### `public ifCriteriaNotMet` → `String`


##### `public label` → `String`


##### `public name` → `String`


##### `public rejectBehavior` → `MetadataService`


##### `public rejectionActions` → `MetadataService`


##### `private allowDelegate_type_info` → `String`


##### `private approvalActions_type_info` → `String`


##### `private assignedApprover_type_info` → `String`


##### `private description_type_info` → `String`


##### `private entryCriteria_type_info` → `String`


##### `private ifCriteriaNotMet_type_info` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private rejectBehavior_type_info` → `String`


##### `private rejectionActions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecordTypeTranslation
#### Fields

##### `public description` → `String`


##### `public label` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowInputFieldAssignment

**Inheritance**

FlowInputFieldAssignment

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public field` → `String`


##### `public value` → `MetadataService`


##### `private field_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowActionReference
#### Fields

##### `public name` → `String`


##### `public type_x` → `String`


##### `private name_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FilterItem
#### Fields

##### `public field` → `String`


##### `public operation` → `String`


##### `public value` → `String`


##### `public valueField` → `String`


##### `private field_type_info` → `String`


##### `private operation_type_info` → `String`


##### `private value_type_info` → `String`


##### `private valueField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OpportunityListFieldsUnselectedSettings
#### Fields

##### `public field` → `String`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportChartComponentLayoutItem
#### Fields

##### `public cacheData` → `Boolean`


##### `public contextFilterableField` → `String`


##### `public error` → `String`


##### `public hideOnError` → `Boolean`


##### `public includeContext` → `Boolean`


##### `public reportName` → `String`


##### `public showTitle` → `Boolean`


##### `public size` → `String`


##### `private cacheData_type_info` → `String`


##### `private contextFilterableField_type_info` → `String`


##### `private error_type_info` → `String`


##### `private hideOnError_type_info` → `String`


##### `private includeContext_type_info` → `String`


##### `private reportName_type_info` → `String`


##### `private showTitle_type_info` → `String`


##### `private size_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### StandardValueSetTranslation
#### Fields

##### `public valueTranslation` → `MetadataService.ValueTranslation`


##### `private valueTranslation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### BrandingSet

**Inheritance**

BrandingSet

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public brandingSetProperty` → `MetadataService.BrandingSetProperty`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public type_x` → `String`


##### `private brandingSetProperty_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChatterAnswersSettings

**Inheritance**

ChatterAnswersSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public emailFollowersOnBestAnswer` → `Boolean`


##### `public emailFollowersOnReply` → `Boolean`


##### `public emailOwnerOnPrivateReply` → `Boolean`


##### `public emailOwnerOnReply` → `Boolean`


##### `public enableAnswerViaEmail` → `Boolean`


##### `public enableChatterAnswers` → `Boolean`


##### `public enableFacebookSSO` → `Boolean`


##### `public enableInlinePublisher` → `Boolean`


##### `public enableReputation` → `Boolean`


##### `public enableRichTextEditor` → `Boolean`


##### `public facebookAuthProvider` → `String`


##### `public showInPortals` → `Boolean`


##### `private emailFollowersOnBestAnswer_type_info` → `String`


##### `private emailFollowersOnReply_type_info` → `String`


##### `private emailOwnerOnPrivateReply_type_info` → `String`


##### `private emailOwnerOnReply_type_info` → `String`


##### `private enableAnswerViaEmail_type_info` → `String`


##### `private enableChatterAnswers_type_info` → `String`


##### `private enableFacebookSSO_type_info` → `String`


##### `private enableInlinePublisher_type_info` → `String`


##### `private enableReputation_type_info` → `String`


##### `private enableRichTextEditor_type_info` → `String`


##### `private facebookAuthProvider_type_info` → `String`


##### `private showInPortals_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppCanvasConfig
#### Fields

##### `public accessMethod` → `String`


##### `public canvasUrl` → `String`


##### `public lifecycleClass` → `String`


##### `public locations` → `String`


##### `public options` → `String`


##### `public samlInitiationMethod` → `String`


##### `private accessMethod_type_info` → `String`


##### `private canvasUrl_type_info` → `String`


##### `private lifecycleClass_type_info` → `String`


##### `private locations_type_info` → `String`


##### `private options_type_info` → `String`


##### `private samlInitiationMethod_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuotasSettings
#### Fields

##### `public showQuotas` → `Boolean`


##### `private showQuotas_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OrgPreferenceSettings

**Inheritance**

OrgPreferenceSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public preferences` → `MetadataService.OrganizationSettingsDetail`


##### `private preferences_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Community

**Inheritance**

Community

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public chatterAnswersFacebookSsoUrl` → `String`


##### `public communityFeedPage` → `String`


##### `public dataCategoryName` → `String`


##### `public description` → `String`


##### `public emailFooterDocument` → `String`


##### `public emailHeaderDocument` → `String`


##### `public emailNotificationUrl` → `String`


##### `public enableChatterAnswers` → `Boolean`


##### `public enablePrivateQuestions` → `Boolean`


##### `public expertsGroup` → `String`


##### `public portal` → `String`


##### `public reputationLevels` → `MetadataService`


##### `public showInPortal` → `Boolean`


##### `public site` → `String`


##### `private active_type_info` → `String`


##### `private chatterAnswersFacebookSsoUrl_type_info` → `String`


##### `private communityFeedPage_type_info` → `String`


##### `private dataCategoryName_type_info` → `String`


##### `private description_type_info` → `String`


##### `private emailFooterDocument_type_info` → `String`


##### `private emailHeaderDocument_type_info` → `String`


##### `private emailNotificationUrl_type_info` → `String`


##### `private enableChatterAnswers_type_info` → `String`


##### `private enablePrivateQuestions_type_info` → `String`


##### `private expertsGroup_type_info` → `String`


##### `private portal_type_info` → `String`


##### `private reputationLevels_type_info` → `String`


##### `private showInPortal_type_info` → `String`


##### `private site_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### BusinessProcess

**Inheritance**

BusinessProcess

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public isActive` → `Boolean`


##### `public values` → `MetadataService.PicklistValue`


##### `private description_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private values_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmailToCaseRoutingAddress
#### Fields

##### `public addressType` → `String`


##### `public authorizedSenders` → `String`


##### `public caseOrigin` → `String`


##### `public caseOwner` → `String`


##### `public caseOwnerType` → `String`


##### `public casePriority` → `String`


##### `public createTask` → `Boolean`


##### `public emailAddress` → `String`


##### `public emailServicesAddress` → `String`


##### `public isVerified` → `Boolean`


##### `public routingName` → `String`


##### `public saveEmailHeaders` → `Boolean`


##### `public taskStatus` → `String`


##### `private addressType_type_info` → `String`


##### `private authorizedSenders_type_info` → `String`


##### `private caseOrigin_type_info` → `String`


##### `private caseOwner_type_info` → `String`


##### `private caseOwnerType_type_info` → `String`


##### `private casePriority_type_info` → `String`


##### `private createTask_type_info` → `String`


##### `private emailAddress_type_info` → `String`


##### `private emailServicesAddress_type_info` → `String`


##### `private isVerified_type_info` → `String`


##### `private routingName_type_info` → `String`


##### `private saveEmailHeaders_type_info` → `String`


##### `private taskStatus_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DataCategory
#### Fields

##### `public dataCategory` → `MetadataService.DataCategory`


##### `public label` → `String`


##### `public name` → `String`


##### `private dataCategory_type_info` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetTabSetting
#### Fields

##### `public tab` → `String`


##### `public visibility` → `String`


##### `private tab_type_info` → `String`


##### `private visibility_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportHistoricalSelector
#### Fields

##### `public snapshot` → `String`


##### `private snapshot_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Users
#### Fields

##### `public user_x` → `String`


##### `private user_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetUserPermission
#### Fields

##### `public enabled` → `Boolean`


##### `public name` → `String`


##### `private enabled_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingRules

**Inheritance**

SharingRules

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public sharingCriteriaRules` → `MetadataService.SharingCriteriaRule`


##### `public sharingOwnerRules` → `MetadataService.SharingOwnerRule`


##### `public sharingTerritoryRules` → `MetadataService.SharingTerritoryRule`


##### `private sharingCriteriaRules_type_info` → `String`


##### `private sharingOwnerRules_type_info` → `String`


##### `private sharingTerritoryRules_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingRecalculation
#### Fields

##### `public className` → `String`


##### `private className_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomLabels

**Inheritance**

CustomLabels

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public labels` → `MetadataService.CustomLabel`


##### `private labels_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldSetTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RelatedContentItem
#### Fields

##### `public layoutItem` → `MetadataService`


##### `private layoutItem_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveAgentConfig
#### Fields

##### `public enableLiveChat` → `Boolean`


##### `public openNewAccountSubtab` → `Boolean`


##### `public openNewCaseSubtab` → `Boolean`


##### `public openNewContactSubtab` → `Boolean`


##### `public openNewLeadSubtab` → `Boolean`


##### `public openNewVFPageSubtab` → `Boolean`


##### `public pageNamesToOpen` → `String`


##### `public showKnowledgeArticles` → `Boolean`


##### `private enableLiveChat_type_info` → `String`


##### `private openNewAccountSubtab_type_info` → `String`


##### `private openNewCaseSubtab_type_info` → `String`


##### `private openNewContactSubtab_type_info` → `String`


##### `private openNewLeadSubtab_type_info` → `String`


##### `private openNewVFPageSubtab_type_info` → `String`


##### `private pageNamesToOpen_type_info` → `String`


##### `private showKnowledgeArticles_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RunTestsResult
#### Fields

##### `public apexLogId` → `String`


##### `public codeCoverage` → `MetadataService.CodeCoverageResult`


##### `public codeCoverageWarnings` → `MetadataService.CodeCoverageWarning`


##### `public failures` → `MetadataService.RunTestFailure`


##### `public numFailures` → `Integer`


##### `public numTestsRun` → `Integer`


##### `public successes` → `MetadataService.RunTestSuccess`


##### `public totalTime` → `Double`


##### `private apexLogId_type_info` → `String`


##### `private codeCoverage_type_info` → `String`


##### `private codeCoverageWarnings_type_info` → `String`


##### `private failures_type_info` → `String`


##### `private numFailures_type_info` → `String`


##### `private numTestsRun_type_info` → `String`


##### `private successes_type_info` → `String`


##### `private totalTime_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityThemeDefinition
#### Fields

##### `public customThemeLayoutType` → `MetadataService.CommunityCustomThemeLayoutType`


##### `public description` → `String`


##### `public enableExtendedCleanUpOnDelete` → `Boolean`


##### `public masterLabel` → `String`


##### `public themeSetting` → `MetadataService.CommunityThemeSetting`


##### `private customThemeLayoutType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private enableExtendedCleanUpOnDelete_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private themeSetting_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LicenseDefinition

**Inheritance**

LicenseDefinition

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public aggregationGroup` → `String`


##### `public description` → `String`


##### `public isPublished` → `Boolean`


##### `public label` → `String`


##### `public licensedCustomPermissions` → `MetadataService.LicensedCustomPermissions`


##### `public licensingAuthority` → `String`


##### `public licensingAuthorityProvider` → `String`


##### `public minPlatformVersion` → `Integer`


##### `public origin` → `String`


##### `public revision` → `Integer`


##### `public trialLicenseDuration` → `Integer`


##### `public trialLicenseQuantity` → `Integer`


##### `private aggregationGroup_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isPublished_type_info` → `String`


##### `private label_type_info` → `String`


##### `private licensedCustomPermissions_type_info` → `String`


##### `private licensingAuthority_type_info` → `String`


##### `private licensingAuthorityProvider_type_info` → `String`


##### `private minPlatformVersion_type_info` → `String`


##### `private origin_type_info` → `String`


##### `private revision_type_info` → `String`


##### `private trialLicenseDuration_type_info` → `String`


##### `private trialLicenseQuantity_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowOutputFieldAssignment

**Inheritance**

FlowOutputFieldAssignment

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public assignToReference` → `String`


##### `public field` → `String`


##### `private assignToReference_type_info` → `String`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowApexPluginCallOutputParameter

**Inheritance**

FlowApexPluginCallOutputParameter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public assignToReference` → `String`


##### `public name` → `String`


##### `private assignToReference_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardGridLayout
#### Fields

##### `public dashboardGridComponents` → `MetadataService.DashboardGridComponent`


##### `public numberOfColumns` → `Integer`


##### `public rowHeight` → `Integer`


##### `private dashboardGridComponents_type_info` → `String`


##### `private numberOfColumns_type_info` → `String`


##### `private rowHeight_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AdjustmentsSettings
#### Fields

##### `public enableAdjustments` → `Boolean`


##### `public enableOwnerAdjustments` → `Boolean`


##### `private enableAdjustments_type_info` → `String`


##### `private enableOwnerAdjustments_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SummaryLayoutItem
#### Fields

##### `public customLink` → `String`


##### `public field` → `String`


##### `public posX` → `Integer`


##### `public posY` → `Integer`


##### `public posZ` → `Integer`


##### `private customLink_type_info` → `String`


##### `private field_type_info` → `String`


##### `private posX_type_info` → `String`


##### `private posY_type_info` → `String`


##### `private posZ_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionLayoutItem
#### Fields

##### `public emptySpace` → `Boolean`


##### `public field` → `String`


##### `public uiBehavior` → `String`


##### `private emptySpace_type_info` → `String`


##### `private field_type_info` → `String`


##### `private uiBehavior_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DeployDetails
#### Fields

##### `public componentFailures` → `MetadataService.DeployMessage`


##### `public componentSuccesses` → `MetadataService.DeployMessage`


##### `public retrieveResult` → `MetadataService`


##### `public runTestResult` → `MetadataService`


##### `private componentFailures_type_info` → `String`


##### `private componentSuccesses_type_info` → `String`


##### `private retrieveResult_type_info` → `String`


##### `private runTestResult_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlexiPage

**Inheritance**

FlexiPage

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public flexiPageRegions` → `MetadataService.FlexiPageRegion`


##### `public masterLabel` → `String`


##### `public parentFlexiPage` → `String`


##### `public platformActionlist` → `MetadataService`


##### `public quickActionList` → `MetadataService`


##### `public sobjectType` → `String`


##### `public template` → `MetadataService`


##### `public type_x` → `String`


##### `private description_type_info` → `String`


##### `private flexiPageRegions_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private parentFlexiPage_type_info` → `String`


##### `private platformActionlist_type_info` → `String`


##### `private quickActionList_type_info` → `String`


##### `private sobjectType_type_info` → `String`


##### `private template_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EntitlementProcessMilestoneTimeTrigger
#### Fields

##### `public actions` → `MetadataService.WorkflowActionReference`


##### `public timeLength` → `Integer`


##### `public workflowTimeTriggerUnit` → `String`


##### `private actions_type_info` → `String`


##### `private timeLength_type_info` → `String`


##### `private workflowTimeTriggerUnit_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### NavigationLinkSet
#### Fields

##### `public navigationMenuItem` → `MetadataService.NavigationMenuItem`


##### `private navigationMenuItem_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityTemplateBundleInfo
#### Fields

##### `public description` → `String`


##### `public image` → `String`


##### `public order` → `Integer`


##### `public title` → `String`


##### `public type_x` → `String`


##### `private description_type_info` → `String`


##### `private image_type_info` → `String`


##### `private order_type_info` → `String`


##### `private title_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### UiFormulaCriterion
#### Fields

##### `public leftValue` → `String`


##### `public operator` → `String`


##### `public rightValue` → `String`


##### `private leftValue_type_info` → `String`


##### `private operator_type_info` → `String`


##### `private rightValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PlatformActionList
#### Fields

##### `public actionListContext` → `String`


##### `public platformActionListItems` → `MetadataService.PlatformActionListItem`


##### `public relatedSourceEntity` → `String`


##### `private actionListContext_type_info` → `String`


##### `private platformActionListItems_type_info` → `String`


##### `private relatedSourceEntity_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CallCenter

**Inheritance**

CallCenter

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public adapterUrl` → `String`


##### `public customSettings` → `String`


##### `public displayName` → `String`


##### `public displayNameLabel` → `String`


##### `public internalNameLabel` → `String`


##### `public sections` → `MetadataService.CallCenterSection`


##### `public version` → `String`


##### `private adapterUrl_type_info` → `String`


##### `private customSettings_type_info` → `String`


##### `private displayName_type_info` → `String`


##### `private displayNameLabel_type_info` → `String`


##### `private internalNameLabel_type_info` → `String`


##### `private sections_type_info` → `String`


##### `private version_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LightningComponentBundle
#### Fields

##### `public apiVersion` → `Double`


##### `public isExposed` → `Boolean`


##### `private apiVersion_type_info` → `String`


##### `private isExposed_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### MarketingActionSettings

**Inheritance**

MarketingActionSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableMarketingAction` → `Boolean`


##### `private enableMarketingAction_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### AccountSharingRuleSettings
#### Fields

##### `public caseAccessLevel` → `String`


##### `public contactAccessLevel` → `String`


##### `public opportunityAccessLevel` → `String`


##### `private caseAccessLevel_type_info` → `String`


##### `private contactAccessLevel_type_info` → `String`


##### `private opportunityAccessLevel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AgentConfigButtons
#### Fields

##### `public button` → `String`


##### `private button_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomShortcut
#### Fields

##### `public description` → `String`


##### `public eventName` → `String`


##### `private description_type_info` → `String`


##### `private eventName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ArticleTypeChannelDisplay
#### Fields

##### `public articleTypeTemplates` → `MetadataService.ArticleTypeTemplate`


##### `private articleTypeTemplates_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowWaitEventInputParameter

**Inheritance**

FlowWaitEventInputParameter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public name` → `String`


##### `public value` → `MetadataService`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowOutboundMessage

**Inheritance**

WorkflowOutboundMessage

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public apiVersion` → `Double`


##### `public description` → `String`


##### `public endpointUrl` → `String`


##### `public fields` → `String`


##### `public includeSessionId` → `Boolean`


##### `public integrationUser` → `String`


##### `public name` → `String`


##### `public protected_x` → `Boolean`


##### `public useDeadLetterQueue` → `Boolean`


##### `private apiVersion_type_info` → `String`


##### `private description_type_info` → `String`


##### `private endpointUrl_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private includeSessionId_type_info` → `String`


##### `private integrationUser_type_info` → `String`


##### `private name_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private useDeadLetterQueue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveDataset

**Inheritance**

WaveDataset

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public application` → `String`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public templateAssetSourceName` → `String`


##### `private application_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private templateAssetSourceName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CorsWhitelistOrigin

**Inheritance**

CorsWhitelistOrigin

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public urlPattern` → `String`


##### `private urlPattern_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SessionHeader_element
#### Fields

##### `public sessionId` → `String`


##### `private sessionId_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AnalyticSnapshot

**Inheritance**

AnalyticSnapshot

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public groupColumn` → `String`


##### `public mappings` → `MetadataService.AnalyticSnapshotMapping`


##### `public name` → `String`


##### `public runningUser` → `String`


##### `public sourceReport` → `String`


##### `public targetObject` → `String`


##### `private description_type_info` → `String`


##### `private groupColumn_type_info` → `String`


##### `private mappings_type_info` → `String`


##### `private name_type_info` → `String`


##### `private runningUser_type_info` → `String`


##### `private sourceReport_type_info` → `String`


##### `private targetObject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowElement

**Inheritance**

FlowElement

#### Fields

##### `public description` → `String`


##### `public name` → `String`


---

### ReputationPointsRules
#### Fields

##### `public pointsRule` → `MetadataService.ReputationPointsRule`


##### `private pointsRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileCustomPermissions
#### Fields

##### `public enabled` → `Boolean`


##### `public name` → `String`


##### `private enabled_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenFieldInputParameter
#### Fields

##### `public name` → `String`


##### `public value` → `MetadataService`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### deployRecentValidationResponse_element
#### Fields

##### `public result` → `String`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Orchestration
#### Fields

##### `public context` → `String`


##### `public masterLabel` → `String`


##### `private context_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ScheduledRecommendation
#### Fields

##### `public scheduledRecommendationDetails` → `MetadataService.ScheduledRecommendationDetail`


##### `private scheduledRecommendationDetails_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### IpRange
#### Fields

##### `public description` → `String`


##### `public end_x` → `String`


##### `public start` → `String`


##### `private description_type_info` → `String`


##### `private end_x_type_info` → `String`


##### `private start_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### deployRecentValidation_element
#### Fields

##### `public validationId` → `String`


##### `private validationId_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenRule
#### Fields

##### `public conditionLogic` → `String`


##### `public conditions` → `MetadataService.FlowCondition`


##### `public label` → `String`


##### `public ruleActions` → `MetadataService.FlowScreenRuleAction`


##### `private conditionLogic_type_info` → `String`


##### `private conditions_type_info` → `String`


##### `private label_type_info` → `String`


##### `private ruleActions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ManagedTopics

**Inheritance**

ManagedTopics

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public managedTopic` → `MetadataService.ManagedTopic`


##### `private managedTopic_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FeedFilterCriterion
#### Fields

##### `public feedItemType` → `String`


##### `public feedItemVisibility` → `String`


##### `public relatedSObjectType` → `String`


##### `private feedItemType_type_info` → `String`


##### `private feedItemVisibility_type_info` → `String`


##### `private relatedSObjectType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportBlockInfo
#### Fields

##### `public aggregateReferences` → `MetadataService.ReportAggregateReference`


##### `public blockId` → `String`


##### `public joinTable` → `String`


##### `private aggregateReferences_type_info` → `String`


##### `private blockId_type_info` → `String`


##### `private joinTable_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Folder

**Inheritance**

Folder

#### Fields

##### `public accessType` → `String`


##### `public folderShares` → `MetadataService.FolderShare`


##### `public name` → `String`


##### `public publicFolderAccess` → `String`


##### `public sharedTo` → `MetadataService`


---

### Profile

**Inheritance**

Profile

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public applicationVisibilities` → `MetadataService.ProfileApplicationVisibility`


##### `public categoryGroupVisibilities` → `MetadataService.ProfileCategoryGroupVisibility`


##### `public classAccesses` → `MetadataService.ProfileApexClassAccess`


##### `public custom` → `Boolean`


##### `public customPermissions` → `MetadataService.ProfileCustomPermissions`


##### `public description` → `String`


##### `public externalDataSourceAccesses` → `MetadataService.ProfileExternalDataSourceAccess`


##### `public fieldPermissions` → `MetadataService.ProfileFieldLevelSecurity`


##### `public layoutAssignments` → `MetadataService.ProfileLayoutAssignment`


##### `public loginHours` → `MetadataService`


##### `public loginIpRanges` → `MetadataService.ProfileLoginIpRange`


##### `public objectPermissions` → `MetadataService.ProfileObjectPermissions`


##### `public pageAccesses` → `MetadataService.ProfileApexPageAccess`


##### `public profileActionOverrides` → `MetadataService.ProfileActionOverride`


##### `public recordTypeVisibilities` → `MetadataService.ProfileRecordTypeVisibility`


##### `public tabVisibilities` → `MetadataService.ProfileTabVisibility`


##### `public userLicense` → `String`


##### `public userPermissions` → `MetadataService.ProfileUserPermission`


##### `private applicationVisibilities_type_info` → `String`


##### `private categoryGroupVisibilities_type_info` → `String`


##### `private classAccesses_type_info` → `String`


##### `private custom_type_info` → `String`


##### `private customPermissions_type_info` → `String`


##### `private description_type_info` → `String`


##### `private externalDataSourceAccesses_type_info` → `String`


##### `private fieldPermissions_type_info` → `String`


##### `private layoutAssignments_type_info` → `String`


##### `private loginHours_type_info` → `String`


##### `private loginIpRanges_type_info` → `String`


##### `private objectPermissions_type_info` → `String`


##### `private pageAccesses_type_info` → `String`


##### `private profileActionOverrides_type_info` → `String`


##### `private recordTypeVisibilities_type_info` → `String`


##### `private tabVisibilities_type_info` → `String`


##### `private userLicense_type_info` → `String`


##### `private userPermissions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeLanguage
#### Fields

##### `public active` → `Boolean`


##### `public defaultAssignee` → `String`


##### `public defaultAssigneeType` → `String`


##### `public defaultReviewer` → `String`


##### `public defaultReviewerType` → `String`


##### `public name` → `String`


##### `private active_type_info` → `String`


##### `private defaultAssignee_type_info` → `String`


##### `private defaultAssigneeType_type_info` → `String`


##### `private defaultReviewer_type_info` → `String`


##### `private defaultReviewerType_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DeployOptions
#### Fields

##### `public allowMissingFiles` → `Boolean`


##### `public autoUpdatePackage` → `Boolean`


##### `public checkOnly` → `Boolean`


##### `public ignoreWarnings` → `Boolean`


##### `public performRetrieve` → `Boolean`


##### `public purgeOnDelete` → `Boolean`


##### `public rollbackOnError` → `Boolean`


##### `public runTests` → `String`


##### `public singlePackage` → `Boolean`


##### `public testLevel` → `String`


##### `private allowMissingFiles_type_info` → `String`


##### `private autoUpdatePackage_type_info` → `String`


##### `private checkOnly_type_info` → `String`


##### `private ignoreWarnings_type_info` → `String`


##### `private performRetrieve_type_info` → `String`


##### `private purgeOnDelete_type_info` → `String`


##### `private rollbackOnError_type_info` → `String`


##### `private runTests_type_info` → `String`


##### `private singlePackage_type_info` → `String`


##### `private testLevel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### InsightType
#### Fields

##### `public defaultTrendType` → `String`


##### `public description` → `String`


##### `public isProtected` → `Boolean`


##### `public masterLabel` → `String`


##### `public parentType` → `String`


##### `public title` → `String`


##### `private defaultTrendType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private parentType_type_info` → `String`


##### `private title_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldSet

**Inheritance**

FieldSet

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public availableFields` → `MetadataService.FieldSetItem`


##### `public description` → `String`


##### `public displayedFields` → `MetadataService.FieldSetItem`


##### `public label` → `String`


##### `private availableFields_type_info` → `String`


##### `private description_type_info` → `String`


##### `private displayedFields_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileLoginHours
#### Fields

##### `public fridayEnd` → `String`


##### `public fridayStart` → `String`


##### `public mondayEnd` → `String`


##### `public mondayStart` → `String`


##### `public saturdayEnd` → `String`


##### `public saturdayStart` → `String`


##### `public sundayEnd` → `String`


##### `public sundayStart` → `String`


##### `public thursdayEnd` → `String`


##### `public thursdayStart` → `String`


##### `public tuesdayEnd` → `String`


##### `public tuesdayStart` → `String`


##### `public wednesdayEnd` → `String`


##### `public wednesdayStart` → `String`


##### `private fridayEnd_type_info` → `String`


##### `private fridayStart_type_info` → `String`


##### `private mondayEnd_type_info` → `String`


##### `private mondayStart_type_info` → `String`


##### `private saturdayEnd_type_info` → `String`


##### `private saturdayStart_type_info` → `String`


##### `private sundayEnd_type_info` → `String`


##### `private sundayStart_type_info` → `String`


##### `private thursdayEnd_type_info` → `String`


##### `private thursdayStart_type_info` → `String`


##### `private tuesdayEnd_type_info` → `String`


##### `private tuesdayStart_type_info` → `String`


##### `private wednesdayEnd_type_info` → `String`


##### `private wednesdayStart_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowChoiceUserInput

**Inheritance**

FlowChoiceUserInput

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public isRequired` → `Boolean`


##### `public promptText` → `String`


##### `public validationRule` → `MetadataService`


##### `private isRequired_type_info` → `String`


##### `private promptText_type_info` → `String`


##### `private validationRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### HomePageComponent

**Inheritance**

HomePageComponent

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public body` → `String`


##### `public height` → `Integer`


##### `public links` → `String`


##### `public page_x` → `String`


##### `public pageComponentType` → `String`


##### `public showLabel` → `Boolean`


##### `public showScrollbars` → `Boolean`


##### `public width` → `String`


##### `private body_type_info` → `String`


##### `private height_type_info` → `String`


##### `private links_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private pageComponentType_type_info` → `String`


##### `private showLabel_type_info` → `String`


##### `private showScrollbars_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetFieldPermissions
#### Fields

##### `public editable` → `Boolean`


##### `public field` → `String`


##### `public readable` → `Boolean`


##### `private editable_type_info` → `String`


##### `private field_type_info` → `String`


##### `private readable_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RetrieveRequest
#### Fields

##### `public apiVersion` → `Double`


##### `public packageNames` → `String`


##### `public singlePackage` → `Boolean`


##### `public specificFiles` → `String`


##### `public unpackaged` → `MetadataService`


##### `private apiVersion_type_info` → `String`


##### `private packageNames_type_info` → `String`


##### `private singlePackage_type_info` → `String`


##### `private specificFiles_type_info` → `String`


##### `private unpackaged_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ObjectRelationship
#### Fields

##### `public join_x` → `MetadataService`


##### `public outerJoin` → `Boolean`


##### `public relationship` → `String`


##### `private join_x_type_info` → `String`


##### `private outerJoin_type_info` → `String`


##### `private relationship_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportLayoutSection
#### Fields

##### `public columns` → `MetadataService.ReportTypeColumn`


##### `public masterLabel` → `String`


##### `private columns_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CompactLayout

**Inheritance**

CompactLayout

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public fields` → `String`


##### `public label` → `String`


##### `private fields_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### VisualizationType
#### Fields

##### `public description` → `String`


##### `public developerName` → `String`


##### `public icon` → `String`


##### `public masterLabel` → `String`


##### `public scriptBootstrapMethod` → `String`


##### `private description_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private icon_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private scriptBootstrapMethod_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingBaseRule

**Inheritance**

SharingBaseRule

#### Fields

##### `public accessLevel` → `String`


##### `public accountSettings` → `MetadataService`


##### `public description` → `String`


##### `public label` → `String`


##### `public sharedTo` → `MetadataService`


---

### AuthProvider

**Inheritance**

AuthProvider

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public authorizeUrl` → `String`


##### `public consumerKey` → `String`


##### `public consumerSecret` → `String`


##### `public customMetadataTypeRecord` → `String`


##### `public defaultScopes` → `String`


##### `public errorUrl` → `String`


##### `public executionUser` → `String`


##### `public friendlyName` → `String`


##### `public iconUrl` → `String`


##### `public idTokenIssuer` → `String`


##### `public includeOrgIdInIdentifier` → `Boolean`


##### `public logoutUrl` → `String`


##### `public plugin` → `String`


##### `public portal` → `String`


##### `public providerType` → `String`


##### `public registrationHandler` → `String`


##### `public sendAccessTokenInHeader` → `Boolean`


##### `public sendClientCredentialsInHeader` → `Boolean`


##### `public tokenUrl` → `String`


##### `public userInfoUrl` → `String`


##### `private authorizeUrl_type_info` → `String`


##### `private consumerKey_type_info` → `String`


##### `private consumerSecret_type_info` → `String`


##### `private customMetadataTypeRecord_type_info` → `String`


##### `private defaultScopes_type_info` → `String`


##### `private errorUrl_type_info` → `String`


##### `private executionUser_type_info` → `String`


##### `private friendlyName_type_info` → `String`


##### `private iconUrl_type_info` → `String`


##### `private idTokenIssuer_type_info` → `String`


##### `private includeOrgIdInIdentifier_type_info` → `String`


##### `private logoutUrl_type_info` → `String`


##### `private plugin_type_info` → `String`


##### `private portal_type_info` → `String`


##### `private providerType_type_info` → `String`


##### `private registrationHandler_type_info` → `String`


##### `private sendAccessTokenInHeader_type_info` → `String`


##### `private sendClientCredentialsInHeader_type_info` → `String`


##### `private tokenUrl_type_info` → `String`


##### `private userInfoUrl_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowDynamicChoiceSet

**Inheritance**

FlowDynamicChoiceSet

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public dataType` → `String`


##### `public displayField` → `String`


##### `public filters` → `MetadataService.FlowRecordFilter`


##### `public limit_x` → `Integer`


##### `public object_x` → `String`


##### `public outputAssignments` → `MetadataService.FlowOutputFieldAssignment`


##### `public picklistField` → `String`


##### `public picklistObject` → `String`


##### `public sortField` → `String`


##### `public sortOrder` → `String`


##### `public valueField` → `String`


##### `private dataType_type_info` → `String`


##### `private displayField_type_info` → `String`


##### `private filters_type_info` → `String`


##### `private limit_x_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private outputAssignments_type_info` → `String`


##### `private picklistField_type_info` → `String`


##### `private picklistObject_type_info` → `String`


##### `private sortField_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private valueField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### RelatedContent
#### Fields

##### `public relatedContentItems` → `MetadataService.RelatedContentItem`


##### `private relatedContentItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WebLink

**Inheritance**

WebLink

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public availability` → `String`


##### `public description` → `String`


##### `public displayType` → `String`


##### `public encodingKey` → `String`


##### `public hasMenubar` → `Boolean`


##### `public hasScrollbars` → `Boolean`


##### `public hasToolbar` → `Boolean`


##### `public height` → `Integer`


##### `public isResizable` → `Boolean`


##### `public linkType` → `String`


##### `public masterLabel` → `String`


##### `public openType` → `String`


##### `public page_x` → `String`


##### `public position` → `String`


##### `public protected_x` → `Boolean`


##### `public requireRowSelection` → `Boolean`


##### `public scontrol` → `String`


##### `public showsLocation` → `Boolean`


##### `public showsStatus` → `Boolean`


##### `public url` → `String`


##### `public width` → `Integer`


##### `private availability_type_info` → `String`


##### `private description_type_info` → `String`


##### `private displayType_type_info` → `String`


##### `private encodingKey_type_info` → `String`


##### `private hasMenubar_type_info` → `String`


##### `private hasScrollbars_type_info` → `String`


##### `private hasToolbar_type_info` → `String`


##### `private height_type_info` → `String`


##### `private isResizable_type_info` → `String`


##### `private linkType_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private openType_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private position_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private requireRowSelection_type_info` → `String`


##### `private scontrol_type_info` → `String`


##### `private showsLocation_type_info` → `String`


##### `private showsStatus_type_info` → `String`


##### `private url_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Flow

**Inheritance**

Flow

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public actionCalls` → `MetadataService.FlowActionCall`


##### `public apexPluginCalls` → `MetadataService.FlowApexPluginCall`


##### `public assignments` → `MetadataService.FlowAssignment`


##### `public choices` → `MetadataService.FlowChoice`


##### `public constants` → `MetadataService.FlowConstant`


##### `public decisions` → `MetadataService.FlowDecision`


##### `public description` → `String`


##### `public dynamicChoiceSets` → `MetadataService.FlowDynamicChoiceSet`


##### `public formulas` → `MetadataService.FlowFormula`


##### `public interviewLabel` → `String`


##### `public label` → `String`


##### `public loops` → `MetadataService.FlowLoop`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `public processType` → `String`


##### `public recordCreates` → `MetadataService.FlowRecordCreate`


##### `public recordDeletes` → `MetadataService.FlowRecordDelete`


##### `public recordLookups` → `MetadataService.FlowRecordLookup`


##### `public recordUpdates` → `MetadataService.FlowRecordUpdate`


##### `public screens` → `MetadataService.FlowScreen`


##### `public stages` → `MetadataService.FlowStage`


##### `public startElementReference` → `String`


##### `public steps` → `MetadataService.FlowStep`


##### `public subflows` → `MetadataService.FlowSubflow`


##### `public textTemplates` → `MetadataService.FlowTextTemplate`


##### `public variables` → `MetadataService.FlowVariable`


##### `public waits` → `MetadataService.FlowWait`


##### `private actionCalls_type_info` → `String`


##### `private apexPluginCalls_type_info` → `String`


##### `private assignments_type_info` → `String`


##### `private choices_type_info` → `String`


##### `private constants_type_info` → `String`


##### `private decisions_type_info` → `String`


##### `private description_type_info` → `String`


##### `private dynamicChoiceSets_type_info` → `String`


##### `private formulas_type_info` → `String`


##### `private interviewLabel_type_info` → `String`


##### `private label_type_info` → `String`


##### `private loops_type_info` → `String`


##### `private processMetadataValues_type_info` → `String`


##### `private processType_type_info` → `String`


##### `private recordCreates_type_info` → `String`


##### `private recordDeletes_type_info` → `String`


##### `private recordLookups_type_info` → `String`


##### `private recordUpdates_type_info` → `String`


##### `private screens_type_info` → `String`


##### `private stages_type_info` → `String`


##### `private startElementReference_type_info` → `String`


##### `private steps_type_info` → `String`


##### `private subflows_type_info` → `String`


##### `private textTemplates_type_info` → `String`


##### `private variables_type_info` → `String`


##### `private waits_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomMetadataValue
#### Fields

##### `public field` → `String`


##### `public value` → `String`


##### `private field_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QueueMembers
#### Fields

##### `public publicGroups` → `MetadataService`


##### `public roleAndSubordinates` → `MetadataService`


##### `public roleAndSubordinatesInternal` → `MetadataService`


##### `public roles` → `MetadataService`


##### `public users` → `MetadataService`


##### `private publicGroups_type_info` → `String`


##### `private roleAndSubordinates_type_info` → `String`


##### `private roleAndSubordinatesInternal_type_info` → `String`


##### `private roles_type_info` → `String`


##### `private users_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ArticleTypeTemplate
#### Fields

##### `public channel` → `String`


##### `public page_x` → `String`


##### `public template` → `String`


##### `private channel_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private template_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveDataflow

**Inheritance**

WaveDataflow

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public dataflowType` → `String`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `private dataflowType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### StandardValueSet

**Inheritance**

StandardValueSet

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public groupingStringEnum` → `String`


##### `public sorted` → `Boolean`


##### `public standardValue` → `MetadataService.StandardValue`


##### `private groupingStringEnum_type_info` → `String`


##### `private sorted_type_info` → `String`


##### `private standardValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FileUploadAndDownloadSecuritySettings

**Inheritance**

FileUploadAndDownloadSecuritySettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public dispositions` → `MetadataService.FileTypeDispositionAssignmentBean`


##### `public noHtmlUploadAsAttachment` → `Boolean`


##### `private dispositions_type_info` → `String`


##### `private noHtmlUploadAsAttachment_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LetterheadHeaderFooter
#### Fields

##### `public backgroundColor` → `String`


##### `public height` → `Integer`


##### `public horizontalAlignment` → `String`


##### `public logo` → `String`


##### `public verticalAlignment` → `String`


##### `private backgroundColor_type_info` → `String`


##### `private height_type_info` → `String`


##### `private horizontalAlignment_type_info` → `String`


##### `private logo_type_info` → `String`


##### `private verticalAlignment_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PicklistValueTranslation
#### Fields

##### `public masterLabel` → `String`


##### `public translation` → `String`


##### `private masterLabel_type_info` → `String`


##### `private translation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CountriesAndStates
#### Fields

##### `public countries` → `MetadataService.Country`


##### `private countries_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PathAssistant
#### Fields

##### `public active` → `Boolean`


##### `public entityName` → `String`


##### `public fieldName` → `String`


##### `public masterLabel` → `String`


##### `public pathAssistantSteps` → `MetadataService.PathAssistantStep`


##### `public recordTypeName` → `String`


##### `private active_type_info` → `String`


##### `private entityName_type_info` → `String`


##### `private fieldName_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private pathAssistantSteps_type_info` → `String`


##### `private recordTypeName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AsyncResult
#### Fields

##### `public done` → `Boolean`


##### `public id` → `String`


##### `public message` → `String`


##### `public state` → `String`


##### `public statusCode` → `String`


##### `private done_type_info` → `String`


##### `private id_type_info` → `String`


##### `private message_type_info` → `String`


##### `private state_type_info` → `String`


##### `private statusCode_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### XOrgHub

**Inheritance**

XOrgHub

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public label` → `String`


##### `public lockSharedObjects` → `Boolean`


##### `public permissionSets` → `String`


##### `public sharedObjects` → `MetadataService.XOrgHubSharedObject`


##### `private label_type_info` → `String`


##### `private lockSharedObjects_type_info` → `String`


##### `private permissionSets_type_info` → `String`


##### `private sharedObjects_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LightningBoltItems
#### Fields

##### `public name` → `String`


##### `public type_x` → `String`


##### `private name_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomLabel

**Inheritance**

CustomLabel

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public categories` → `String`


##### `public language` → `String`


##### `public protected_x` → `Boolean`


##### `public shortDescription` → `String`


##### `public value` → `String`


##### `private categories_type_info` → `String`


##### `private language_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private shortDescription_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChatterExtension
#### Fields

##### `public compositionComponent` → `String`


##### `public description` → `String`


##### `public extensionName` → `String`


##### `public headerText` → `String`


##### `public hoverText` → `String`


##### `public icon` → `String`


##### `public isProtected` → `Boolean`


##### `public masterLabel` → `String`


##### `public renderComponent` → `String`


##### `public type_x` → `String`


##### `private compositionComponent_type_info` → `String`


##### `private description_type_info` → `String`


##### `private extensionName_type_info` → `String`


##### `private headerText_type_info` → `String`


##### `private hoverText_type_info` → `String`


##### `private icon_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private renderComponent_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### NameSettings

**Inheritance**

NameSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableMiddleName` → `Boolean`


##### `public enableNameSuffix` → `Boolean`


##### `private enableMiddleName_type_info` → `String`


##### `private enableNameSuffix_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EventType

**Inheritance**

EventType

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public fields` → `MetadataService.EventTypeParameter`


##### `public label` → `String`


##### `private description_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### checkRetrieveStatusResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2Settings

**Inheritance**

Territory2Settings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public defaultAccountAccessLevel` → `String`


##### `public defaultCaseAccessLevel` → `String`


##### `public defaultContactAccessLevel` → `String`


##### `public defaultOpportunityAccessLevel` → `String`


##### `public opportunityFilterSettings` → `MetadataService`


##### `private defaultAccountAccessLevel_type_info` → `String`


##### `private defaultCaseAccessLevel_type_info` → `String`


##### `private defaultContactAccessLevel_type_info` → `String`


##### `private defaultOpportunityAccessLevel_type_info` → `String`


##### `private opportunityFilterSettings_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PlatformCachePartition
#### Fields

##### `public description` → `String`


##### `public isDefaultPartition` → `Boolean`


##### `public masterLabel` → `String`


##### `public platformCachePartitionTypes` → `MetadataService.PlatformCachePartitionType`


##### `private description_type_info` → `String`


##### `private isDefaultPartition_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private platformCachePartitionTypes_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppOauthPolicy
#### Fields

##### `public ipRelaxation` → `String`


##### `public refreshTokenPolicy` → `String`


##### `public singleLogoutUrl` → `String`


##### `private ipRelaxation_type_info` → `String`


##### `private refreshTokenPolicy_type_info` → `String`


##### `private singleLogoutUrl_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppIpRange
#### Fields

##### `public description` → `String`


##### `public end_x` → `String`


##### `public start` → `String`


##### `private description_type_info` → `String`


##### `private end_x_type_info` → `String`


##### `private start_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ExternalDataSource

**Inheritance**

ExternalDataSource

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public authProvider` → `String`


##### `public certificate` → `String`


##### `public customConfiguration` → `String`


##### `public endpoint` → `String`


##### `public isWritable` → `Boolean`


##### `public label` → `String`


##### `public oauthRefreshToken` → `String`


##### `public oauthScope` → `String`


##### `public oauthToken` → `String`


##### `public password` → `String`


##### `public principalType` → `String`


##### `public protocol` → `String`


##### `public repository` → `String`


##### `public type_x` → `String`


##### `public username` → `String`


##### `public version` → `String`


##### `private authProvider_type_info` → `String`


##### `private certificate_type_info` → `String`


##### `private customConfiguration_type_info` → `String`


##### `private endpoint_type_info` → `String`


##### `private isWritable_type_info` → `String`


##### `private label_type_info` → `String`


##### `private oauthRefreshToken_type_info` → `String`


##### `private oauthScope_type_info` → `String`


##### `private oauthToken_type_info` → `String`


##### `private password_type_info` → `String`


##### `private principalType_type_info` → `String`


##### `private protocol_type_info` → `String`


##### `private repository_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private username_type_info` → `String`


##### `private version_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### retrieveResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ComponentInstance
#### Fields

##### `public componentInstanceProperties` → `MetadataService.ComponentInstanceProperty`


##### `public componentName` → `String`


##### `public visibilityRule` → `MetadataService`


##### `private componentInstanceProperties_type_info` → `String`


##### `private componentName_type_info` → `String`


##### `private visibilityRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LayoutSectionTranslation
#### Fields

##### `public label` → `String`


##### `public section` → `String`


##### `private label_type_info` → `String`


##### `private section_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowActionCallOutputParameter

**Inheritance**

FlowActionCallOutputParameter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public assignToReference` → `String`


##### `public name` → `String`


##### `private assignToReference_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### MarketingResourceType

**Inheritance**

MarketingResourceType

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public object_x` → `String`


##### `public provider` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private provider_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalSubmitter
#### Fields

##### `public submitter` → `String`


##### `public type_x` → `String`


##### `private submitter_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowRecordCreate

**Inheritance**

FlowRecordCreate

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public assignRecordIdToReference` → `String`


##### `public connector` → `MetadataService`


##### `public faultConnector` → `MetadataService`


##### `public inputAssignments` → `MetadataService.FlowInputFieldAssignment`


##### `public inputReference` → `String`


##### `public object_x` → `String`


##### `private assignRecordIdToReference_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private inputAssignments_type_info` → `String`


##### `private inputReference_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### upsertMetadataResponse_element
#### Fields

##### `public result` → `MetadataService.UpsertResult`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChannelLayout

**Inheritance**

ChannelLayout

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enabledChannels` → `String`


##### `public label` → `String`


##### `public layoutItems` → `MetadataService.ChannelLayoutItem`


##### `public recordType` → `String`


##### `private enabledChannels_type_info` → `String`


##### `private label_type_info` → `String`


##### `private layoutItems_type_info` → `String`


##### `private recordType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveChatDeploymentDomainWhitelist
#### Fields

##### `public domain` → `String`


##### `private domain_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetRecordTypeVisibility
#### Fields

##### `public recordType` → `String`


##### `public visible` → `Boolean`


##### `private recordType_type_info` → `String`


##### `private visible_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdOrganization
#### Fields

##### `public instanceUrl` → `String`


##### `public label` → `String`


##### `public organizationIdentifier` → `String`


##### `public sortIndex` → `Integer`


##### `private instanceUrl_type_info` → `String`


##### `private label_type_info` → `String`


##### `private organizationIdentifier_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### cancelDeploy_element
#### Fields

##### `public String_x` → `String`


##### `private String_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportFolder

**Inheritance**

ReportFolder

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessType` → `String`


##### `public folderShares` → `MetadataService.FolderShare`


##### `public name` → `String`


##### `public publicFolderAccess` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessType_type_info` → `String`


##### `private folderShares_type_info` → `String`


##### `private name_type_info` → `String`


##### `private publicFolderAccess_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardComponentSection
#### Fields

##### `public columnSize` → `String`


##### `public components` → `MetadataService.DashboardComponent`


##### `private columnSize_type_info` → `String`


##### `private components_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EscalationRule

**Inheritance**

EscalationRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public ruleEntry` → `MetadataService.RuleEntry`


##### `private active_type_info` → `String`


##### `private ruleEntry_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### RunTestFailure
#### Fields

##### `public id` → `String`


##### `public message` → `String`


##### `public methodName` → `String`


##### `public name` → `String`


##### `public namespace` → `String`


##### `public packageName` → `String`


##### `public seeAllData` → `Boolean`


##### `public stackTrace` → `String`


##### `public time_x` → `Double`


##### `public type_x` → `String`


##### `private id_type_info` → `String`


##### `private message_type_info` → `String`


##### `private methodName_type_info` → `String`


##### `private name_type_info` → `String`


##### `private namespace_type_info` → `String`


##### `private packageName_type_info` → `String`


##### `private seeAllData_type_info` → `String`


##### `private stackTrace_type_info` → `String`


##### `private time_x_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SubtabComponents
#### Fields

##### `public containers` → `MetadataService.Container`


##### `private containers_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppOauthIdToken
#### Fields

##### `public idTokenAudience` → `String`


##### `public idTokenIncludeAttributes` → `Boolean`


##### `public idTokenIncludeCustomPerms` → `Boolean`


##### `public idTokenIncludeStandardClaims` → `Boolean`


##### `public idTokenValidity` → `Integer`


##### `private idTokenAudience_type_info` → `String`


##### `private idTokenIncludeAttributes_type_info` → `String`


##### `private idTokenIncludeCustomPerms_type_info` → `String`


##### `private idTokenIncludeStandardClaims_type_info` → `String`


##### `private idTokenValidity_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppMobileDetailConfig
#### Fields

##### `public applicationBinaryFile` → `String`


##### `public applicationBinaryFileName` → `String`


##### `public applicationBundleIdentifier` → `String`


##### `public applicationFileLength` → `Integer`


##### `public applicationIconFile` → `String`


##### `public applicationIconFileName` → `String`


##### `public applicationInstallUrl` → `String`


##### `public devicePlatform` → `String`


##### `public deviceType` → `String`


##### `public minimumOsVersion` → `String`


##### `public privateApp` → `Boolean`


##### `public version` → `String`


##### `private applicationBinaryFile_type_info` → `String`


##### `private applicationBinaryFileName_type_info` → `String`


##### `private applicationBundleIdentifier_type_info` → `String`


##### `private applicationFileLength_type_info` → `String`


##### `private applicationIconFile_type_info` → `String`


##### `private applicationIconFileName_type_info` → `String`


##### `private applicationInstallUrl_type_info` → `String`


##### `private devicePlatform_type_info` → `String`


##### `private deviceType_type_info` → `String`


##### `private minimumOsVersion_type_info` → `String`


##### `private privateApp_type_info` → `String`


##### `private version_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSet

**Inheritance**

PermissionSet

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public applicationVisibilities` → `MetadataService.PermissionSetApplicationVisibility`


##### `public classAccesses` → `MetadataService.PermissionSetApexClassAccess`


##### `public customPermissions` → `MetadataService.PermissionSetCustomPermissions`


##### `public description` → `String`


##### `public externalDataSourceAccesses` → `MetadataService.PermissionSetExternalDataSourceAccess`


##### `public fieldPermissions` → `MetadataService.PermissionSetFieldPermissions`


##### `public hasActivationRequired` → `Boolean`


##### `public label` → `String`


##### `public license` → `String`


##### `public objectPermissions` → `MetadataService.PermissionSetObjectPermissions`


##### `public pageAccesses` → `MetadataService.PermissionSetApexPageAccess`


##### `public recordTypeVisibilities` → `MetadataService.PermissionSetRecordTypeVisibility`


##### `public tabSettings` → `MetadataService.PermissionSetTabSetting`


##### `public userPermissions` → `MetadataService.PermissionSetUserPermission`


##### `private applicationVisibilities_type_info` → `String`


##### `private classAccesses_type_info` → `String`


##### `private customPermissions_type_info` → `String`


##### `private description_type_info` → `String`


##### `private externalDataSourceAccesses_type_info` → `String`


##### `private fieldPermissions_type_info` → `String`


##### `private hasActivationRequired_type_info` → `String`


##### `private label_type_info` → `String`


##### `private license_type_info` → `String`


##### `private objectPermissions_type_info` → `String`


##### `private pageAccesses_type_info` → `String`


##### `private recordTypeVisibilities_type_info` → `String`


##### `private tabSettings_type_info` → `String`


##### `private userPermissions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowRule

**Inheritance**

WorkflowRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public actions` → `MetadataService.WorkflowActionReference`


##### `public active` → `Boolean`


##### `public booleanFilter` → `String`


##### `public criteriaItems` → `MetadataService.FilterItem`


##### `public description` → `String`


##### `public formula` → `String`


##### `public triggerType` → `String`


##### `public workflowTimeTriggers` → `MetadataService.WorkflowTimeTrigger`


##### `private actions_type_info` → `String`


##### `private active_type_info` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private criteriaItems_type_info` → `String`


##### `private description_type_info` → `String`


##### `private formula_type_info` → `String`


##### `private triggerType_type_info` → `String`


##### `private workflowTimeTriggers_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowRule

**Inheritance**

FlowRule

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public conditionLogic` → `String`


##### `public conditions` → `MetadataService.FlowCondition`


##### `public connector` → `MetadataService`


##### `public label` → `String`


##### `private conditionLogic_type_info` → `String`


##### `private conditions_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### NetworkPageOverride
#### Fields

##### `public changePasswordPageOverrideSetting` → `String`


##### `public forgotPasswordPageOverrideSetting` → `String`


##### `public homePageOverrideSetting` → `String`


##### `public loginPageOverrideSetting` → `String`


##### `public selfRegProfilePageOverrideSetting` → `String`


##### `private changePasswordPageOverrideSetting_type_info` → `String`


##### `private forgotPasswordPageOverrideSetting_type_info` → `String`


##### `private homePageOverrideSetting_type_info` → `String`


##### `private loginPageOverrideSetting_type_info` → `String`


##### `private selfRegProfilePageOverrideSetting_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ModerationRule

**Inheritance**

ModerationRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public action` → `String`


##### `public actionLimit` → `Integer`


##### `public active` → `Boolean`


##### `public description` → `String`


##### `public entitiesAndFields` → `MetadataService.ModeratedEntityField`


##### `public masterLabel` → `String`


##### `public notifyLimit` → `Integer`


##### `public timePeriod` → `String`


##### `public type_x` → `String`


##### `public userCriteria` → `String`


##### `public userMessage` → `String`


##### `private action_type_info` → `String`


##### `private actionLimit_type_info` → `String`


##### `private active_type_info` → `String`


##### `private description_type_info` → `String`


##### `private entitiesAndFields_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private notifyLimit_type_info` → `String`


##### `private timePeriod_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private userCriteria_type_info` → `String`


##### `private userMessage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValueTranslation
#### Fields

##### `public masterLabel` → `String`


##### `public translation` → `String`


##### `private masterLabel_type_info` → `String`


##### `private translation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeWorkOrderField
#### Fields

##### `public name` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetApexClassAccess
#### Fields

##### `public apexClass` → `String`


##### `public enabled` → `Boolean`


##### `private apexClass_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CampaignInfluenceModel
#### Fields

##### `public isActive` → `Boolean`


##### `public isDefaultModel` → `Boolean`


##### `public isModelLocked` → `Boolean`


##### `public modelDescription` → `String`


##### `public name` → `String`


##### `public recordPreference` → `String`


##### `private isActive_type_info` → `String`


##### `private isDefaultModel_type_info` → `String`


##### `private isModelLocked_type_info` → `String`


##### `private modelDescription_type_info` → `String`


##### `private name_type_info` → `String`


##### `private recordPreference_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OrchestrationContextEvent
#### Fields

##### `public eventType` → `String`


##### `public orchestrationEvent` → `String`


##### `public platformEvent` → `String`


##### `public platformEventPrimaryKey` → `String`


##### `private eventType_type_info` → `String`


##### `private orchestrationEvent_type_info` → `String`


##### `private platformEvent_type_info` → `String`


##### `private platformEventPrimaryKey_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenTranslation
#### Fields

##### `public fields` → `MetadataService.FlowScreenFieldTranslation`


##### `public helpText` → `String`


##### `public name` → `String`


##### `public pausedText` → `String`


##### `private fields_type_info` → `String`


##### `private helpText_type_info` → `String`


##### `private name_type_info` → `String`


##### `private pausedText_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityRoles
#### Fields

##### `public customerUserRole` → `String`


##### `public employeeUserRole` → `String`


##### `public partnerUserRole` → `String`


##### `private customerUserRole_type_info` → `String`


##### `private employeeUserRole_type_info` → `String`


##### `private partnerUserRole_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RoleAndSubordinatesInternal
#### Fields

##### `public roleAndSubordinateInternal` → `String`


##### `private roleAndSubordinateInternal_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomTab

**Inheritance**

CustomTab

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public actionOverrides` → `MetadataService.ActionOverride`


##### `public auraComponent` → `String`


##### `public customObject` → `Boolean`


##### `public description` → `String`


##### `public flexiPage` → `String`


##### `public frameHeight` → `Integer`


##### `public hasSidebar` → `Boolean`


##### `public icon` → `String`


##### `public label` → `String`


##### `public mobileReady` → `Boolean`


##### `public motif` → `String`


##### `public page_x` → `String`


##### `public scontrol` → `String`


##### `public splashPageLink` → `String`


##### `public url` → `String`


##### `public urlEncodingKey` → `String`


##### `private actionOverrides_type_info` → `String`


##### `private auraComponent_type_info` → `String`


##### `private customObject_type_info` → `String`


##### `private description_type_info` → `String`


##### `private flexiPage_type_info` → `String`


##### `private frameHeight_type_info` → `String`


##### `private hasSidebar_type_info` → `String`


##### `private icon_type_info` → `String`


##### `private label_type_info` → `String`


##### `private mobileReady_type_info` → `String`


##### `private motif_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private scontrol_type_info` → `String`


##### `private splashPageLink_type_info` → `String`


##### `private url_type_info` → `String`


##### `private urlEncodingKey_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveChatAgentConfig

**Inheritance**

LiveChatAgentConfig

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public assignments` → `MetadataService`


##### `public autoGreeting` → `String`


##### `public capacity` → `Integer`


##### `public criticalWaitTime` → `Integer`


##### `public customAgentName` → `String`


##### `public enableAgentFileTransfer` → `Boolean`


##### `public enableAgentSneakPeek` → `Boolean`


##### `public enableAssistanceFlag` → `Boolean`


##### `public enableAutoAwayOnDecline` → `Boolean`


##### `public enableAutoAwayOnPushTimeout` → `Boolean`


##### `public enableChatConferencing` → `Boolean`


##### `public enableChatMonitoring` → `Boolean`


##### `public enableChatTransferToAgent` → `Boolean`


##### `public enableChatTransferToButton` → `Boolean`


##### `public enableChatTransferToSkill` → `Boolean`


##### `public enableLogoutSound` → `Boolean`


##### `public enableNotifications` → `Boolean`


##### `public enableRequestSound` → `Boolean`


##### `public enableSneakPeek` → `Boolean`


##### `public enableVisitorBlocking` → `Boolean`


##### `public enableWhisperMessage` → `Boolean`


##### `public label` → `String`


##### `public supervisorDefaultAgentStatusFilter` → `String`


##### `public supervisorDefaultButtonFilter` → `String`


##### `public supervisorDefaultSkillFilter` → `String`


##### `public supervisorSkills` → `MetadataService`


##### `public transferableButtons` → `MetadataService`


##### `public transferableSkills` → `MetadataService`


##### `private assignments_type_info` → `String`


##### `private autoGreeting_type_info` → `String`


##### `private capacity_type_info` → `String`


##### `private criticalWaitTime_type_info` → `String`


##### `private customAgentName_type_info` → `String`


##### `private enableAgentFileTransfer_type_info` → `String`


##### `private enableAgentSneakPeek_type_info` → `String`


##### `private enableAssistanceFlag_type_info` → `String`


##### `private enableAutoAwayOnDecline_type_info` → `String`


##### `private enableAutoAwayOnPushTimeout_type_info` → `String`


##### `private enableChatConferencing_type_info` → `String`


##### `private enableChatMonitoring_type_info` → `String`


##### `private enableChatTransferToAgent_type_info` → `String`


##### `private enableChatTransferToButton_type_info` → `String`


##### `private enableChatTransferToSkill_type_info` → `String`


##### `private enableLogoutSound_type_info` → `String`


##### `private enableNotifications_type_info` → `String`


##### `private enableRequestSound_type_info` → `String`


##### `private enableSneakPeek_type_info` → `String`


##### `private enableVisitorBlocking_type_info` → `String`


##### `private enableWhisperMessage_type_info` → `String`


##### `private label_type_info` → `String`


##### `private supervisorDefaultAgentStatusFilter_type_info` → `String`


##### `private supervisorDefaultButtonFilter_type_info` → `String`


##### `private supervisorDefaultSkillFilter_type_info` → `String`


##### `private supervisorSkills_type_info` → `String`


##### `private transferableButtons_type_info` → `String`


##### `private transferableSkills_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldMapping
#### Fields

##### `public SObjectType` → `String`


##### `public developerName` → `String`


##### `public fieldMappingRows` → `MetadataService.FieldMappingRow`


##### `public masterLabel` → `String`


##### `private SObjectType_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private fieldMappingRows_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmailToCaseSettings
#### Fields

##### `public enableE2CSourceTracking` → `Boolean`


##### `public enableEmailToCase` → `Boolean`


##### `public enableHtmlEmail` → `Boolean`


##### `public enableOnDemandEmailToCase` → `Boolean`


##### `public enableThreadIDInBody` → `Boolean`


##### `public enableThreadIDInSubject` → `Boolean`


##### `public notifyOwnerOnNewCaseEmail` → `Boolean`


##### `public overEmailLimitAction` → `String`


##### `public preQuoteSignature` → `Boolean`


##### `public routingAddresses` → `MetadataService.EmailToCaseRoutingAddress`


##### `public unauthorizedSenderAction` → `String`


##### `private enableE2CSourceTracking_type_info` → `String`


##### `private enableEmailToCase_type_info` → `String`


##### `private enableHtmlEmail_type_info` → `String`


##### `private enableOnDemandEmailToCase_type_info` → `String`


##### `private enableThreadIDInBody_type_info` → `String`


##### `private enableThreadIDInSubject_type_info` → `String`


##### `private notifyOwnerOnNewCaseEmail_type_info` → `String`


##### `private overEmailLimitAction_type_info` → `String`


##### `private preQuoteSignature_type_info` → `String`


##### `private routingAddresses_type_info` → `String`


##### `private unauthorizedSenderAction_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowSubflowOutputAssignment

**Inheritance**

FlowSubflowOutputAssignment

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public assignToReference` → `String`


##### `public name` → `String`


##### `private assignToReference_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SecuritySettings

**Inheritance**

SecuritySettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public networkAccess` → `MetadataService`


##### `public passwordPolicies` → `MetadataService`


##### `private networkAccess_type_info` → `String`


##### `private passwordPolicies_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportChart
#### Fields

##### `public backgroundColor1` → `String`


##### `public backgroundColor2` → `String`


##### `public backgroundFadeDir` → `String`


##### `public chartSummaries` → `MetadataService.ChartSummary`


##### `public chartType` → `String`


##### `public enableHoverLabels` → `Boolean`


##### `public expandOthers` → `Boolean`


##### `public groupingColumn` → `String`


##### `public legendPosition` → `String`


##### `public location` → `String`


##### `public secondaryGroupingColumn` → `String`


##### `public showAxisLabels` → `Boolean`


##### `public showPercentage` → `Boolean`


##### `public showTotal` → `Boolean`


##### `public showValues` → `Boolean`


##### `public size` → `String`


##### `public summaryAxisManualRangeEnd` → `Double`


##### `public summaryAxisManualRangeStart` → `Double`


##### `public summaryAxisRange` → `String`


##### `public textColor` → `String`


##### `public textSize` → `Integer`


##### `public title` → `String`


##### `public titleColor` → `String`


##### `public titleSize` → `Integer`


##### `private backgroundColor1_type_info` → `String`


##### `private backgroundColor2_type_info` → `String`


##### `private backgroundFadeDir_type_info` → `String`


##### `private chartSummaries_type_info` → `String`


##### `private chartType_type_info` → `String`


##### `private enableHoverLabels_type_info` → `String`


##### `private expandOthers_type_info` → `String`


##### `private groupingColumn_type_info` → `String`


##### `private legendPosition_type_info` → `String`


##### `private location_type_info` → `String`


##### `private secondaryGroupingColumn_type_info` → `String`


##### `private showAxisLabels_type_info` → `String`


##### `private showPercentage_type_info` → `String`


##### `private showTotal_type_info` → `String`


##### `private showValues_type_info` → `String`


##### `private size_type_info` → `String`


##### `private summaryAxisManualRangeEnd_type_info` → `String`


##### `private summaryAxisManualRangeStart_type_info` → `String`


##### `private summaryAxisRange_type_info` → `String`


##### `private textColor_type_info` → `String`


##### `private textSize_type_info` → `String`


##### `private title_type_info` → `String`


##### `private titleColor_type_info` → `String`


##### `private titleSize_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppMenuItem
#### Fields

##### `public name` → `String`


##### `public type_x` → `String`


##### `private name_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### TabLimitConfig
#### Fields

##### `public maxNumberOfPrimaryTabs` → `String`


##### `public maxNumberOfSubTabs` → `String`


##### `private maxNumberOfPrimaryTabs_type_info` → `String`


##### `private maxNumberOfSubTabs_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ObjectMapping
#### Fields

##### `public inputObject` → `String`


##### `public mappingFields` → `MetadataService.ObjectMappingField`


##### `public outputObject` → `String`


##### `private inputObject_type_info` → `String`


##### `private mappingFields_type_info` → `String`


##### `private outputObject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ModeratedEntityField
#### Fields

##### `public entityName` → `String`


##### `public fieldName` → `String`


##### `public keywordList` → `String`


##### `private entityName_type_info` → `String`


##### `private fieldName_type_info` → `String`


##### `private keywordList_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecordType

**Inheritance**

RecordType

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public businessProcess` → `String`


##### `public compactLayoutAssignment` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public picklistValues` → `MetadataService.RecordTypePicklistValue`


##### `private active_type_info` → `String`


##### `private businessProcess_type_info` → `String`


##### `private compactLayoutAssignment_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private picklistValues_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EventSubscription

**Inheritance**

EventSubscription

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public eventParameters` → `MetadataService.EventParameterMap`


##### `public eventType` → `String`


##### `public referenceData` → `String`


##### `private active_type_info` → `String`


##### `private eventParameters_type_info` → `String`


##### `private eventType_type_info` → `String`


##### `private referenceData_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldOverride
#### Fields

##### `public field` → `String`


##### `public formula` → `String`


##### `public literalValue` → `String`


##### `private field_type_info` → `String`


##### `private formula_type_info` → `String`


##### `private literalValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileTabVisibility
#### Fields

##### `public tab` → `String`


##### `public visibility` → `String`


##### `private tab_type_info` → `String`


##### `private visibility_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportCrossFilter
#### Fields

##### `public criteriaItems` → `MetadataService.ReportFilterItem`


##### `public operation` → `String`


##### `public primaryTableColumn` → `String`


##### `public relatedTable` → `String`


##### `public relatedTableJoinColumn` → `String`


##### `private criteriaItems_type_info` → `String`


##### `private operation_type_info` → `String`


##### `private primaryTableColumn_type_info` → `String`


##### `private relatedTable_type_info` → `String`


##### `private relatedTableJoinColumn_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LookupFilter
#### Fields

##### `public active` → `Boolean`


##### `public booleanFilter` → `String`


##### `public description` → `String`


##### `public errorMessage` → `String`


##### `public filterItems` → `MetadataService.FilterItem`


##### `public infoMessage` → `String`


##### `public isOptional` → `Boolean`


##### `private active_type_info` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private description_type_info` → `String`


##### `private errorMessage_type_info` → `String`


##### `private filterItems_type_info` → `String`


##### `private infoMessage_type_info` → `String`


##### `private isOptional_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### UiPlugin
#### Fields

##### `public description` → `String`


##### `public extensionPointIdentifier` → `String`


##### `public isEnabled` → `Boolean`


##### `public language` → `String`


##### `public masterLabel` → `String`


##### `private description_type_info` → `String`


##### `private extensionPointIdentifier_type_info` → `String`


##### `private isEnabled_type_info` → `String`


##### `private language_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppBrand
#### Fields

##### `public footerColor` → `String`


##### `public headerColor` → `String`


##### `public logo` → `String`


##### `public logoVersion` → `Integer`


##### `public shouldOverrideOrgTheme` → `Boolean`


##### `private footerColor_type_info` → `String`


##### `private headerColor_type_info` → `String`


##### `private logo_type_info` → `String`


##### `private logoVersion_type_info` → `String`


##### `private shouldOverrideOrgTheme_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowLoop

**Inheritance**

FlowLoop

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public assignNextValueToReference` → `String`


##### `public collectionReference` → `String`


##### `public iterationOrder` → `String`


##### `public nextValueConnector` → `MetadataService`


##### `public noMoreValuesConnector` → `MetadataService`


##### `private assignNextValueToReference_type_info` → `String`


##### `private collectionReference_type_info` → `String`


##### `private iterationOrder_type_info` → `String`


##### `private nextValueConnector_type_info` → `String`


##### `private noMoreValuesConnector_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowDefinition
#### Fields

##### `public activeVersionNumber` → `Integer`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `private activeVersionNumber_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReputationLevelDefinitions
#### Fields

##### `public level` → `MetadataService.ReputationLevel`


##### `private level_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomPageWebLink

**Inheritance**

CustomPageWebLink

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public availability` → `String`


##### `public description` → `String`


##### `public displayType` → `String`


##### `public encodingKey` → `String`


##### `public hasMenubar` → `Boolean`


##### `public hasScrollbars` → `Boolean`


##### `public hasToolbar` → `Boolean`


##### `public height` → `Integer`


##### `public isResizable` → `Boolean`


##### `public linkType` → `String`


##### `public masterLabel` → `String`


##### `public openType` → `String`


##### `public page_x` → `String`


##### `public position` → `String`


##### `public protected_x` → `Boolean`


##### `public requireRowSelection` → `Boolean`


##### `public scontrol` → `String`


##### `public showsLocation` → `Boolean`


##### `public showsStatus` → `Boolean`


##### `public url` → `String`


##### `public width` → `Integer`


##### `private availability_type_info` → `String`


##### `private description_type_info` → `String`


##### `private displayType_type_info` → `String`


##### `private encodingKey_type_info` → `String`


##### `private hasMenubar_type_info` → `String`


##### `private hasScrollbars_type_info` → `String`


##### `private hasToolbar_type_info` → `String`


##### `private height_type_info` → `String`


##### `private isResizable_type_info` → `String`


##### `private linkType_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private openType_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private position_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private requireRowSelection_type_info` → `String`


##### `private scontrol_type_info` → `String`


##### `private showsLocation_type_info` → `String`


##### `private showsStatus_type_info` → `String`


##### `private url_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardFlexTableComponentProperties
#### Fields

##### `public flexTableColumn` → `MetadataService.DashboardComponentColumn`


##### `public flexTableSortInfo` → `MetadataService`


##### `public hideChatterPhotos` → `Boolean`


##### `private flexTableColumn_type_info` → `String`


##### `private flexTableSortInfo_type_info` → `String`


##### `private hideChatterPhotos_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalAction
#### Fields

##### `public action` → `MetadataService.WorkflowActionReference`


##### `private action_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### IntegrationHubSettings
#### Fields

##### `public canonicalName` → `String`


##### `public canonicalNameBindingChar` → `String`


##### `public description` → `String`


##### `public isEnabled` → `Boolean`


##### `public isProtected` → `Boolean`


##### `public masterLabel` → `String`


##### `public setupData` → `String`


##### `public setupDefinition` → `String`


##### `public setupNamespace` → `String`


##### `public setupSimpleName` → `String`


##### `public uUID` → `String`


##### `public version` → `String`


##### `public versionBuild` → `Integer`


##### `public versionMajor` → `Integer`


##### `public versionMinor` → `Integer`


##### `private canonicalName_type_info` → `String`


##### `private canonicalNameBindingChar_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isEnabled_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private setupData_type_info` → `String`


##### `private setupDefinition_type_info` → `String`


##### `private setupNamespace_type_info` → `String`


##### `private setupSimpleName_type_info` → `String`


##### `private uUID_type_info` → `String`


##### `private version_type_info` → `String`


##### `private versionBuild_type_info` → `String`


##### `private versionMajor_type_info` → `String`


##### `private versionMinor_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingSet

**Inheritance**

SharingSet

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessMappings` → `MetadataService.AccessMapping`


##### `public description` → `String`


##### `public name` → `String`


##### `public profiles` → `String`


##### `private accessMappings_type_info` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `private profiles_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveTemplateBundle
#### Fields

##### `public assetIcon` → `String`


##### `public assetVersion` → `Double`


##### `public description` → `String`


##### `public label` → `String`


##### `public templateBadgeIcon` → `String`


##### `public templateDetailIcon` → `String`


##### `public templateType` → `String`


##### `private assetIcon_type_info` → `String`


##### `private assetVersion_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private templateBadgeIcon_type_info` → `String`


##### `private templateDetailIcon_type_info` → `String`


##### `private templateType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityThemeSetting
#### Fields

##### `public customThemeLayoutType` → `String`


##### `public themeLayout` → `String`


##### `public themeLayoutType` → `String`


##### `private customThemeLayoutType_type_info` → `String`


##### `private themeLayout_type_info` → `String`


##### `private themeLayoutType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LayoutColumn
#### Fields

##### `public layoutItems` → `MetadataService.LayoutItem`


##### `public reserved` → `String`


##### `private layoutItems_type_info` → `String`


##### `private reserved_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Error
#### Fields

##### `public extendedErrorDetails` → `MetadataService.ExtendedErrorDetails`


##### `public fields` → `String`


##### `public message` → `String`


##### `public statusCode` → `String`


##### `private extendedErrorDetails_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private message_type_info` → `String`


##### `private statusCode_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2RuleItem
#### Fields

##### `public field` → `String`


##### `public operation` → `String`


##### `public value` → `String`


##### `private field_type_info` → `String`


##### `private operation_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowStep

**Inheritance**

FlowStep

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public connectors` → `MetadataService.FlowConnector`


##### `private connectors_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### updateMetadata_element
#### Fields

##### `public metadata` → `MetadataService.Metadata`


##### `private metadata_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OrchestrationContext
#### Fields

##### `public description` → `String`


##### `public events` → `MetadataService.OrchestrationContextEvent`


##### `public masterLabel` → `String`


##### `public runtimeType` → `String`


##### `public salesforceObject` → `String`


##### `public salesforceObjectPrimaryKey` → `String`


##### `private description_type_info` → `String`


##### `private events_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private runtimeType_type_info` → `String`


##### `private salesforceObject_type_info` → `String`


##### `private salesforceObjectPrimaryKey_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AccountSettings

**Inheritance**

AccountSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableAccountOwnerReport` → `Boolean`


##### `public enableAccountTeams` → `Boolean`


##### `public showViewHierarchyLink` → `Boolean`


##### `private enableAccountOwnerReport_type_info` → `String`


##### `private enableAccountTeams_type_info` → `String`


##### `private showViewHierarchyLink_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ContentAssetVersion
#### Fields

##### `public number_x` → `String`


##### `public pathOnClient` → `String`


##### `public zipEntry` → `String`


##### `private number_x_type_info` → `String`


##### `private pathOnClient_type_info` → `String`


##### `private zipEntry_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CancelDeployResult
#### Fields

##### `public done` → `Boolean`


##### `public id` → `String`


##### `private done_type_info` → `String`


##### `private id_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AgentConfigUserAssignments
#### Fields

##### `public user_x` → `String`


##### `private user_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EventParameterMap
#### Fields

##### `public parameterName` → `String`


##### `public parameterValue` → `String`


##### `private parameterName_type_info` → `String`


##### `private parameterValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### TransactionSecurityAction
#### Fields

##### `public block` → `Boolean`


##### `public endSession` → `Boolean`


##### `public freezeUser` → `Boolean`


##### `public notifications` → `MetadataService.TransactionSecurityNotification`


##### `public twoFactorAuthentication` → `Boolean`


##### `private block_type_info` → `String`


##### `private endSession_type_info` → `String`


##### `private freezeUser_type_info` → `String`


##### `private notifications_type_info` → `String`


##### `private twoFactorAuthentication_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeWorkOrderLineItemField
#### Fields

##### `public name` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardFilterColumn
#### Fields

##### `public column` → `String`


##### `private column_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CspTrustedSite

**Inheritance**

CspTrustedSite

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public endpointUrl` → `String`


##### `public isActive` → `Boolean`


##### `private description_type_info` → `String`


##### `private endpointUrl_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowVariable

**Inheritance**

FlowVariable

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public dataType` → `String`


##### `public isCollection` → `Boolean`


##### `public isInput` → `Boolean`


##### `public isOutput` → `Boolean`


##### `public objectType` → `String`


##### `public scale` → `Integer`


##### `public value` → `MetadataService`


##### `private dataType_type_info` → `String`


##### `private isCollection_type_info` → `String`


##### `private isInput_type_info` → `String`


##### `private isOutput_type_info` → `String`


##### `private objectType_type_info` → `String`


##### `private scale_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowCategory
#### Fields

##### `public description` → `String`


##### `public flowCategoryItems` → `MetadataService.FlowCategoryItems`


##### `public masterLabel` → `String`


##### `private description_type_info` → `String`


##### `private flowCategoryItems_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingTerritoryRule

**Inheritance**

SharingTerritoryRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessLevel` → `String`


##### `public accountSettings` → `MetadataService`


##### `public description` → `String`


##### `public label` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessLevel_type_info` → `String`


##### `private accountSettings_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowFlowActionParameter
#### Fields

##### `public name` → `String`


##### `public value` → `String`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ScontrolTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PlatformActionListItem
#### Fields

##### `public actionName` → `String`


##### `public actionType` → `String`


##### `public sortOrder` → `Integer`


##### `public subtype` → `String`


##### `private actionName_type_info` → `String`


##### `private actionType_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private subtype_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CallOptions_element
#### Fields

##### `public client` → `String`


##### `private client_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalEntryCriteria
#### Fields

##### `public booleanFilter` → `String`


##### `public criteriaItems` → `MetadataService.FilterItem`


##### `public formula` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private criteriaItems_type_info` → `String`


##### `private formula_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CallCenterItem
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `public value` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Document

**Inheritance**

Document

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public description` → `String`


##### `public internalUseOnly` → `Boolean`


##### `public keywords` → `String`


##### `public name` → `String`


##### `public public_x` → `Boolean`


##### `private description_type_info` → `String`


##### `private internalUseOnly_type_info` → `String`


##### `private keywords_type_info` → `String`


##### `private name_type_info` → `String`


##### `private public_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LightningBolt
#### Fields

##### `public category` → `String`


##### `public lightningBoltFeatures` → `MetadataService.LightningBoltFeatures`


##### `public lightningBoltImages` → `MetadataService.LightningBoltImages`


##### `public lightningBoltItems` → `MetadataService.LightningBoltItems`


##### `public masterLabel` → `String`


##### `public publisher` → `String`


##### `public summary` → `String`


##### `private category_type_info` → `String`


##### `private lightningBoltFeatures_type_info` → `String`


##### `private lightningBoltImages_type_info` → `String`


##### `private lightningBoltItems_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private publisher_type_info` → `String`


##### `private summary_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### upsertMetadata_element
#### Fields

##### `public metadata` → `MetadataService.Metadata`


##### `private metadata_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileExternalDataSourceAccess
#### Fields

##### `public enabled` → `Boolean`


##### `public externalDataSource` → `String`


##### `private enabled_type_info` → `String`


##### `private externalDataSource_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValueTypeField
#### Fields

##### `public fields` → `MetadataService.ValueTypeField`


##### `public foreignKeyDomain` → `String`


##### `public isForeignKey` → `Boolean`


##### `public isNameField` → `Boolean`


##### `public minOccurs` → `Integer`


##### `public name` → `String`


##### `public picklistValues` → `MetadataService.PicklistEntry`


##### `public soapType` → `String`


##### `public valueRequired` → `Boolean`


##### `private fields_type_info` → `String`


##### `private foreignKeyDomain_type_info` → `String`


##### `private isForeignKey_type_info` → `String`


##### `private isNameField_type_info` → `String`


##### `private minOccurs_type_info` → `String`


##### `private name_type_info` → `String`


##### `private picklistValues_type_info` → `String`


##### `private soapType_type_info` → `String`


##### `private valueRequired_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowAssignmentItem

**Inheritance**

FlowAssignmentItem

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public assignToReference` → `String`


##### `public operator` → `String`


##### `public value` → `MetadataService`


##### `private assignToReference_type_info` → `String`


##### `private operator_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### GlobalPicklistValue

**Inheritance**

GlobalPicklistValue

#### Fields

##### `public color` → `String`


##### `public default_x` → `Boolean`


##### `public description` → `String`


##### `public isActive` → `Boolean`


---

### EmailFolder

**Inheritance**

EmailFolder

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessType` → `String`


##### `public folderShares` → `MetadataService.FolderShare`


##### `public name` → `String`


##### `public publicFolderAccess` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessType_type_info` → `String`


##### `private folderShares_type_info` → `String`


##### `private name_type_info` → `String`


##### `private publicFolderAccess_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### renameMetadata_element
#### Fields

##### `public type_x` → `String`


##### `public oldFullName` → `String`


##### `public newFullName` → `String`


##### `private type_x_type_info` → `String`


##### `private oldFullName_type_info` → `String`


##### `private newFullName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DelegateGroup

**Inheritance**

DelegateGroup

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public customObjects` → `String`


##### `public groups` → `String`


##### `public label` → `String`


##### `public loginAccess` → `Boolean`


##### `public permissionSets` → `String`


##### `public profiles` → `String`


##### `public roles` → `String`


##### `private customObjects_type_info` → `String`


##### `private groups_type_info` → `String`


##### `private label_type_info` → `String`


##### `private loginAccess_type_info` → `String`


##### `private permissionSets_type_info` → `String`


##### `private profiles_type_info` → `String`


##### `private roles_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PicklistValue

**Inheritance**

PicklistValue

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public color` → `String`


##### `public default_x` → `Boolean`


##### `public description` → `String`


##### `public isActive` → `Boolean`


##### `private color_type_info` → `String`


##### `private default_x_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `public allowEmail` → `Boolean`


##### `public closed` → `Boolean`


##### `public controllingFieldValues` → `String`


##### `public converted` → `Boolean`


##### `public cssExposed` → `Boolean`


##### `public forecastCategory` → `String`


##### `public highPriority` → `Boolean`


##### `public probability` → `Integer`


##### `public reverseRole` → `String`


##### `public reviewed` → `Boolean`


##### `public won` → `Boolean`


##### `private allowEmail_type_info` → `String`


##### `private closed_type_info` → `String`


##### `private controllingFieldValues_type_info` → `String`


##### `private converted_type_info` → `String`


##### `private cssExposed_type_info` → `String`


##### `private forecastCategory_type_info` → `String`


##### `private highPriority_type_info` → `String`


##### `private probability_type_info` → `String`


##### `private reverseRole_type_info` → `String`


##### `private reviewed_type_info` → `String`


##### `private won_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SkillProfileAssignments
#### Fields

##### `public profile` → `String`


##### `private profile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EscalationAction
#### Fields

##### `public assignedTo` → `String`


##### `public assignedToTemplate` → `String`


##### `public assignedToType` → `String`


##### `public minutesToEscalation` → `Integer`


##### `public notifyCaseOwner` → `Boolean`


##### `public notifyEmail` → `String`


##### `public notifyTo` → `String`


##### `public notifyToTemplate` → `String`


##### `private assignedTo_type_info` → `String`


##### `private assignedToTemplate_type_info` → `String`


##### `private assignedToType_type_info` → `String`


##### `private minutesToEscalation_type_info` → `String`


##### `private notifyCaseOwner_type_info` → `String`


##### `private notifyEmail_type_info` → `String`


##### `private notifyTo_type_info` → `String`


##### `private notifyToTemplate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CaseSubjectParticle

**Inheritance**

CaseSubjectParticle

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public index` → `Integer`


##### `public textField` → `String`


##### `public type_x` → `String`


##### `private index_type_info` → `String`


##### `private textField_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdDimensionSalesforceAction
#### Fields

##### `public enabled` → `Boolean`


##### `public salesforceActionName` → `String`


##### `public sortIndex` → `Integer`


##### `private enabled_type_info` → `String`


##### `private salesforceActionName_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Workflow

**Inheritance**

Workflow

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public alerts` → `MetadataService.WorkflowAlert`


##### `public fieldUpdates` → `MetadataService.WorkflowFieldUpdate`


##### `public flowActions` → `MetadataService.WorkflowFlowAction`


##### `public knowledgePublishes` → `MetadataService.WorkflowKnowledgePublish`


##### `public outboundMessages` → `MetadataService.WorkflowOutboundMessage`


##### `public rules` → `MetadataService.WorkflowRule`


##### `public send` → `MetadataService.WorkflowSend`


##### `public tasks` → `MetadataService.WorkflowTask`


##### `private alerts_type_info` → `String`


##### `private fieldUpdates_type_info` → `String`


##### `private flowActions_type_info` → `String`


##### `private knowledgePublishes_type_info` → `String`


##### `private outboundMessages_type_info` → `String`


##### `private rules_type_info` → `String`


##### `private send_type_info` → `String`


##### `private tasks_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Roles
#### Fields

##### `public role` → `String`


##### `private role_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowKnowledgePublish

**Inheritance**

WorkflowKnowledgePublish

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public action` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public language` → `String`


##### `public protected_x` → `Boolean`


##### `private action_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private language_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomFieldTranslation
#### Fields

##### `public caseValues` → `MetadataService.ObjectNameCaseValue`


##### `public gender` → `String`


##### `public help` → `String`


##### `public label` → `String`


##### `public lookupFilter` → `MetadataService`


##### `public name` → `String`


##### `public picklistValues` → `MetadataService.PicklistValueTranslation`


##### `public relationshipLabel` → `String`


##### `public startsWith` → `String`


##### `private caseValues_type_info` → `String`


##### `private gender_type_info` → `String`


##### `private help_type_info` → `String`


##### `private label_type_info` → `String`


##### `private lookupFilter_type_info` → `String`


##### `private name_type_info` → `String`


##### `private picklistValues_type_info` → `String`


##### `private relationshipLabel_type_info` → `String`


##### `private startsWith_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FileTypeDispositionAssignmentBean
#### Fields

##### `public behavior` → `String`


##### `public fileType` → `String`


##### `public securityRiskFileType` → `Boolean`


##### `private behavior_type_info` → `String`


##### `private fileType_type_info` → `String`


##### `private securityRiskFileType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppWorkspaceConfig
#### Fields

##### `public mappings` → `MetadataService.WorkspaceMapping`


##### `private mappings_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ScheduledRecommendationDetail
#### Fields

##### `public channel` → `String`


##### `public enabled` → `Boolean`


##### `public rank` → `Integer`


##### `public recommendationAudience` → `String`


##### `private channel_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private rank_type_info` → `String`


##### `private recommendationAudience_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### UiFormulaRule
#### Fields

##### `public booleanFilter` → `String`


##### `public criteria` → `MetadataService.UiFormulaCriterion`


##### `private booleanFilter_type_info` → `String`


##### `private criteria_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### VisualizationPlugin

**Inheritance**

VisualizationPlugin

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public developerName` → `String`


##### `public icon` → `String`


##### `public masterLabel` → `String`


##### `public visualizationResources` → `MetadataService.VisualizationResource`


##### `public visualizationTypes` → `MetadataService.VisualizationType`


##### `private description_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private icon_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private visualizationResources_type_info` → `String`


##### `private visualizationTypes_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DataPipeline
#### Fields

##### `public apiVersion` → `Double`


##### `public label` → `String`


##### `public scriptType` → `String`


##### `private apiVersion_type_info` → `String`


##### `private label_type_info` → `String`


##### `private scriptType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QueueSobject
#### Fields

##### `public sobjectType` → `String`


##### `private sobjectType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApexClass

**Inheritance**

ApexClass

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public apiVersion` → `Double`


##### `public packageVersions` → `MetadataService.PackageVersion`


##### `public status` → `String`


##### `private apiVersion_type_info` → `String`


##### `private packageVersions_type_info` → `String`


##### `private status_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldMappingRow
#### Fields

##### `public SObjectType` → `String`


##### `public fieldMappingFields` → `MetadataService.FieldMappingField`


##### `public fieldName` → `String`


##### `public mappingOperation` → `String`


##### `private SObjectType_type_info` → `String`


##### `private fieldMappingFields_type_info` → `String`


##### `private fieldName_type_info` → `String`


##### `private mappingOperation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EntitlementTemplate

**Inheritance**

EntitlementTemplate

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public businessHours` → `String`


##### `public casesPerEntitlement` → `Integer`


##### `public entitlementProcess` → `String`


##### `public isPerIncident` → `Boolean`


##### `public term` → `Integer`


##### `public type_x` → `String`


##### `private businessHours_type_info` → `String`


##### `private casesPerEntitlement_type_info` → `String`


##### `private entitlementProcess_type_info` → `String`


##### `private isPerIncident_type_info` → `String`


##### `private term_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Group_x

**Inheritance**

Group_x

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public doesIncludeBosses` → `Boolean`


##### `public name` → `String`


##### `private doesIncludeBosses_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdRecordDisplayLookup
#### Fields

##### `public recordDisplayField` → `String`


##### `private recordDisplayField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### IntegrationHubSettingsType
#### Fields

##### `public canonicalName` → `String`


##### `public canonicalNameBindingChar` → `String`


##### `public description` → `String`


##### `public isEnabled` → `Boolean`


##### `public isProtected` → `Boolean`


##### `public masterLabel` → `String`


##### `public setupNamespace` → `String`


##### `public setupSimpleName` → `String`


##### `public uUID` → `String`


##### `public version` → `String`


##### `public versionBuild` → `Integer`


##### `public versionMajor` → `Integer`


##### `public versionMinor` → `Integer`


##### `private canonicalName_type_info` → `String`


##### `private canonicalNameBindingChar_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isEnabled_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private setupNamespace_type_info` → `String`


##### `private setupSimpleName_type_info` → `String`


##### `private uUID_type_info` → `String`


##### `private version_type_info` → `String`


##### `private versionBuild_type_info` → `String`


##### `private versionMajor_type_info` → `String`


##### `private versionMinor_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeLanguageSettings
#### Fields

##### `public language` → `MetadataService.KnowledgeLanguage`


##### `private language_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeCaseField
#### Fields

##### `public name` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Metadata
#### Fields

##### `public fullName` → `String`


---

### DebuggingHeader_element
#### Fields

##### `public categories` → `MetadataService.LogInfo`


##### `public debugLevel` → `String`


##### `private categories_type_info` → `String`


##### `private debugLevel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalPageField
#### Fields

##### `public field` → `String`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetApexPageAccess
#### Fields

##### `public apexPage` → `String`


##### `public enabled` → `Boolean`


##### `private apexPage_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomExperience
#### Fields

##### `public allowInternalUserLogin` → `Boolean`


##### `public branding` → `MetadataService`


##### `public changePasswordEmailTemplate` → `String`


##### `public emailFooterLogo` → `String`


##### `public emailFooterText` → `String`


##### `public emailSenderAddress` → `String`


##### `public emailSenderName` → `String`


##### `public enableErrorPageOverridesForVisualforce` → `Boolean`


##### `public forgotPasswordEmailTemplate` → `String`


##### `public picassoSite` → `String`


##### `public sObjectType` → `String`


##### `public sendWelcomeEmail` → `Boolean`


##### `public site` → `String`


##### `public siteAsContainerEnabled` → `Boolean`


##### `public tabs` → `MetadataService`


##### `public urlPathPrefix` → `String`


##### `public welcomeEmailTemplate` → `String`


##### `private allowInternalUserLogin_type_info` → `String`


##### `private branding_type_info` → `String`


##### `private changePasswordEmailTemplate_type_info` → `String`


##### `private emailFooterLogo_type_info` → `String`


##### `private emailFooterText_type_info` → `String`


##### `private emailSenderAddress_type_info` → `String`


##### `private emailSenderName_type_info` → `String`


##### `private enableErrorPageOverridesForVisualforce_type_info` → `String`


##### `private forgotPasswordEmailTemplate_type_info` → `String`


##### `private picassoSite_type_info` → `String`


##### `private sObjectType_type_info` → `String`


##### `private sendWelcomeEmail_type_info` → `String`


##### `private site_type_info` → `String`


##### `private siteAsContainerEnabled_type_info` → `String`


##### `private tabs_type_info` → `String`


##### `private urlPathPrefix_type_info` → `String`


##### `private welcomeEmailTemplate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ExternalServiceRegistration

**Inheritance**

ExternalServiceRegistration

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public namedCredential` → `String`


##### `public schema` → `String`


##### `public schemaType` → `String`


##### `public schemaUrl` → `String`


##### `public status` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private namedCredential_type_info` → `String`


##### `private schema_type_info` → `String`


##### `private schemaType_type_info` → `String`


##### `private schemaUrl_type_info` → `String`


##### `private status_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowChoice

**Inheritance**

FlowChoice

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public choiceText` → `String`


##### `public dataType` → `String`


##### `public userInput` → `MetadataService`


##### `public value` → `MetadataService`


##### `private choiceText_type_info` → `String`


##### `private dataType_type_info` → `String`


##### `private userInput_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdDimensionMember
#### Fields

##### `public color` → `String`


##### `public label` → `String`


##### `public member` → `String`


##### `public sortIndex` → `Integer`


##### `private color_type_info` → `String`


##### `private label_type_info` → `String`


##### `private member_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CanvasMetadata
#### Fields

##### `public accessMethod` → `String`


##### `public canvasOptions` → `String`


##### `public canvasUrl` → `String`


##### `public lifecycleClass` → `String`


##### `public locationOptions` → `String`


##### `public samlInitiationMethod` → `String`


##### `private accessMethod_type_info` → `String`


##### `private canvasOptions_type_info` → `String`


##### `private canvasUrl_type_info` → `String`


##### `private lifecycleClass_type_info` → `String`


##### `private locationOptions_type_info` → `String`


##### `private samlInitiationMethod_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedApp

**Inheritance**

ConnectedApp

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public attributes` → `MetadataService.ConnectedAppAttribute`


##### `public canvas` → `MetadataService`


##### `public canvasConfig` → `MetadataService`


##### `public contactEmail` → `String`


##### `public contactPhone` → `String`


##### `public description` → `String`


##### `public iconUrl` → `String`


##### `public infoUrl` → `String`


##### `public ipRanges` → `MetadataService.ConnectedAppIpRange`


##### `public label` → `String`


##### `public logoUrl` → `String`


##### `public mobileAppConfig` → `MetadataService`


##### `public mobileStartUrl` → `String`


##### `public oauthConfig` → `MetadataService`


##### `public oauthPolicy` → `MetadataService`


##### `public permissionSetName` → `String`


##### `public plugin` → `String`


##### `public pluginExecutionUser` → `String`


##### `public profileName` → `String`


##### `public samlConfig` → `MetadataService`


##### `public sessionPolicy` → `MetadataService`


##### `public startUrl` → `String`


##### `private attributes_type_info` → `String`


##### `private canvas_type_info` → `String`


##### `private canvasConfig_type_info` → `String`


##### `private contactEmail_type_info` → `String`


##### `private contactPhone_type_info` → `String`


##### `private description_type_info` → `String`


##### `private iconUrl_type_info` → `String`


##### `private infoUrl_type_info` → `String`


##### `private ipRanges_type_info` → `String`


##### `private label_type_info` → `String`


##### `private logoUrl_type_info` → `String`


##### `private mobileAppConfig_type_info` → `String`


##### `private mobileStartUrl_type_info` → `String`


##### `private oauthConfig_type_info` → `String`


##### `private oauthPolicy_type_info` → `String`


##### `private permissionSetName_type_info` → `String`


##### `private plugin_type_info` → `String`


##### `private pluginExecutionUser_type_info` → `String`


##### `private profileName_type_info` → `String`


##### `private samlConfig_type_info` → `String`


##### `private sessionPolicy_type_info` → `String`


##### `private startUrl_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppSettings
#### Fields

##### `public enableAdminApprovedAppsOnly` → `Boolean`


##### `public enableAdminApprovedAppsOnlyForExternalUser` → `Boolean`


##### `public enableSkipUserProvisioningWizardWelcomePage` → `Boolean`


##### `private enableAdminApprovedAppsOnly_type_info` → `String`


##### `private enableAdminApprovedAppsOnlyForExternalUser_type_info` → `String`


##### `private enableSkipUserProvisioningWizardWelcomePage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppOauthAssetToken
#### Fields

##### `public assetAudiences` → `String`


##### `public assetIncludeAttributes` → `Boolean`


##### `public assetIncludeCustomPerms` → `Boolean`


##### `public assetSigningCertId` → `String`


##### `public assetValidityPeriod` → `Integer`


##### `private assetAudiences_type_info` → `String`


##### `private assetIncludeAttributes_type_info` → `String`


##### `private assetIncludeCustomPerms_type_info` → `String`


##### `private assetSigningCertId_type_info` → `String`


##### `private assetValidityPeriod_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### describeMetadata_element
#### Fields

##### `public asOfVersion` → `Double`


##### `private asOfVersion_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LayoutItem
#### Fields

##### `public analyticsCloudComponent` → `MetadataService`


##### `public behavior` → `String`


##### `public canvas` → `String`


##### `public component` → `String`


##### `public customLink` → `String`


##### `public emptySpace` → `Boolean`


##### `public field` → `String`


##### `public height` → `Integer`


##### `public page_x` → `String`


##### `public reportChartComponent` → `MetadataService`


##### `public scontrol` → `String`


##### `public showLabel` → `Boolean`


##### `public showScrollbars` → `Boolean`


##### `public width` → `String`


##### `private analyticsCloudComponent_type_info` → `String`


##### `private behavior_type_info` → `String`


##### `private canvas_type_info` → `String`


##### `private component_type_info` → `String`


##### `private customLink_type_info` → `String`


##### `private emptySpace_type_info` → `String`


##### `private field_type_info` → `String`


##### `private height_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private reportChartComponent_type_info` → `String`


##### `private scontrol_type_info` → `String`


##### `private showLabel_type_info` → `String`


##### `private showScrollbars_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Portal

**Inheritance**

Portal

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public admin` → `String`


##### `public defaultLanguage` → `String`


##### `public description` → `String`


##### `public emailSenderAddress` → `String`


##### `public emailSenderName` → `String`


##### `public enableSelfCloseCase` → `Boolean`


##### `public footerDocument` → `String`


##### `public forgotPassTemplate` → `String`


##### `public headerDocument` → `String`


##### `public isSelfRegistrationActivated` → `Boolean`


##### `public loginHeaderDocument` → `String`


##### `public logoDocument` → `String`


##### `public logoutUrl` → `String`


##### `public newCommentTemplate` → `String`


##### `public newPassTemplate` → `String`


##### `public newUserTemplate` → `String`


##### `public ownerNotifyTemplate` → `String`


##### `public selfRegNewUserUrl` → `String`


##### `public selfRegUserDefaultProfile` → `String`


##### `public selfRegUserDefaultRole` → `String`


##### `public selfRegUserTemplate` → `String`


##### `public showActionConfirmation` → `Boolean`


##### `public stylesheetDocument` → `String`


##### `public type_x` → `String`


##### `private active_type_info` → `String`


##### `private admin_type_info` → `String`


##### `private defaultLanguage_type_info` → `String`


##### `private description_type_info` → `String`


##### `private emailSenderAddress_type_info` → `String`


##### `private emailSenderName_type_info` → `String`


##### `private enableSelfCloseCase_type_info` → `String`


##### `private footerDocument_type_info` → `String`


##### `private forgotPassTemplate_type_info` → `String`


##### `private headerDocument_type_info` → `String`


##### `private isSelfRegistrationActivated_type_info` → `String`


##### `private loginHeaderDocument_type_info` → `String`


##### `private logoDocument_type_info` → `String`


##### `private logoutUrl_type_info` → `String`


##### `private newCommentTemplate_type_info` → `String`


##### `private newPassTemplate_type_info` → `String`


##### `private newUserTemplate_type_info` → `String`


##### `private ownerNotifyTemplate_type_info` → `String`


##### `private selfRegNewUserUrl_type_info` → `String`


##### `private selfRegUserDefaultProfile_type_info` → `String`


##### `private selfRegUserDefaultRole_type_info` → `String`


##### `private selfRegUserTemplate_type_info` → `String`


##### `private showActionConfirmation_type_info` → `String`


##### `private stylesheetDocument_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ContentAssetVersions
#### Fields

##### `public version` → `MetadataService.ContentAssetVersion`


##### `private version_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RunTestSuccess
#### Fields

##### `public id` → `String`


##### `public methodName` → `String`


##### `public name` → `String`


##### `public namespace` → `String`


##### `public seeAllData` → `Boolean`


##### `public time_x` → `Double`


##### `private id_type_info` → `String`


##### `private methodName_type_info` → `String`


##### `private name_type_info` → `String`


##### `private namespace_type_info` → `String`


##### `private seeAllData_type_info` → `String`


##### `private time_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetExternalDataSourceAccess
#### Fields

##### `public enabled` → `Boolean`


##### `public externalDataSource` → `String`


##### `private enabled_type_info` → `String`


##### `private externalDataSource_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomDataType

**Inheritance**

CustomDataType

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public customDataTypeComponents` → `MetadataService.CustomDataTypeComponent`


##### `public description` → `String`


##### `public displayFormula` → `String`


##### `public editComponentsOnSeparateLines` → `Boolean`


##### `public label` → `String`


##### `public rightAligned` → `Boolean`


##### `public supportComponentsInReports` → `Boolean`


##### `private customDataTypeComponents_type_info` → `String`


##### `private description_type_info` → `String`


##### `private displayFormula_type_info` → `String`


##### `private editComponentsOnSeparateLines_type_info` → `String`


##### `private label_type_info` → `String`


##### `private rightAligned_type_info` → `String`


##### `private supportComponentsInReports_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowConnector

**Inheritance**

FlowConnector

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public targetReference` → `String`


##### `private targetReference_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EventDelivery

**Inheritance**

EventDelivery

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public eventParameters` → `MetadataService.EventParameterMap`


##### `public eventSubscription` → `String`


##### `public referenceData` → `String`


##### `public type_x` → `String`


##### `private eventParameters_type_info` → `String`


##### `private eventSubscription_type_info` → `String`


##### `private referenceData_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveMessageSettings
#### Fields

##### `public enableLiveMessage` → `Boolean`


##### `private enableLiveMessage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ListMetadataQuery
#### Fields

##### `public folder` → `String`


##### `public type_x` → `String`


##### `private folder_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LogInfo
#### Fields

##### `public category` → `String`


##### `public level` → `String`


##### `private category_type_info` → `String`


##### `private level_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharedTo
#### Fields

##### `public allCustomerPortalUsers` → `String`


##### `public allInternalUsers` → `String`


##### `public allPartnerUsers` → `String`


##### `public channelProgramGroup` → `String`


##### `public channelProgramGroups` → `String`


##### `public group_x` → `String`


##### `public groups` → `String`


##### `public managerSubordinates` → `String`


##### `public managers` → `String`


##### `public portalRole` → `String`


##### `public portalRoleAndSubordinates` → `String`


##### `public queue` → `String`


##### `public role` → `String`


##### `public roleAndSubordinates` → `String`


##### `public roleAndSubordinatesInternal` → `String`


##### `public roles` → `String`


##### `public rolesAndSubordinates` → `String`


##### `public territories` → `String`


##### `public territoriesAndSubordinates` → `String`


##### `public territory` → `String`


##### `public territoryAndSubordinates` → `String`


##### `private allCustomerPortalUsers_type_info` → `String`


##### `private allInternalUsers_type_info` → `String`


##### `private allPartnerUsers_type_info` → `String`


##### `private channelProgramGroup_type_info` → `String`


##### `private channelProgramGroups_type_info` → `String`


##### `private group_x_type_info` → `String`


##### `private groups_type_info` → `String`


##### `private managerSubordinates_type_info` → `String`


##### `private managers_type_info` → `String`


##### `private portalRole_type_info` → `String`


##### `private portalRoleAndSubordinates_type_info` → `String`


##### `private queue_type_info` → `String`


##### `private role_type_info` → `String`


##### `private roleAndSubordinates_type_info` → `String`


##### `private roleAndSubordinatesInternal_type_info` → `String`


##### `private roles_type_info` → `String`


##### `private rolesAndSubordinates_type_info` → `String`


##### `private territories_type_info` → `String`


##### `private territoriesAndSubordinates_type_info` → `String`


##### `private territory_type_info` → `String`


##### `private territoryAndSubordinates_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PlatformCachePartitionType
#### Fields

##### `public allocatedCapacity` → `Integer`


##### `public allocatedPurchasedCapacity` → `Integer`


##### `public allocatedTrialCapacity` → `Integer`


##### `public cacheType` → `String`


##### `private allocatedCapacity_type_info` → `String`


##### `private allocatedPurchasedCapacity_type_info` → `String`


##### `private allocatedTrialCapacity_type_info` → `String`


##### `private cacheType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReputationPointsRule
#### Fields

##### `public eventType` → `String`


##### `public points` → `Integer`


##### `private eventType_type_info` → `String`


##### `private points_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowRecordLookup

**Inheritance**

FlowRecordLookup

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public assignNullValuesIfNoRecordsFound` → `Boolean`


##### `public connector` → `MetadataService`


##### `public faultConnector` → `MetadataService`


##### `public filters` → `MetadataService.FlowRecordFilter`


##### `public object_x` → `String`


##### `public outputAssignments` → `MetadataService.FlowOutputFieldAssignment`


##### `public outputReference` → `String`


##### `public queriedFields` → `String`


##### `public sortField` → `String`


##### `public sortOrder` → `String`


##### `private assignNullValuesIfNoRecordsFound_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private filters_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private outputAssignments_type_info` → `String`


##### `private outputReference_type_info` → `String`


##### `private queriedFields_type_info` → `String`


##### `private sortField_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionLayoutColumn
#### Fields

##### `public quickActionLayoutItems` → `MetadataService.QuickActionLayoutItem`


##### `private quickActionLayoutItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ForecastingDisplayedFamilySettings
#### Fields

##### `public productFamily` → `String`


##### `private productFamily_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReputationBranding
#### Fields

##### `public smallImage` → `String`


##### `private smallImage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReputationLevel
#### Fields

##### `public branding` → `MetadataService`


##### `public label` → `String`


##### `public lowerThreshold` → `Double`


##### `private branding_type_info` → `String`


##### `private label_type_info` → `String`


##### `private lowerThreshold_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ContentAssetRelationships
#### Fields

##### `public insightsApplication` → `MetadataService.ContentAssetLink`


##### `public network` → `MetadataService.ContentAssetLink`


##### `public organization` → `MetadataService`


##### `public workspace` → `MetadataService.ContentAssetLink`


##### `private insightsApplication_type_info` → `String`


##### `private network_type_info` → `String`


##### `private organization_type_info` → `String`


##### `private workspace_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileLayoutAssignment
#### Fields

##### `public layout` → `String`


##### `public recordType` → `String`


##### `private layout_type_info` → `String`


##### `private recordType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportTypeTranslation
#### Fields

##### `public description` → `String`


##### `public label` → `String`


##### `public name` → `String`


##### `public sections` → `MetadataService.ReportTypeSectionTranslation`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private sections_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ActionLinkGroupTemplate

**Inheritance**

ActionLinkGroupTemplate

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public actionLinkTemplates` → `MetadataService.ActionLinkTemplate`


##### `public category` → `String`


##### `public executionsAllowed` → `String`


##### `public hoursUntilExpiration` → `Integer`


##### `public isPublished` → `Boolean`


##### `public name` → `String`


##### `private actionLinkTemplates_type_info` → `String`


##### `private category_type_info` → `String`


##### `private executionsAllowed_type_info` → `String`


##### `private hoursUntilExpiration_type_info` → `String`


##### `private isPublished_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportDataCategoryFilter
#### Fields

##### `public dataCategory` → `String`


##### `public dataCategoryGroup` → `String`


##### `public operator` → `String`


##### `private dataCategory_type_info` → `String`


##### `private dataCategoryGroup_type_info` → `String`


##### `private operator_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportBucketFieldSourceValue
#### Fields

##### `public from_x` → `String`


##### `public sourceValue` → `String`


##### `public to` → `String`


##### `private from_x_type_info` → `String`


##### `private sourceValue_type_info` → `String`


##### `private to_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValidationRuleTranslation
#### Fields

##### `public errorMessage` → `String`


##### `public name` → `String`


##### `private errorMessage_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DocumentFolder

**Inheritance**

DocumentFolder

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessType` → `String`


##### `public folderShares` → `MetadataService.FolderShare`


##### `public name` → `String`


##### `public publicFolderAccess` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessType_type_info` → `String`


##### `private folderShares_type_info` → `String`


##### `private name_type_info` → `String`


##### `private publicFolderAccess_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### createMetadataResponse_element
#### Fields

##### `public result` → `MetadataService.SaveResult`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Dashboard

**Inheritance**

Dashboard

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public backgroundEndColor` → `String`


##### `public backgroundFadeDirection` → `String`


##### `public backgroundStartColor` → `String`


##### `public chartTheme` → `String`


##### `public colorPalette` → `String`


##### `public dashboardChartTheme` → `String`


##### `public dashboardColorPalette` → `String`


##### `public dashboardFilters` → `MetadataService.DashboardFilter`


##### `public dashboardGridLayout` → `MetadataService`


##### `public dashboardResultRefreshedDate` → `String`


##### `public dashboardResultRunningUser` → `String`


##### `public dashboardType` → `String`


##### `public description` → `String`


##### `public folderName` → `String`


##### `public isGridLayout` → `Boolean`


##### `public leftSection` → `MetadataService`


##### `public middleSection` → `MetadataService`


##### `public numSubscriptions` → `Integer`


##### `public rightSection` → `MetadataService`


##### `public runningUser` → `String`


##### `public textColor` → `String`


##### `public title` → `String`


##### `public titleColor` → `String`


##### `public titleSize` → `Integer`


##### `private backgroundEndColor_type_info` → `String`


##### `private backgroundFadeDirection_type_info` → `String`


##### `private backgroundStartColor_type_info` → `String`


##### `private chartTheme_type_info` → `String`


##### `private colorPalette_type_info` → `String`


##### `private dashboardChartTheme_type_info` → `String`


##### `private dashboardColorPalette_type_info` → `String`


##### `private dashboardFilters_type_info` → `String`


##### `private dashboardGridLayout_type_info` → `String`


##### `private dashboardResultRefreshedDate_type_info` → `String`


##### `private dashboardResultRunningUser_type_info` → `String`


##### `private dashboardType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private folderName_type_info` → `String`


##### `private isGridLayout_type_info` → `String`


##### `private leftSection_type_info` → `String`


##### `private middleSection_type_info` → `String`


##### `private numSubscriptions_type_info` → `String`


##### `private rightSection_type_info` → `String`


##### `private runningUser_type_info` → `String`


##### `private textColor_type_info` → `String`


##### `private title_type_info` → `String`


##### `private titleColor_type_info` → `String`


##### `private titleSize_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PersonListSettings
#### Fields

##### `public enablePersonList` → `Boolean`


##### `private enablePersonList_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KeyboardShortcuts
#### Fields

##### `public customShortcuts` → `MetadataService.CustomShortcut`


##### `public defaultShortcuts` → `MetadataService.DefaultShortcut`


##### `private customShortcuts_type_info` → `String`


##### `private defaultShortcuts_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ManagedTopic
#### Fields

##### `public managedTopicType` → `String`


##### `public name` → `String`


##### `public parentName` → `String`


##### `public position` → `Integer`


##### `public topicDescription` → `String`


##### `private managedTopicType_type_info` → `String`


##### `private name_type_info` → `String`


##### `private parentName_type_info` → `String`


##### `private position_type_info` → `String`


##### `private topicDescription_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SkillAssignments
#### Fields

##### `public profiles` → `MetadataService`


##### `public users` → `MetadataService`


##### `private profiles_type_info` → `String`


##### `private users_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowEmailRecipient
#### Fields

##### `public field` → `String`


##### `public recipient` → `String`


##### `public type_x` → `String`


##### `private field_type_info` → `String`


##### `private recipient_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CodeCoverageResult
#### Fields

##### `public dmlInfo` → `MetadataService.CodeLocation`


##### `public id` → `String`


##### `public locationsNotCovered` → `MetadataService.CodeLocation`


##### `public methodInfo` → `MetadataService.CodeLocation`


##### `public name` → `String`


##### `public namespace` → `String`


##### `public numLocations` → `Integer`


##### `public numLocationsNotCovered` → `Integer`


##### `public soqlInfo` → `MetadataService.CodeLocation`


##### `public soslInfo` → `MetadataService.CodeLocation`


##### `public type_x` → `String`


##### `private dmlInfo_type_info` → `String`


##### `private id_type_info` → `String`


##### `private locationsNotCovered_type_info` → `String`


##### `private methodInfo_type_info` → `String`


##### `private name_type_info` → `String`


##### `private namespace_type_info` → `String`


##### `private numLocations_type_info` → `String`


##### `private numLocationsNotCovered_type_info` → `String`


##### `private soqlInfo_type_info` → `String`


##### `private soslInfo_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecordTypePicklistValue
#### Fields

##### `public picklist` → `String`


##### `public values` → `MetadataService.PicklistValue`


##### `private picklist_type_info` → `String`


##### `private values_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowApexPluginCall

**Inheritance**

FlowApexPluginCall

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public apexClass` → `String`


##### `public connector` → `MetadataService`


##### `public faultConnector` → `MetadataService`


##### `public inputParameters` → `MetadataService.FlowApexPluginCallInputParameter`


##### `public outputParameters` → `MetadataService.FlowApexPluginCallOutputParameter`


##### `private apexClass_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private inputParameters_type_info` → `String`


##### `private outputParameters_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Container
#### Fields

##### `public height` → `Integer`


##### `public isContainerAutoSizeEnabled` → `Boolean`


##### `public region` → `String`


##### `public sidebarComponents` → `MetadataService.SidebarComponent`


##### `public style` → `String`


##### `public unit` → `String`


##### `public width` → `Integer`


##### `private height_type_info` → `String`


##### `private isContainerAutoSizeEnabled_type_info` → `String`


##### `private region_type_info` → `String`


##### `private sidebarComponents_type_info` → `String`


##### `private style_type_info` → `String`


##### `private unit_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FeedLayout
#### Fields

##### `public autocollapsePublisher` → `Boolean`


##### `public compactFeed` → `Boolean`


##### `public feedFilterPosition` → `String`


##### `public feedFilters` → `MetadataService.FeedLayoutFilter`


##### `public fullWidthFeed` → `Boolean`


##### `public hideSidebar` → `Boolean`


##### `public highlightExternalFeedItems` → `Boolean`


##### `public leftComponents` → `MetadataService.FeedLayoutComponent`


##### `public rightComponents` → `MetadataService.FeedLayoutComponent`


##### `public useInlineFiltersInConsole` → `Boolean`


##### `private autocollapsePublisher_type_info` → `String`


##### `private compactFeed_type_info` → `String`


##### `private feedFilterPosition_type_info` → `String`


##### `private feedFilters_type_info` → `String`


##### `private fullWidthFeed_type_info` → `String`


##### `private hideSidebar_type_info` → `String`


##### `private highlightExternalFeedItems_type_info` → `String`


##### `private leftComponents_type_info` → `String`


##### `private rightComponents_type_info` → `String`


##### `private useInlineFiltersInConsole_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### NetworkAccess
#### Fields

##### `public ipRanges` → `MetadataService.IpRange`


##### `private ipRanges_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileActionOverride
#### Fields

##### `public actionName` → `String`


##### `public content` → `String`


##### `public formFactor` → `String`


##### `public pageOrSobjectType` → `String`


##### `public recordType` → `String`


##### `public type_x` → `String`


##### `private actionName_type_info` → `String`


##### `private content_type_info` → `String`


##### `private formFactor_type_info` → `String`


##### `private pageOrSobjectType_type_info` → `String`


##### `private recordType_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### IdeasSettings

**Inheritance**

IdeasSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableChatterProfile` → `Boolean`


##### `public enableIdeaThemes` → `Boolean`


##### `public enableIdeas` → `Boolean`


##### `public enableIdeasReputation` → `Boolean`


##### `public halfLife` → `Double`


##### `public ideasProfilePage` → `String`


##### `private enableChatterProfile_type_info` → `String`


##### `private enableIdeaThemes_type_info` → `String`


##### `private enableIdeas_type_info` → `String`


##### `private enableIdeasReputation_type_info` → `String`


##### `private halfLife_type_info` → `String`


##### `private ideasProfilePage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmailServicesFunction

**Inheritance**

EmailServicesFunction

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public apexClass` → `String`


##### `public attachmentOption` → `String`


##### `public authenticationFailureAction` → `String`


##### `public authorizationFailureAction` → `String`


##### `public authorizedSenders` → `String`


##### `public emailServicesAddresses` → `MetadataService.EmailServicesAddress`


##### `public errorRoutingAddress` → `String`


##### `public functionInactiveAction` → `String`


##### `public functionName` → `String`


##### `public isActive` → `Boolean`


##### `public isAuthenticationRequired` → `Boolean`


##### `public isErrorRoutingEnabled` → `Boolean`


##### `public isTextAttachmentsAsBinary` → `Boolean`


##### `public isTlsRequired` → `Boolean`


##### `public overLimitAction` → `String`


##### `private apexClass_type_info` → `String`


##### `private attachmentOption_type_info` → `String`


##### `private authenticationFailureAction_type_info` → `String`


##### `private authorizationFailureAction_type_info` → `String`


##### `private authorizedSenders_type_info` → `String`


##### `private emailServicesAddresses_type_info` → `String`


##### `private errorRoutingAddress_type_info` → `String`


##### `private functionInactiveAction_type_info` → `String`


##### `private functionName_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private isAuthenticationRequired_type_info` → `String`


##### `private isErrorRoutingEnabled_type_info` → `String`


##### `private isTextAttachmentsAsBinary_type_info` → `String`


##### `private isTlsRequired_type_info` → `String`


##### `private overLimitAction_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomDataTypeTranslation
#### Fields

##### `public components` → `MetadataService.CustomDataTypeComponentTranslation`


##### `public customDataTypeName` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `private components_type_info` → `String`


##### `private customDataTypeName_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### readMetadata_element
#### Fields

##### `public type_x` → `String`


##### `public fullNames` → `String`


##### `private type_x_type_info` → `String`


##### `private fullNames_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PostTemplate

**Inheritance**

PostTemplate

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public default_x` → `Boolean`


##### `public description` → `String`


##### `public fields` → `String`


##### `public label` → `String`


##### `private default_x_type_info` → `String`


##### `private description_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValueSet
#### Fields

##### `public controllingField` → `String`


##### `public restricted` → `Boolean`


##### `public valueSetDefinition` → `MetadataService`


##### `public valueSetName` → `String`


##### `public valueSettings` → `MetadataService.ValueSettings`


##### `private controllingField_type_info` → `String`


##### `private restricted_type_info` → `String`


##### `private valueSetDefinition_type_info` → `String`


##### `private valueSetName_type_info` → `String`


##### `private valueSettings_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### IndexField
#### Fields

##### `public name` → `String`


##### `public sortDirection` → `String`


##### `private name_type_info` → `String`


##### `private sortDirection_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionList
#### Fields

##### `public quickActionListItems` → `MetadataService.QuickActionListItem`


##### `private quickActionListItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlexiPageRegion
#### Fields

##### `public appendable` → `String`


##### `public componentInstances` → `MetadataService.ComponentInstance`


##### `public mode` → `String`


##### `public name` → `String`


##### `public prependable` → `String`


##### `public replaceable` → `String`


##### `public type_x` → `String`


##### `private appendable_type_info` → `String`


##### `private componentInstances_type_info` → `String`


##### `private mode_type_info` → `String`


##### `private name_type_info` → `String`


##### `private prependable_type_info` → `String`


##### `private replaceable_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PrimaryTabComponents
#### Fields

##### `public containers` → `MetadataService.Container`


##### `private containers_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory
#### Fields

##### `public accountAccessLevel` → `String`


##### `public parentTerritory` → `String`


##### `private accountAccessLevel_type_info` → `String`


##### `private parentTerritory_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### updateMetadataResponse_element
#### Fields

##### `public result` → `MetadataService.SaveResult`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FolderShare
#### Fields

##### `public accessLevel` → `String`


##### `public sharedTo` → `String`


##### `public sharedToType` → `String`


##### `private accessLevel_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private sharedToType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionListItem
#### Fields

##### `public quickActionName` → `String`


##### `private quickActionName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SiteDotCom

**Inheritance**

SiteDotCom

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public label` → `String`


##### `public siteType` → `String`


##### `private label_type_info` → `String`


##### `private siteType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### MobileSettings

**Inheritance**

MobileSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public chatterMobile` → `MetadataService`


##### `public dashboardMobile` → `MetadataService`


##### `public salesforceMobile` → `MetadataService`


##### `public touchMobile` → `MetadataService`


##### `private chatterMobile_type_info` → `String`


##### `private dashboardMobile_type_info` → `String`


##### `private salesforceMobile_type_info` → `String`


##### `private touchMobile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ObjectMappingField
#### Fields

##### `public inputField` → `String`


##### `public outputField` → `String`


##### `private inputField_type_info` → `String`


##### `private outputField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DescribeValueTypeResult
#### Fields

##### `public apiCreatable` → `Boolean`


##### `public apiDeletable` → `Boolean`


##### `public apiReadable` → `Boolean`


##### `public apiUpdatable` → `Boolean`


##### `public parentField` → `MetadataService`


##### `public valueTypeFields` → `MetadataService.ValueTypeField`


##### `private apiCreatable_type_info` → `String`


##### `private apiDeletable_type_info` → `String`


##### `private apiReadable_type_info` → `String`


##### `private apiUpdatable_type_info` → `String`


##### `private parentField_type_info` → `String`


##### `private valueTypeFields_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EntitlementSettings

**Inheritance**

EntitlementSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public assetLookupLimitedToActiveEntitlementsOnAccount` → `Boolean`


##### `public assetLookupLimitedToActiveEntitlementsOnContact` → `Boolean`


##### `public assetLookupLimitedToSameAccount` → `Boolean`


##### `public assetLookupLimitedToSameContact` → `Boolean`


##### `public enableEntitlementVersioning` → `Boolean`


##### `public enableEntitlements` → `Boolean`


##### `public entitlementLookupLimitedToActiveStatus` → `Boolean`


##### `public entitlementLookupLimitedToSameAccount` → `Boolean`


##### `public entitlementLookupLimitedToSameAsset` → `Boolean`


##### `public entitlementLookupLimitedToSameContact` → `Boolean`


##### `private assetLookupLimitedToActiveEntitlementsOnAccount_type_info` → `String`


##### `private assetLookupLimitedToActiveEntitlementsOnContact_type_info` → `String`


##### `private assetLookupLimitedToSameAccount_type_info` → `String`


##### `private assetLookupLimitedToSameContact_type_info` → `String`


##### `private enableEntitlementVersioning_type_info` → `String`


##### `private enableEntitlements_type_info` → `String`


##### `private entitlementLookupLimitedToActiveStatus_type_info` → `String`


##### `private entitlementLookupLimitedToSameAccount_type_info` → `String`


##### `private entitlementLookupLimitedToSameAsset_type_info` → `String`


##### `private entitlementLookupLimitedToSameContact_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2RuleAssociation
#### Fields

##### `public inherited` → `Boolean`


##### `public ruleName` → `String`


##### `private inherited_type_info` → `String`


##### `private ruleName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowChoiceTranslation
#### Fields

##### `public choiceText` → `String`


##### `public name` → `String`


##### `public userInput` → `MetadataService`


##### `private choiceText_type_info` → `String`


##### `private name_type_info` → `String`


##### `private userInput_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetCustomPermissions
#### Fields

##### `public enabled` → `Boolean`


##### `public name` → `String`


##### `private enabled_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomApplicationComponent

**Inheritance**

CustomApplicationComponent

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public buttonIconUrl` → `String`


##### `public buttonStyle` → `String`


##### `public buttonText` → `String`


##### `public buttonWidth` → `Integer`


##### `public height` → `Integer`


##### `public isHeightFixed` → `Boolean`


##### `public isHidden` → `Boolean`


##### `public isWidthFixed` → `Boolean`


##### `public visualforcePage` → `String`


##### `public width` → `Integer`


##### `private buttonIconUrl_type_info` → `String`


##### `private buttonStyle_type_info` → `String`


##### `private buttonText_type_info` → `String`


##### `private buttonWidth_type_info` → `String`


##### `private height_type_info` → `String`


##### `private isHeightFixed_type_info` → `String`


##### `private isHidden_type_info` → `String`


##### `private isWidthFixed_type_info` → `String`


##### `private visualforcePage_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ComponentInstanceProperty
#### Fields

##### `public name` → `String`


##### `public type_x` → `String`


##### `public value` → `String`


##### `private name_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChatterMobileSettings
#### Fields

##### `public enablePushNotifications` → `Boolean`


##### `private enablePushNotifications_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowAlert

**Inheritance**

WorkflowAlert

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public ccEmails` → `String`


##### `public description` → `String`


##### `public protected_x` → `Boolean`


##### `public recipients` → `MetadataService.WorkflowEmailRecipient`


##### `public senderAddress` → `String`


##### `public senderType` → `String`


##### `public template` → `String`


##### `private ccEmails_type_info` → `String`


##### `private description_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private recipients_type_info` → `String`


##### `private senderAddress_type_info` → `String`


##### `private senderType_type_info` → `String`


##### `private template_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeCaseFieldsSettings
#### Fields

##### `public field` → `MetadataService.KnowledgeCaseField`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmailTemplate

**Inheritance**

EmailTemplate

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public apiVersion` → `Double`


##### `public attachedDocuments` → `String`


##### `public attachments` → `MetadataService.Attachment`


##### `public available` → `Boolean`


##### `public description` → `String`


##### `public encodingKey` → `String`


##### `public letterhead` → `String`


##### `public name` → `String`


##### `public packageVersions` → `MetadataService.PackageVersion`


##### `public relatedEntityType` → `String`


##### `public style` → `String`


##### `public subject` → `String`


##### `public textOnly` → `String`


##### `public type_x` → `String`


##### `public uiType` → `String`


##### `private apiVersion_type_info` → `String`


##### `private attachedDocuments_type_info` → `String`


##### `private attachments_type_info` → `String`


##### `private available_type_info` → `String`


##### `private description_type_info` → `String`


##### `private encodingKey_type_info` → `String`


##### `private letterhead_type_info` → `String`


##### `private name_type_info` → `String`


##### `private packageVersions_type_info` → `String`


##### `private relatedEntityType_type_info` → `String`


##### `private style_type_info` → `String`


##### `private subject_type_info` → `String`


##### `private textOnly_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private uiType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowTextTemplate

**Inheritance**

FlowTextTemplate

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public text` → `String`


##### `private text_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PushNotification
#### Fields

##### `public fieldNames` → `String`


##### `public objectName` → `String`


##### `private fieldNames_type_info` → `String`


##### `private objectName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### TransactionSecurityPolicy
#### Fields

##### `public action` → `MetadataService`


##### `public active` → `Boolean`


##### `public apexClass` → `String`


##### `public description` → `String`


##### `public developerName` → `String`


##### `public eventName` → `String`


##### `public eventType` → `String`


##### `public executionUser` → `String`


##### `public flow` → `String`


##### `public masterLabel` → `String`


##### `public resourceName` → `String`


##### `public type_x` → `String`


##### `private action_type_info` → `String`


##### `private active_type_info` → `String`


##### `private apexClass_type_info` → `String`


##### `private description_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private eventName_type_info` → `String`


##### `private eventType_type_info` → `String`


##### `private executionUser_type_info` → `String`


##### `private flow_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private resourceName_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreen

**Inheritance**

FlowScreen

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public allowBack` → `Boolean`


##### `public allowFinish` → `Boolean`


##### `public allowPause` → `Boolean`


##### `public connector` → `MetadataService`


##### `public fields` → `MetadataService.FlowScreenField`


##### `public helpText` → `String`


##### `public pausedText` → `String`


##### `public rules` → `MetadataService.FlowScreenRule`


##### `public showFooter` → `Boolean`


##### `public showHeader` → `Boolean`


##### `private allowBack_type_info` → `String`


##### `private allowFinish_type_info` → `String`


##### `private allowPause_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private helpText_type_info` → `String`


##### `private pausedText_type_info` → `String`


##### `private rules_type_info` → `String`


##### `private showFooter_type_info` → `String`


##### `private showHeader_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### OpportunityListFieldsSelectedSettings
#### Fields

##### `public field` → `String`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Certificate

**Inheritance**

Certificate

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public caSigned` → `Boolean`


##### `public encryptedWithPlatformEncryption` → `Boolean`


##### `public expirationDate` → `DateTime`


##### `public keySize` → `Integer`


##### `public masterLabel` → `String`


##### `public privateKeyExportable` → `Boolean`


##### `private caSigned_type_info` → `String`


##### `private encryptedWithPlatformEncryption_type_info` → `String`


##### `private expirationDate_type_info` → `String`


##### `private keySize_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private privateKeyExportable_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveXmdDimensionCustomAction
#### Fields

##### `public customActionName` → `String`


##### `public enabled` → `Boolean`


##### `public icon` → `String`


##### `public method` → `String`


##### `public sortIndex` → `Integer`


##### `public target` → `String`


##### `public tooltip` → `String`


##### `public url` → `String`


##### `private customActionName_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private icon_type_info` → `String`


##### `private method_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private target_type_info` → `String`


##### `private tooltip_type_info` → `String`


##### `private url_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AccessMapping
#### Fields

##### `public accessLevel` → `String`


##### `public object_x` → `String`


##### `public objectField` → `String`


##### `public userField` → `String`


##### `private accessLevel_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private objectField_type_info` → `String`


##### `private userField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AnalyticSnapshotMapping
#### Fields

##### `public aggregateType` → `String`


##### `public sourceField` → `String`


##### `public sourceType` → `String`


##### `public targetField` → `String`


##### `private aggregateType_type_info` → `String`


##### `private sourceField_type_info` → `String`


##### `private sourceType_type_info` → `String`


##### `private targetField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DefaultShortcut
#### Fields

##### `public action` → `String`


##### `public active` → `Boolean`


##### `public keyCommand` → `String`


##### `private action_type_info` → `String`


##### `private active_type_info` → `String`


##### `private keyCommand_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkspaceMapping
#### Fields

##### `public fieldName` → `String`


##### `public tab` → `String`


##### `private fieldName_type_info` → `String`


##### `private tab_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenRuleAction
#### Fields

##### `public attribute` → `String`


##### `public fieldReference` → `String`


##### `public value` → `MetadataService`


##### `private attribute_type_info` → `String`


##### `private fieldReference_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowSend

**Inheritance**

WorkflowSend

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public action` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public language` → `String`


##### `public protected_x` → `Boolean`


##### `private action_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private language_type_info` → `String`


##### `private protected_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowRecordFilter

**Inheritance**

FlowRecordFilter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public field` → `String`


##### `public operator` → `String`


##### `public value` → `MetadataService`


##### `private field_type_info` → `String`


##### `private operator_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### deleteMetadata_element
#### Fields

##### `public type_x` → `String`


##### `public fullNames` → `String`


##### `private type_x_type_info` → `String`


##### `private fullNames_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ForecastRangeSettings
#### Fields

##### `public beginning` → `Integer`


##### `public displaying` → `Integer`


##### `public periodType` → `String`


##### `private beginning_type_info` → `String`


##### `private displaying_type_info` → `String`


##### `private periodType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowActionCall

**Inheritance**

FlowActionCall

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public actionName` → `String`


##### `public actionType` → `String`


##### `public connector` → `MetadataService`


##### `public faultConnector` → `MetadataService`


##### `public inputParameters` → `MetadataService.FlowActionCallInputParameter`


##### `public outputParameters` → `MetadataService.FlowActionCallOutputParameter`


##### `private actionName_type_info` → `String`


##### `private actionType_type_info` → `String`


##### `private connector_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private inputParameters_type_info` → `String`


##### `private outputParameters_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ListViewFilter
#### Fields

##### `public field` → `String`


##### `public operation` → `String`


##### `public value` → `String`


##### `private field_type_info` → `String`


##### `private operation_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardTableColumn
#### Fields

##### `public aggregateType` → `String`


##### `public calculatePercent` → `Boolean`


##### `public column` → `String`


##### `public decimalPlaces` → `Integer`


##### `public showTotal` → `Boolean`


##### `public sortBy` → `String`


##### `private aggregateType_type_info` → `String`


##### `private calculatePercent_type_info` → `String`


##### `private column_type_info` → `String`


##### `private decimalPlaces_type_info` → `String`


##### `private showTotal_type_info` → `String`


##### `private sortBy_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2

**Inheritance**

Territory2

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accountAccessLevel` → `String`


##### `public caseAccessLevel` → `String`


##### `public contactAccessLevel` → `String`


##### `public customFields` → `MetadataService.FieldValue`


##### `public description` → `String`


##### `public name` → `String`


##### `public opportunityAccessLevel` → `String`


##### `public parentTerritory` → `String`


##### `public ruleAssociations` → `MetadataService.Territory2RuleAssociation`


##### `public territory2Type` → `String`


##### `private accountAccessLevel_type_info` → `String`


##### `private caseAccessLevel_type_info` → `String`


##### `private contactAccessLevel_type_info` → `String`


##### `private customFields_type_info` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `private opportunityAccessLevel_type_info` → `String`


##### `private parentTerritory_type_info` → `String`


##### `private ruleAssociations_type_info` → `String`


##### `private territory2Type_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ListPlacement
#### Fields

##### `public height` → `Integer`


##### `public location` → `String`


##### `public units` → `String`


##### `public width` → `Integer`


##### `private height_type_info` → `String`


##### `private location_type_info` → `String`


##### `private units_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PicklistEntry
#### Fields

##### `public active` → `Boolean`


##### `public defaultValue` → `Boolean`


##### `public label` → `String`


##### `public validFor` → `String`


##### `public value` → `String`


##### `private active_type_info` → `String`


##### `private defaultValue_type_info` → `String`


##### `private label_type_info` → `String`


##### `private validFor_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportBucketField
#### Fields

##### `public bucketType` → `String`


##### `public developerName` → `String`


##### `public masterLabel` → `String`


##### `public nullTreatment` → `String`


##### `public otherBucketLabel` → `String`


##### `public sourceColumnName` → `String`


##### `public useOther` → `Boolean`


##### `public values` → `MetadataService.ReportBucketFieldValue`


##### `private bucketType_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private nullTreatment_type_info` → `String`


##### `private otherBucketLabel_type_info` → `String`


##### `private sourceColumnName_type_info` → `String`


##### `private useOther_type_info` → `String`


##### `private values_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlexiPageTemplateInstance
#### Fields

##### `public name` → `String`


##### `public properties` → `MetadataService.ComponentInstanceProperty`


##### `private name_type_info` → `String`


##### `private properties_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeCommunitiesSettings
#### Fields

##### `public community` → `String`


##### `private community_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppComponentList
#### Fields

##### `public alignment` → `String`


##### `public components` → `String`


##### `private alignment_type_info` → `String`


##### `private components_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeWorkOrderLineItemFieldsSettings
#### Fields

##### `public field` → `MetadataService.KnowledgeWorkOrderLineItemField`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OpportunitySettings

**Inheritance**

OpportunitySettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public autoActivateNewReminders` → `Boolean`


##### `public enableFindSimilarOpportunities` → `Boolean`


##### `public enableOpportunityTeam` → `Boolean`


##### `public enableUpdateReminders` → `Boolean`


##### `public findSimilarOppFilter` → `MetadataService`


##### `public promptToAddProducts` → `Boolean`


##### `private autoActivateNewReminders_type_info` → `String`


##### `private enableFindSimilarOpportunities_type_info` → `String`


##### `private enableOpportunityTeam_type_info` → `String`


##### `private enableUpdateReminders_type_info` → `String`


##### `private findSimilarOppFilter_type_info` → `String`


##### `private promptToAddProducts_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CodeCoverageWarning
#### Fields

##### `public id` → `String`


##### `public message` → `String`


##### `public name` → `String`


##### `public namespace` → `String`


##### `private id_type_info` → `String`


##### `private message_type_info` → `String`


##### `private name_type_info` → `String`


##### `private namespace_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomLabelTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeAnswerSettings
#### Fields

##### `public assignTo` → `String`


##### `public defaultArticleType` → `String`


##### `public enableArticleCreation` → `Boolean`


##### `private assignTo_type_info` → `String`


##### `private defaultArticleType_type_info` → `String`


##### `private enableArticleCreation_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Letterhead

**Inheritance**

Letterhead

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public available` → `Boolean`


##### `public backgroundColor` → `String`


##### `public bodyColor` → `String`


##### `public bottomLine` → `MetadataService`


##### `public description` → `String`


##### `public footer` → `MetadataService`


##### `public header` → `MetadataService`


##### `public middleLine` → `MetadataService`


##### `public name` → `String`


##### `public topLine` → `MetadataService`


##### `private available_type_info` → `String`


##### `private backgroundColor_type_info` → `String`


##### `private bodyColor_type_info` → `String`


##### `private bottomLine_type_info` → `String`


##### `private description_type_info` → `String`


##### `private footer_type_info` → `String`


##### `private header_type_info` → `String`


##### `private middleLine_type_info` → `String`


##### `private name_type_info` → `String`


##### `private topLine_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### AddressSettings

**Inheritance**

AddressSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public countriesAndStates` → `MetadataService`


##### `private countriesAndStates_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowApexPluginCallInputParameter

**Inheritance**

FlowApexPluginCallInputParameter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public name` → `String`


##### `public value` → `MetadataService`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PathAssistantSettings
#### Fields

##### `public pathAssistantEnabled` → `Boolean`


##### `private pathAssistantEnabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DuplicateRuleMatchRule
#### Fields

##### `public matchRuleSObjectType` → `String`


##### `public matchingRule` → `String`


##### `public objectMapping` → `MetadataService`


##### `private matchRuleSObjectType_type_info` → `String`


##### `private matchingRule_type_info` → `String`


##### `private objectMapping_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EventTypeParameter
#### Fields

##### `public defaultValue` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public maxOccurs` → `Integer`


##### `public minOccurs` → `Integer`


##### `public name` → `String`


##### `public sObjectType` → `String`


##### `public type_x` → `String`


##### `private defaultValue_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private maxOccurs_type_info` → `String`


##### `private minOccurs_type_info` → `String`


##### `private name_type_info` → `String`


##### `private sObjectType_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuoteSettings

**Inheritance**

QuoteSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableQuote` → `Boolean`


##### `private enableQuote_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomExperienceBranding
#### Fields

##### `public loginFooterText` → `String`


##### `public loginLogo` → `String`


##### `public pageFooter` → `String`


##### `public pageHeader` → `String`


##### `public primaryColor` → `String`


##### `public primaryComplementColor` → `String`


##### `public quaternaryColor` → `String`


##### `public quaternaryComplementColor` → `String`


##### `public secondaryColor` → `String`


##### `public tertiaryColor` → `String`


##### `public tertiaryComplementColor` → `String`


##### `public zeronaryColor` → `String`


##### `public zeronaryComplementColor` → `String`


##### `private loginFooterText_type_info` → `String`


##### `private loginLogo_type_info` → `String`


##### `private pageFooter_type_info` → `String`


##### `private pageHeader_type_info` → `String`


##### `private primaryColor_type_info` → `String`


##### `private primaryComplementColor_type_info` → `String`


##### `private quaternaryColor_type_info` → `String`


##### `private quaternaryComplementColor_type_info` → `String`


##### `private secondaryColor_type_info` → `String`


##### `private tertiaryColor_type_info` → `String`


##### `private tertiaryComplementColor_type_info` → `String`


##### `private zeronaryColor_type_info` → `String`


##### `private zeronaryComplementColor_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### BusinessHoursEntry

**Inheritance**

BusinessHoursEntry

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public default_x` → `Boolean`


##### `public fridayEndTime` → `DateTime`


##### `public fridayStartTime` → `DateTime`


##### `public mondayEndTime` → `DateTime`


##### `public mondayStartTime` → `DateTime`


##### `public name` → `String`


##### `public saturdayEndTime` → `DateTime`


##### `public saturdayStartTime` → `DateTime`


##### `public sundayEndTime` → `DateTime`


##### `public sundayStartTime` → `DateTime`


##### `public thursdayEndTime` → `DateTime`


##### `public thursdayStartTime` → `DateTime`


##### `public timeZoneId` → `String`


##### `public tuesdayEndTime` → `DateTime`


##### `public tuesdayStartTime` → `DateTime`


##### `public wednesdayEndTime` → `DateTime`


##### `public wednesdayStartTime` → `DateTime`


##### `private active_type_info` → `String`


##### `private default_x_type_info` → `String`


##### `private fridayEndTime_type_info` → `String`


##### `private fridayStartTime_type_info` → `String`


##### `private mondayEndTime_type_info` → `String`


##### `private mondayStartTime_type_info` → `String`


##### `private name_type_info` → `String`


##### `private saturdayEndTime_type_info` → `String`


##### `private saturdayStartTime_type_info` → `String`


##### `private sundayEndTime_type_info` → `String`


##### `private sundayStartTime_type_info` → `String`


##### `private thursdayEndTime_type_info` → `String`


##### `private thursdayStartTime_type_info` → `String`


##### `private timeZoneId_type_info` → `String`


##### `private tuesdayEndTime_type_info` → `String`


##### `private tuesdayStartTime_type_info` → `String`


##### `private wednesdayEndTime_type_info` → `String`


##### `private wednesdayStartTime_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### NetworkMemberGroup
#### Fields

##### `public permissionSet` → `String`


##### `public profile` → `String`


##### `private permissionSet_type_info` → `String`


##### `private profile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApexPage

**Inheritance**

ApexPage

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public apiVersion` → `Double`


##### `public availableInTouch` → `Boolean`


##### `public confirmationTokenRequired` → `Boolean`


##### `public description` → `String`


##### `public label` → `String`


##### `public packageVersions` → `MetadataService.PackageVersion`


##### `private apiVersion_type_info` → `String`


##### `private availableInTouch_type_info` → `String`


##### `private confirmationTokenRequired_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private packageVersions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomSite

**Inheritance**

CustomSite

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public active` → `Boolean`


##### `public allowHomePage` → `Boolean`


##### `public allowStandardAnswersPages` → `Boolean`


##### `public allowStandardIdeasPages` → `Boolean`


##### `public allowStandardLookups` → `Boolean`


##### `public allowStandardPortalPages` → `Boolean`


##### `public allowStandardSearch` → `Boolean`


##### `public analyticsTrackingCode` → `String`


##### `public authorizationRequiredPage` → `String`


##### `public bandwidthExceededPage` → `String`


##### `public browserXssProtection` → `Boolean`


##### `public changePasswordPage` → `String`


##### `public chatterAnswersForgotPasswordConfirmPage` → `String`


##### `public chatterAnswersForgotPasswordPage` → `String`


##### `public chatterAnswersHelpPage` → `String`


##### `public chatterAnswersLoginPage` → `String`


##### `public chatterAnswersRegistrationPage` → `String`


##### `public clickjackProtectionLevel` → `String`


##### `public contentSniffingProtection` → `Boolean`


##### `public cspUpgradeInsecureRequests` → `Boolean`


##### `public customWebAddresses` → `MetadataService.SiteWebAddress`


##### `public description` → `String`


##### `public favoriteIcon` → `String`


##### `public fileNotFoundPage` → `String`


##### `public forgotPasswordPage` → `String`


##### `public genericErrorPage` → `String`


##### `public guestProfile` → `String`


##### `public inMaintenancePage` → `String`


##### `public inactiveIndexPage` → `String`


##### `public indexPage` → `String`


##### `public masterLabel` → `String`


##### `public myProfilePage` → `String`


##### `public portal` → `String`


##### `public referrerPolicyOriginWhenCrossOrigin` → `Boolean`


##### `public requireHttps` → `Boolean`


##### `public requireInsecurePortalAccess` → `Boolean`


##### `public robotsTxtPage` → `String`


##### `public rootComponent` → `String`


##### `public selfRegPage` → `String`


##### `public serverIsDown` → `String`


##### `public siteAdmin` → `String`


##### `public siteRedirectMappings` → `MetadataService.SiteRedirectMapping`


##### `public siteTemplate` → `String`


##### `public siteType` → `String`


##### `public subdomain` → `String`


##### `public urlPathPrefix` → `String`


##### `private active_type_info` → `String`


##### `private allowHomePage_type_info` → `String`


##### `private allowStandardAnswersPages_type_info` → `String`


##### `private allowStandardIdeasPages_type_info` → `String`


##### `private allowStandardLookups_type_info` → `String`


##### `private allowStandardPortalPages_type_info` → `String`


##### `private allowStandardSearch_type_info` → `String`


##### `private analyticsTrackingCode_type_info` → `String`


##### `private authorizationRequiredPage_type_info` → `String`


##### `private bandwidthExceededPage_type_info` → `String`


##### `private browserXssProtection_type_info` → `String`


##### `private changePasswordPage_type_info` → `String`


##### `private chatterAnswersForgotPasswordConfirmPage_type_info` → `String`


##### `private chatterAnswersForgotPasswordPage_type_info` → `String`


##### `private chatterAnswersHelpPage_type_info` → `String`


##### `private chatterAnswersLoginPage_type_info` → `String`


##### `private chatterAnswersRegistrationPage_type_info` → `String`


##### `private clickjackProtectionLevel_type_info` → `String`


##### `private contentSniffingProtection_type_info` → `String`


##### `private cspUpgradeInsecureRequests_type_info` → `String`


##### `private customWebAddresses_type_info` → `String`


##### `private description_type_info` → `String`


##### `private favoriteIcon_type_info` → `String`


##### `private fileNotFoundPage_type_info` → `String`


##### `private forgotPasswordPage_type_info` → `String`


##### `private genericErrorPage_type_info` → `String`


##### `private guestProfile_type_info` → `String`


##### `private inMaintenancePage_type_info` → `String`


##### `private inactiveIndexPage_type_info` → `String`


##### `private indexPage_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private myProfilePage_type_info` → `String`


##### `private portal_type_info` → `String`


##### `private referrerPolicyOriginWhenCrossOrigin_type_info` → `String`


##### `private requireHttps_type_info` → `String`


##### `private requireInsecurePortalAccess_type_info` → `String`


##### `private robotsTxtPage_type_info` → `String`


##### `private rootComponent_type_info` → `String`


##### `private selfRegPage_type_info` → `String`


##### `private serverIsDown_type_info` → `String`


##### `private siteAdmin_type_info` → `String`


##### `private siteRedirectMappings_type_info` → `String`


##### `private siteTemplate_type_info` → `String`


##### `private siteType_type_info` → `String`


##### `private subdomain_type_info` → `String`


##### `private urlPathPrefix_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Skill

**Inheritance**

Skill

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public assignments` → `MetadataService`


##### `public description` → `String`


##### `public label` → `String`


##### `private assignments_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### renameMetadataResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RelatedList
#### Fields

##### `public hideOnDetail` → `Boolean`


##### `public name` → `String`


##### `private hideOnDetail_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SynonymGroup
#### Fields

##### `public languages` → `String`


##### `public terms` → `String`


##### `private languages_type_info` → `String`


##### `private terms_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowSubflow

**Inheritance**

FlowSubflow

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public connector` → `MetadataService`


##### `public flowName` → `String`


##### `public inputAssignments` → `MetadataService.FlowSubflowInputAssignment`


##### `public outputAssignments` → `MetadataService.FlowSubflowOutputAssignment`


##### `private connector_type_info` → `String`


##### `private flowName_type_info` → `String`


##### `private inputAssignments_type_info` → `String`


##### `private outputAssignments_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### MatchingRule

**Inheritance**

MatchingRule

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public booleanFilter` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public matchingRuleItems` → `MetadataService.MatchingRuleItem`


##### `public ruleStatus` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private matchingRuleItems_type_info` → `String`


##### `private ruleStatus_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### PasswordPolicies
#### Fields

##### `public apiOnlyUserHomePageURL` → `String`


##### `public complexity` → `String`


##### `public expiration` → `String`


##### `public historyRestriction` → `String`


##### `public lockoutInterval` → `String`


##### `public maxLoginAttempts` → `String`


##### `public minimumPasswordLength` → `String`


##### `public minimumPasswordLifetime` → `Boolean`


##### `public obscureSecretAnswer` → `Boolean`


##### `public passwordAssistanceMessage` → `String`


##### `public passwordAssistanceURL` → `String`


##### `public questionRestriction` → `String`


##### `private apiOnlyUserHomePageURL_type_info` → `String`


##### `private complexity_type_info` → `String`


##### `private expiration_type_info` → `String`


##### `private historyRestriction_type_info` → `String`


##### `private lockoutInterval_type_info` → `String`


##### `private maxLoginAttempts_type_info` → `String`


##### `private minimumPasswordLength_type_info` → `String`


##### `private minimumPasswordLifetime_type_info` → `String`


##### `private obscureSecretAnswer_type_info` → `String`


##### `private passwordAssistanceMessage_type_info` → `String`


##### `private passwordAssistanceURL_type_info` → `String`


##### `private questionRestriction_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AnalyticsCloudComponentLayoutItem
#### Fields

##### `public assetType` → `String`


##### `public devName` → `String`


##### `public error` → `String`


##### `public filter` → `String`


##### `public height` → `Integer`


##### `public hideOnError` → `Boolean`


##### `public showHeader` → `Boolean`


##### `public showSharing` → `Boolean`


##### `public showTitle` → `Boolean`


##### `public width` → `String`


##### `private assetType_type_info` → `String`


##### `private devName_type_info` → `String`


##### `private error_type_info` → `String`


##### `private filter_type_info` → `String`


##### `private height_type_info` → `String`


##### `private hideOnError_type_info` → `String`


##### `private showHeader_type_info` → `String`


##### `private showSharing_type_info` → `String`


##### `private showTitle_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ServiceCloudConsoleConfig
#### Fields

##### `public componentList` → `MetadataService`


##### `public detailPageRefreshMethod` → `String`


##### `public footerColor` → `String`


##### `public headerColor` → `String`


##### `public keyboardShortcuts` → `MetadataService`


##### `public listPlacement` → `MetadataService`


##### `public listRefreshMethod` → `String`


##### `public liveAgentConfig` → `MetadataService`


##### `public primaryTabColor` → `String`


##### `public pushNotifications` → `MetadataService.PushNotification`


##### `public tabLimitConfig` → `MetadataService`


##### `public whitelistedDomains` → `String`


##### `private componentList_type_info` → `String`


##### `private detailPageRefreshMethod_type_info` → `String`


##### `private footerColor_type_info` → `String`


##### `private headerColor_type_info` → `String`


##### `private keyboardShortcuts_type_info` → `String`


##### `private listPlacement_type_info` → `String`


##### `private listRefreshMethod_type_info` → `String`


##### `private liveAgentConfig_type_info` → `String`


##### `private primaryTabColor_type_info` → `String`


##### `private pushNotifications_type_info` → `String`


##### `private tabLimitConfig_type_info` → `String`


##### `private whitelistedDomains_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SFDCMobileSettings
#### Fields

##### `public enableMobileLite` → `Boolean`


##### `public enableUserToDeviceLinking` → `Boolean`


##### `private enableMobileLite_type_info` → `String`


##### `private enableUserToDeviceLinking_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingReason

**Inheritance**

SharingReason

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public label` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowDecision

**Inheritance**

FlowDecision

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public defaultConnector` → `MetadataService`


##### `public defaultConnectorLabel` → `String`


##### `public rules` → `MetadataService.FlowRule`


##### `private defaultConnector_type_info` → `String`


##### `private defaultConnectorLabel_type_info` → `String`


##### `private rules_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomFeedFilter
#### Fields

##### `public criteria` → `MetadataService.FeedFilterCriterion`


##### `public description` → `String`


##### `public isProtected` → `Boolean`


##### `public label` → `String`


##### `private criteria_type_info` → `String`


##### `private description_type_info` → `String`


##### `private isProtected_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileRecordTypeVisibility
#### Fields

##### `public default_x` → `Boolean`


##### `public personAccountDefault` → `Boolean`


##### `public recordType` → `String`


##### `public visible` → `Boolean`


##### `private default_x_type_info` → `String`


##### `private personAccountDefault_type_info` → `String`


##### `private recordType_type_info` → `String`


##### `private visible_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardMobileSettings
#### Fields

##### `public enableDashboardIPadApp` → `Boolean`


##### `private enableDashboardIPadApp_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SiteRedirectMapping
#### Fields

##### `public action` → `String`


##### `public isActive` → `Boolean`


##### `public source` → `String`


##### `public target` → `String`


##### `private action_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private source_type_info` → `String`


##### `private target_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AgentConfigProfileAssignments
#### Fields

##### `public profile` → `String`


##### `private profile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReadCustomSiteResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomSite`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomSiteResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadListViewResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ListView`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readListViewResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadInstalledPackageResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.InstalledPackage`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readInstalledPackageResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomFieldResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomField`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomFieldResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadFieldSetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.FieldSet`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readFieldSetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadPicklistValueResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.PicklistValue`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readPicklistValueResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadRecordTypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.RecordType`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readRecordTypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWebLinkResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WebLink`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWebLinkResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAddressSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AddressSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAddressSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCaseSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CaseSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCaseSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomObjectResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomObject`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomObjectResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLayoutResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Layout`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLayoutResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEmailTemplateResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EmailTemplate`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEmailTemplateResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadScontrolResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Scontrol`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readScontrolResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadApexPageResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ApexPage`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readApexPageResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadApexComponentResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ApexComponent`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readApexComponentResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadApexClassResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ApexClass`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readApexClassResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadApexTriggerResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ApexTrigger`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readApexTriggerResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadStaticResourceResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.StaticResource`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readStaticResourceResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadDocumentResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Document`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readDocumentResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomLabelsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomLabels`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomLabelsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomLabelResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomLabel`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomLabelResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAccountSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AccountSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAccountSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadQueueResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Queue`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readQueueResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomDataTypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomDataType`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomDataTypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadExternalDataSourceResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ExternalDataSource`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readExternalDataSourceResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadGroupResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Group_x`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readGroupResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadBusinessProcessResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.BusinessProcess`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readBusinessProcessResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCompactLayoutResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CompactLayout`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCompactLayoutResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingReasonResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingReason`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingReasonResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadValidationRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ValidationRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readValidationRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadReportTypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ReportType`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readReportTypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadReportResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Report`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readReportResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadDashboardResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Dashboard`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readDashboardResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAnalyticSnapshotResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AnalyticSnapshot`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAnalyticSnapshotResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomPageWebLinkResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomPageWebLink`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomPageWebLinkResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadQuickActionResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.QuickAction`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readQuickActionResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadFlexiPageResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.FlexiPage`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readFlexiPageResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomTabResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomTab`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomTabResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomApplicationComponentResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomApplicationComponent`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomApplicationComponentResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomApplicationResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomApplication`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomApplicationResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadPortalResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Portal`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readPortalResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLetterheadResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Letterhead`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLetterheadResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadFlowResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Flow`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readFlowResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Workflow`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAssignmentRulesResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AssignmentRules`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAssignmentRulesResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAssignmentRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AssignmentRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAssignmentRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAutoResponseRulesResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AutoResponseRules`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAutoResponseRulesResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAutoResponseRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AutoResponseRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAutoResponseRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEscalationRulesResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EscalationRules`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEscalationRulesResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEscalationRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EscalationRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEscalationRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadPostTemplateResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.PostTemplate`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readPostTemplateResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadApprovalProcessResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ApprovalProcess`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readApprovalProcessResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadHomePageComponentResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.HomePageComponent`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readHomePageComponentResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadHomePageLayoutResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.HomePageLayout`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readHomePageLayoutResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomObjectTranslationResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomObjectTranslation`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomObjectTranslationResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadTranslationsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Translations`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readTranslationsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadProfileResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Profile`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readProfileResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadPermissionSetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.PermissionSet`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readPermissionSetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadDataCategoryGroupResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.DataCategoryGroup`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readDataCategoryGroupResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadRemoteSiteSettingResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.RemoteSiteSetting`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readRemoteSiteSettingResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadPackageResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Package_x`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readPackageResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAuthProviderResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AuthProvider`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAuthProviderResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadKnowledgeSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.KnowledgeSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readKnowledgeSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingSetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingSet`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingSetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSecuritySettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SecuritySettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSecuritySettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadIdeasSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.IdeasSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readIdeasSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadChatterAnswersSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ChatterAnswersSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readChatterAnswersSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCommunityResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Community`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCommunityResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadActivitiesSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ActivitiesSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readActivitiesSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadContractSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ContractSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readContractSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadOrderSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.OrderSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readOrderSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadOpportunitySettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.OpportunitySettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readOpportunitySettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadProductSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ProductSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readProductSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadQuoteSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.QuoteSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readQuoteSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCallCenterResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CallCenter`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCallCenterResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEntitlementProcessResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EntitlementProcess`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEntitlementProcessResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMilestoneTypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MilestoneType`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMilestoneTypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEntitlementTemplateResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EntitlementTemplate`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEntitlementTemplateResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEntitlementSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EntitlementSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEntitlementSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadBusinessHoursSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.BusinessHoursSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readBusinessHoursSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadBusinessHoursEntryResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.BusinessHoursEntry`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readBusinessHoursEntryResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadConnectedAppResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ConnectedApp`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readConnectedAppResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAppMenuResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AppMenu`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAppMenuResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMobileSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MobileSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMobileSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadNetworkResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Network`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readNetworkResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCompanySettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CompanySettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCompanySettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadForecastingSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ForecastingSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readForecastingSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSamlSsoConfigResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SamlSsoConfig`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSamlSsoConfigResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLiveAgentSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.LiveAgentSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLiveAgentSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSkillResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Skill`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSkillResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLiveChatButtonResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.LiveChatButton`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLiveChatButtonResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLiveChatAgentConfigResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.LiveChatAgentConfig`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLiveChatAgentConfigResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSynonymDictionaryResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SynonymDictionary`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSynonymDictionaryResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadFolderResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Folder`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readFolderResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadReportFolderResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ReportFolder`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readReportFolderResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadDashboardFolderResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.DashboardFolder`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readDashboardFolderResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadDocumentFolderResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.DocumentFolder`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readDocumentFolderResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEmailFolderResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EmailFolder`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEmailFolderResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadRoleOrTerritoryResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.RoleOrTerritory`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readRoleOrTerritoryResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowActionResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowAction`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowActionResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSiteDotComResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SiteDotCom`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSiteDotComResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowTaskResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowTask`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowTaskResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowSendResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowSend`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowSendResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowOutboundMessageResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowOutboundMessage`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowOutboundMessageResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowKnowledgePublishResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowKnowledgePublish`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowKnowledgePublishResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowFieldUpdateResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowFieldUpdate`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowFieldUpdateResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWorkflowAlertResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WorkflowAlert`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWorkflowAlertResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadVisualizationPluginResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.VisualizationPlugin`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readVisualizationPluginResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomMetadataResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomMetadata`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomMetadataResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadNameSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.NameSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readNameSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMarketingActionSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MarketingActionSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMarketingActionSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomPermissionResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomPermission`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomPermissionResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadAuraDefinitionBundleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.AuraDefinitionBundle`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readAuraDefinitionBundleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCorsWhitelistOriginResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CorsWhitelistOrigin`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCorsWhitelistOriginResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadManagedTopicsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ManagedTopics`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readManagedTopicsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadTerritory2Result

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Territory2`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readTerritory2Response_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadTerritory2ModelResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Territory2Model`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readTerritory2ModelResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadTerritory2SettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Territory2Settings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readTerritory2SettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadTerritory2TypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Territory2Type`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readTerritory2TypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadXOrgHubResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.XOrgHub`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readXOrgHubResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadActionLinkGroupTemplateResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ActionLinkGroupTemplate`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readActionLinkGroupTemplateResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLicenseDefinitionResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.LicenseDefinition`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLicenseDefinitionResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMarketingResourceTypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MarketingResourceType`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMarketingResourceTypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMatchingRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MatchingRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMatchingRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMatchingRulesResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MatchingRules`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMatchingRulesResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadNamedCredentialResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.NamedCredential`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readNamedCredentialResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadPersonalJourneySettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.PersonalJourneySettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readPersonalJourneySettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingRulesResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingRules`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingRulesResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingBaseRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingBaseRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingBaseRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingCriteriaRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingCriteriaRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingCriteriaRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingOwnerRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingOwnerRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingOwnerRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSharingTerritoryRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SharingTerritoryRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSharingTerritoryRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadMetadataWithContentResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.MetadataWithContent`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readMetadataWithContentResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadDelegateGroupResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.DelegateGroup`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readDelegateGroupResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEventDeliveryResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EventDelivery`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEventDeliveryResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEventSubscriptionResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EventSubscription`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEventSubscriptionResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEventTypeResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EventType`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEventTypeResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCertificateResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Certificate`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCertificateResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadModerationRuleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ModerationRule`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readModerationRuleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWaveApplicationResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WaveApplication`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWaveApplicationResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWaveDatasetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WaveDataset`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWaveDatasetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWaveDashboardResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WaveDashboard`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWaveDashboardResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWaveDataflowResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WaveDataflow`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWaveDataflowResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWaveLensResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.WaveLens`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWaveLensResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadOrgPreferenceSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.OrgPreferenceSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readOrgPreferenceSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSearchSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SearchSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSearchSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadGlobalValueSetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.GlobalValueSet`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readGlobalValueSetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadGlobalPicklistValueResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.GlobalPicklistValue`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readGlobalPicklistValueResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadStandardValueSetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.StandardValueSet`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readStandardValueSetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadStandardValueResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.StandardValue`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readStandardValueResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCustomValueResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CustomValue`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCustomValueResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadApexTestSuiteResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ApexTestSuite`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readApexTestSuiteResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadChannelLayoutResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ChannelLayout`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readChannelLayoutResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadContentAssetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ContentAsset`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readContentAssetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEmailServicesFunctionResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EmailServicesFunction`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEmailServicesFunctionResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEmbeddedServiceBrandingResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EmbeddedServiceBranding`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEmbeddedServiceBrandingResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEmbeddedServiceConfigResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EmbeddedServiceConfig`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEmbeddedServiceConfigResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEmbeddedServiceLiveAgentResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EmbeddedServiceLiveAgent`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEmbeddedServiceLiveAgentResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCaseSubjectParticleResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CaseSubjectParticle`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCaseSubjectParticleResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadNetworkBrandingResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.NetworkBranding`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readNetworkBrandingResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadSocialCustomerServiceSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.SocialCustomerServiceSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readSocialCustomerServiceSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadTopicsForObjectsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.TopicsForObjects`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readTopicsForObjectsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadBrandingSetResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.BrandingSet`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readBrandingSetResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadProfilePasswordPolicyResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ProfilePasswordPolicy`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readProfilePasswordPolicyResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadProfileSessionSettingResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ProfileSessionSetting`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readProfileSessionSettingResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadCspTrustedSiteResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.CspTrustedSite`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readCspTrustedSiteResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadEclairGeoDataResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.EclairGeoData`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readEclairGeoDataResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadExternalServiceRegistrationResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.ExternalServiceRegistration`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readExternalServiceRegistrationResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadFileUploadAndDownloadSecuritySettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.FileUploadAndDownloadSecuritySettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readFileUploadAndDownloadSecuritySettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadLeadConvertSettingsResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.LeadConvertSettings`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readLeadConvertSettingsResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadUserCriteriaResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.UserCriteria`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readUserCriteriaResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadWavexmdResult

**Implemented types**

[IReadResult](IReadResult)

#### Fields

##### `public records` → `MetadataService.Wavexmd`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### readWavexmdResponse_element

**Implemented types**

[IReadResponseElement](IReadResponseElement)

#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---
#### Methods
##### `public IReadResult getResult()`
---

### ReadResult
#### Fields

##### `public records` → `MetadataService.Metadata`


##### `private records_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportBucketFieldValue
#### Fields

##### `public sourceValues` → `MetadataService.ReportBucketFieldSourceValue`


##### `public value` → `String`


##### `private sourceValues_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### BrandingSetProperty
#### Fields

##### `public propertyName` → `String`


##### `public propertyValue` → `String`


##### `private propertyName_type_info` → `String`


##### `private propertyValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileApexPageAccess
#### Fields

##### `public apexPage` → `String`


##### `public enabled` → `Boolean`


##### `private apexPage_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Scontrol

**Inheritance**

Scontrol

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public contentSource` → `String`


##### `public description` → `String`


##### `public encodingKey` → `String`


##### `public fileContent` → `String`


##### `public fileName` → `String`


##### `public name` → `String`


##### `public supportsCaching` → `Boolean`


##### `private contentSource_type_info` → `String`


##### `private description_type_info` → `String`


##### `private encodingKey_type_info` → `String`


##### `private fileContent_type_info` → `String`


##### `private fileName_type_info` → `String`


##### `private name_type_info` → `String`


##### `private supportsCaching_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Network

**Inheritance**

Network

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public allowInternalUserLogin` → `Boolean`


##### `public allowMembersToFlag` → `Boolean`


##### `public allowedExtensions` → `String`


##### `public caseCommentEmailTemplate` → `String`


##### `public changePasswordTemplate` → `String`


##### `public communityRoles` → `MetadataService`


##### `public description` → `String`


##### `public disableReputationRecordConversations` → `Boolean`


##### `public emailFooterLogo` → `String`


##### `public emailFooterText` → `String`


##### `public emailSenderAddress` → `String`


##### `public emailSenderName` → `String`


##### `public enableCustomVFErrorPageOverrides` → `Boolean`


##### `public enableDirectMessages` → `Boolean`


##### `public enableGuestChatter` → `Boolean`


##### `public enableGuestFileAccess` → `Boolean`


##### `public enableInvitation` → `Boolean`


##### `public enableKnowledgeable` → `Boolean`


##### `public enableNicknameDisplay` → `Boolean`


##### `public enablePrivateMessages` → `Boolean`


##### `public enableReputation` → `Boolean`


##### `public enableShowAllNetworkSettings` → `Boolean`


##### `public enableSiteAsContainer` → `Boolean`


##### `public enableTalkingAboutStats` → `Boolean`


##### `public enableTopicAssignmentRules` → `Boolean`


##### `public enableTopicSuggestions` → `Boolean`


##### `public enableUpDownVote` → `Boolean`


##### `public feedChannel` → `String`


##### `public forgotPasswordTemplate` → `String`


##### `public gatherCustomerSentimentData` → `Boolean`


##### `public logoutUrl` → `String`


##### `public maxFileSizeKb` → `Integer`


##### `public navigationLinkSet` → `MetadataService`


##### `public networkMemberGroups` → `MetadataService`


##### `public networkPageOverrides` → `MetadataService`


##### `public newSenderAddress` → `String`


##### `public picassoSite` → `String`


##### `public recommendationAudience` → `MetadataService`


##### `public recommendationDefinition` → `MetadataService`


##### `public reputationLevels` → `MetadataService`


##### `public reputationPointsRules` → `MetadataService`


##### `public selfRegProfile` → `String`


##### `public selfRegistration` → `Boolean`


##### `public sendWelcomeEmail` → `Boolean`


##### `public site` → `String`


##### `public status` → `String`


##### `public tabs` → `MetadataService`


##### `public urlPathPrefix` → `String`


##### `public welcomeTemplate` → `String`


##### `private allowInternalUserLogin_type_info` → `String`


##### `private allowMembersToFlag_type_info` → `String`


##### `private allowedExtensions_type_info` → `String`


##### `private caseCommentEmailTemplate_type_info` → `String`


##### `private changePasswordTemplate_type_info` → `String`


##### `private communityRoles_type_info` → `String`


##### `private description_type_info` → `String`


##### `private disableReputationRecordConversations_type_info` → `String`


##### `private emailFooterLogo_type_info` → `String`


##### `private emailFooterText_type_info` → `String`


##### `private emailSenderAddress_type_info` → `String`


##### `private emailSenderName_type_info` → `String`


##### `private enableCustomVFErrorPageOverrides_type_info` → `String`


##### `private enableDirectMessages_type_info` → `String`


##### `private enableGuestChatter_type_info` → `String`


##### `private enableGuestFileAccess_type_info` → `String`


##### `private enableInvitation_type_info` → `String`


##### `private enableKnowledgeable_type_info` → `String`


##### `private enableNicknameDisplay_type_info` → `String`


##### `private enablePrivateMessages_type_info` → `String`


##### `private enableReputation_type_info` → `String`


##### `private enableShowAllNetworkSettings_type_info` → `String`


##### `private enableSiteAsContainer_type_info` → `String`


##### `private enableTalkingAboutStats_type_info` → `String`


##### `private enableTopicAssignmentRules_type_info` → `String`


##### `private enableTopicSuggestions_type_info` → `String`


##### `private enableUpDownVote_type_info` → `String`


##### `private feedChannel_type_info` → `String`


##### `private forgotPasswordTemplate_type_info` → `String`


##### `private gatherCustomerSentimentData_type_info` → `String`


##### `private logoutUrl_type_info` → `String`


##### `private maxFileSizeKb_type_info` → `String`


##### `private navigationLinkSet_type_info` → `String`


##### `private networkMemberGroups_type_info` → `String`


##### `private networkPageOverrides_type_info` → `String`


##### `private newSenderAddress_type_info` → `String`


##### `private picassoSite_type_info` → `String`


##### `private recommendationAudience_type_info` → `String`


##### `private recommendationDefinition_type_info` → `String`


##### `private reputationLevels_type_info` → `String`


##### `private reputationPointsRules_type_info` → `String`


##### `private selfRegProfile_type_info` → `String`


##### `private selfRegistration_type_info` → `String`


##### `private sendWelcomeEmail_type_info` → `String`


##### `private site_type_info` → `String`


##### `private status_type_info` → `String`


##### `private tabs_type_info` → `String`


##### `private urlPathPrefix_type_info` → `String`


##### `private welcomeTemplate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ActionLinkTemplate
#### Fields

##### `public actionUrl` → `String`


##### `public headers` → `String`


##### `public isConfirmationRequired` → `Boolean`


##### `public isGroupDefault` → `Boolean`


##### `public label` → `String`


##### `public labelKey` → `String`


##### `public linkType` → `String`


##### `public method` → `String`


##### `public position` → `Integer`


##### `public requestBody` → `String`


##### `public userAlias` → `String`


##### `public userVisibility` → `String`


##### `private actionUrl_type_info` → `String`


##### `private headers_type_info` → `String`


##### `private isConfirmationRequired_type_info` → `String`


##### `private isGroupDefault_type_info` → `String`


##### `private label_type_info` → `String`


##### `private labelKey_type_info` → `String`


##### `private linkType_type_info` → `String`


##### `private method_type_info` → `String`


##### `private position_type_info` → `String`


##### `private requestBody_type_info` → `String`


##### `private userAlias_type_info` → `String`


##### `private userVisibility_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EntitlementProcessMilestoneItem
#### Fields

##### `public businessHours` → `String`


##### `public criteriaBooleanFilter` → `String`


##### `public milestoneCriteriaFilterItems` → `MetadataService.FilterItem`


##### `public milestoneCriteriaFormula` → `String`


##### `public milestoneName` → `String`


##### `public minutesCustomClass` → `String`


##### `public minutesToComplete` → `Integer`


##### `public successActions` → `MetadataService.WorkflowActionReference`


##### `public timeTriggers` → `MetadataService.EntitlementProcessMilestoneTimeTrigger`


##### `public useCriteriaStartTime` → `Boolean`


##### `private businessHours_type_info` → `String`


##### `private criteriaBooleanFilter_type_info` → `String`


##### `private milestoneCriteriaFilterItems_type_info` → `String`


##### `private milestoneCriteriaFormula_type_info` → `String`


##### `private milestoneName_type_info` → `String`


##### `private minutesCustomClass_type_info` → `String`


##### `private minutesToComplete_type_info` → `String`


##### `private successActions_type_info` → `String`


##### `private timeTriggers_type_info` → `String`


##### `private useCriteriaStartTime_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportFilter
#### Fields

##### `public booleanFilter` → `String`


##### `public criteriaItems` → `MetadataService.ReportFilterItem`


##### `public language` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private criteriaItems_type_info` → `String`


##### `private language_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RetrieveResult
#### Fields

##### `public done` → `Boolean`


##### `public errorMessage` → `String`


##### `public errorStatusCode` → `String`


##### `public fileProperties` → `MetadataService.FileProperties`


##### `public id` → `String`


##### `public messages` → `MetadataService.RetrieveMessage`


##### `public status` → `String`


##### `public success` → `Boolean`


##### `public zipFile` → `String`


##### `private done_type_info` → `String`


##### `private errorMessage_type_info` → `String`


##### `private errorStatusCode_type_info` → `String`


##### `private fileProperties_type_info` → `String`


##### `private id_type_info` → `String`


##### `private messages_type_info` → `String`


##### `private status_type_info` → `String`


##### `private success_type_info` → `String`


##### `private zipFile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### KnowledgeWorkOrderFieldsSettings
#### Fields

##### `public field` → `MetadataService.KnowledgeWorkOrderField`


##### `private field_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2Model

**Inheritance**

Territory2Model

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public customFields` → `MetadataService.FieldValue`


##### `public description` → `String`


##### `public name` → `String`


##### `private customFields_type_info` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SearchSettingsByObject
#### Fields

##### `public searchSettingsByObject` → `MetadataService.ObjectSearchSetting`


##### `private searchSettingsByObject_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomObject

**Inheritance**

CustomObject

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public actionOverrides` → `MetadataService.ActionOverride`


##### `public allowInChatterGroups` → `Boolean`


##### `public articleTypeChannelDisplay` → `MetadataService`


##### `public businessProcesses` → `MetadataService.BusinessProcess`


##### `public compactLayoutAssignment` → `String`


##### `public compactLayouts` → `MetadataService.CompactLayout`


##### `public customHelp` → `String`


##### `public customHelpPage` → `String`


##### `public customSettingsType` → `String`


##### `public dataStewardGroup` → `String`


##### `public dataStewardUser` → `String`


##### `public deploymentStatus` → `String`


##### `public deprecated` → `Boolean`


##### `public description` → `String`


##### `public enableActivities` → `Boolean`


##### `public enableBulkApi` → `Boolean`


##### `public enableChangeDataCapture` → `Boolean`


##### `public enableDivisions` → `Boolean`


##### `public enableEnhancedLookup` → `Boolean`


##### `public enableFeeds` → `Boolean`


##### `public enableHistory` → `Boolean`


##### `public enableReports` → `Boolean`


##### `public enableSearch` → `Boolean`


##### `public enableSharing` → `Boolean`


##### `public enableStreamingApi` → `Boolean`


##### `public eventType` → `String`


##### `public externalDataSource` → `String`


##### `public externalName` → `String`


##### `public externalRepository` → `String`


##### `public externalSharingModel` → `String`


##### `public fieldSets` → `MetadataService.FieldSet`


##### `public fields` → `MetadataService.CustomField`


##### `public gender` → `String`


##### `public historyRetentionPolicy` → `MetadataService`


##### `public household` → `Boolean`


##### `public indexes` → `MetadataService.Index`


##### `public label` → `String`


##### `public listViews` → `MetadataService.ListView`


##### `public nameField` → `MetadataService`


##### `public pluralLabel` → `String`


##### `public recordTypeTrackFeedHistory` → `Boolean`


##### `public recordTypeTrackHistory` → `Boolean`


##### `public recordTypes` → `MetadataService.RecordType`


##### `public searchLayouts` → `MetadataService`


##### `public sharingModel` → `String`


##### `public sharingReasons` → `MetadataService.SharingReason`


##### `public sharingRecalculations` → `MetadataService.SharingRecalculation`


##### `public startsWith` → `String`


##### `public validationRules` → `MetadataService.ValidationRule`


##### `public visibility` → `String`


##### `public webLinks` → `MetadataService.WebLink`


##### `private actionOverrides_type_info` → `String`


##### `private allowInChatterGroups_type_info` → `String`


##### `private articleTypeChannelDisplay_type_info` → `String`


##### `private businessProcesses_type_info` → `String`


##### `private compactLayoutAssignment_type_info` → `String`


##### `private compactLayouts_type_info` → `String`


##### `private customHelp_type_info` → `String`


##### `private customHelpPage_type_info` → `String`


##### `private customSettingsType_type_info` → `String`


##### `private dataStewardGroup_type_info` → `String`


##### `private dataStewardUser_type_info` → `String`


##### `private deploymentStatus_type_info` → `String`


##### `private deprecated_type_info` → `String`


##### `private description_type_info` → `String`


##### `private enableActivities_type_info` → `String`


##### `private enableBulkApi_type_info` → `String`


##### `private enableChangeDataCapture_type_info` → `String`


##### `private enableDivisions_type_info` → `String`


##### `private enableEnhancedLookup_type_info` → `String`


##### `private enableFeeds_type_info` → `String`


##### `private enableHistory_type_info` → `String`


##### `private enableReports_type_info` → `String`


##### `private enableSearch_type_info` → `String`


##### `private enableSharing_type_info` → `String`


##### `private enableStreamingApi_type_info` → `String`


##### `private eventType_type_info` → `String`


##### `private externalDataSource_type_info` → `String`


##### `private externalName_type_info` → `String`


##### `private externalRepository_type_info` → `String`


##### `private externalSharingModel_type_info` → `String`


##### `private fieldSets_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private gender_type_info` → `String`


##### `private historyRetentionPolicy_type_info` → `String`


##### `private household_type_info` → `String`


##### `private indexes_type_info` → `String`


##### `private label_type_info` → `String`


##### `private listViews_type_info` → `String`


##### `private nameField_type_info` → `String`


##### `private pluralLabel_type_info` → `String`


##### `private recordTypeTrackFeedHistory_type_info` → `String`


##### `private recordTypeTrackHistory_type_info` → `String`


##### `private recordTypes_type_info` → `String`


##### `private searchLayouts_type_info` → `String`


##### `private sharingModel_type_info` → `String`


##### `private sharingReasons_type_info` → `String`


##### `private sharingRecalculations_type_info` → `String`


##### `private startsWith_type_info` → `String`


##### `private validationRules_type_info` → `String`


##### `private visibility_type_info` → `String`


##### `private webLinks_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowTranslation
#### Fields

##### `public choices` → `MetadataService.FlowChoiceTranslation`


##### `public fullName` → `String`


##### `public label` → `String`


##### `public screens` → `MetadataService.FlowScreenTranslation`


##### `private choices_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private label_type_info` → `String`


##### `private screens_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DuplicateRuleFilter
#### Fields

##### `public booleanFilter` → `String`


##### `public duplicateRuleFilterItems` → `MetadataService.DuplicateRuleFilterItem`


##### `private booleanFilter_type_info` → `String`


##### `private duplicateRuleFilterItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LayoutSection
#### Fields

##### `public customLabel` → `Boolean`


##### `public detailHeading` → `Boolean`


##### `public editHeading` → `Boolean`


##### `public label` → `String`


##### `public layoutColumns` → `MetadataService.LayoutColumn`


##### `public style` → `String`


##### `private customLabel_type_info` → `String`


##### `private detailHeading_type_info` → `String`


##### `private editHeading_type_info` → `String`


##### `private label_type_info` → `String`


##### `private layoutColumns_type_info` → `String`


##### `private style_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### cancelDeployResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowMetadataValue
#### Fields

##### `public name` → `String`


##### `public value` → `MetadataService`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveRecipe
#### Fields

##### `public dataflow` → `String`


##### `public masterLabel` → `String`


##### `public securityPredicate` → `String`


##### `public targetDatasetAlias` → `String`


##### `private dataflow_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private securityPredicate_type_info` → `String`


##### `private targetDatasetAlias_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileObjectPermissions
#### Fields

##### `public allowCreate` → `Boolean`


##### `public allowDelete` → `Boolean`


##### `public allowEdit` → `Boolean`


##### `public allowRead` → `Boolean`


##### `public modifyAllRecords` → `Boolean`


##### `public object_x` → `String`


##### `public viewAllRecords` → `Boolean`


##### `private allowCreate_type_info` → `String`


##### `private allowDelete_type_info` → `String`


##### `private allowEdit_type_info` → `String`


##### `private allowRead_type_info` → `String`


##### `private modifyAllRecords_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private viewAllRecords_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportGrouping
#### Fields

##### `public aggregateType` → `String`


##### `public dateGranularity` → `String`


##### `public field` → `String`


##### `public sortByName` → `String`


##### `public sortOrder` → `String`


##### `public sortType` → `String`


##### `private aggregateType_type_info` → `String`


##### `private dateGranularity_type_info` → `String`


##### `private field_type_info` → `String`


##### `private sortByName_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private sortType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DeployMessage
#### Fields

##### `public changed` → `Boolean`


##### `public columnNumber` → `Integer`


##### `public componentType` → `String`


##### `public created` → `Boolean`


##### `public createdDate` → `DateTime`


##### `public deleted` → `Boolean`


##### `public fileName` → `String`


##### `public fullName` → `String`


##### `public id` → `String`


##### `public lineNumber` → `Integer`


##### `public problem` → `String`


##### `public problemType` → `String`


##### `public success` → `Boolean`


##### `private changed_type_info` → `String`


##### `private columnNumber_type_info` → `String`


##### `private componentType_type_info` → `String`


##### `private created_type_info` → `String`


##### `private createdDate_type_info` → `String`


##### `private deleted_type_info` → `String`


##### `private fileName_type_info` → `String`


##### `private fullName_type_info` → `String`


##### `private id_type_info` → `String`


##### `private lineNumber_type_info` → `String`


##### `private problem_type_info` → `String`


##### `private problemType_type_info` → `String`


##### `private success_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmailServicesAddress
#### Fields

##### `public authorizedSenders` → `String`


##### `public developerName` → `String`


##### `public isActive` → `Boolean`


##### `public localPart` → `String`


##### `public runAsUser` → `String`


##### `private authorizedSenders_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private localPart_type_info` → `String`


##### `private runAsUser_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetObjectPermissions
#### Fields

##### `public allowCreate` → `Boolean`


##### `public allowDelete` → `Boolean`


##### `public allowEdit` → `Boolean`


##### `public allowRead` → `Boolean`


##### `public modifyAllRecords` → `Boolean`


##### `public object_x` → `String`


##### `public viewAllRecords` → `Boolean`


##### `private allowCreate_type_info` → `String`


##### `private allowDelete_type_info` → `String`


##### `private allowEdit_type_info` → `String`


##### `private allowRead_type_info` → `String`


##### `private modifyAllRecords_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private viewAllRecords_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileApexClassAccess
#### Fields

##### `public apexClass` → `String`


##### `public enabled` → `Boolean`


##### `private apexClass_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileLoginIpRange
#### Fields

##### `public description` → `String`


##### `public endAddress` → `String`


##### `public startAddress` → `String`


##### `private description_type_info` → `String`


##### `private endAddress_type_info` → `String`


##### `private startAddress_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileSessionSetting

**Inheritance**

ProfileSessionSetting

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public externalCommunityUserIdentityVerif` → `Boolean`


##### `public forceLogout` → `Boolean`


##### `public profile` → `String`


##### `public requiredSessionLevel` → `String`


##### `public sessionPersistence` → `Boolean`


##### `public sessionTimeout` → `Integer`


##### `public sessionTimeoutWarning` → `Boolean`


##### `private externalCommunityUserIdentityVerif_type_info` → `String`


##### `private forceLogout_type_info` → `String`


##### `private profile_type_info` → `String`


##### `private requiredSessionLevel_type_info` → `String`


##### `private sessionPersistence_type_info` → `String`


##### `private sessionTimeout_type_info` → `String`


##### `private sessionTimeoutWarning_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardComponentColumn
#### Fields

##### `public breakPoint1` → `Double`


##### `public breakPoint2` → `Double`


##### `public breakPointOrder` → `Integer`


##### `public highRangeColor` → `Integer`


##### `public lowRangeColor` → `Integer`


##### `public midRangeColor` → `Integer`


##### `public reportColumn` → `String`


##### `public showTotal` → `Boolean`


##### `public type_x` → `String`


##### `private breakPoint1_type_info` → `String`


##### `private breakPoint2_type_info` → `String`


##### `private breakPointOrder_type_info` → `String`


##### `private highRangeColor_type_info` → `String`


##### `private lowRangeColor_type_info` → `String`


##### `private midRangeColor_type_info` → `String`


##### `private reportColumn_type_info` → `String`


##### `private showTotal_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowWait

**Inheritance**

FlowWait

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public defaultConnector` → `MetadataService`


##### `public defaultConnectorLabel` → `String`


##### `public faultConnector` → `MetadataService`


##### `public waitEvents` → `MetadataService.FlowWaitEvent`


##### `private defaultConnector_type_info` → `String`


##### `private defaultConnectorLabel_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private waitEvents_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowStage
#### Fields

##### `public isActive` → `Boolean`


##### `public label` → `String`


##### `public stageOrder` → `Integer`


##### `private isActive_type_info` → `String`


##### `private label_type_info` → `String`


##### `private stageOrder_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ChartSummary
#### Fields

##### `public aggregate` → `String`


##### `public axisBinding` → `String`


##### `public column` → `String`


##### `private aggregate_type_info` → `String`


##### `private axisBinding_type_info` → `String`


##### `private column_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### InstalledPackage

**Inheritance**

InstalledPackage

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public password` → `String`


##### `public versionNumber` → `String`


##### `private password_type_info` → `String`


##### `private versionNumber_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### NavigationMenuItem
#### Fields

##### `public defaultListViewId` → `String`


##### `public label` → `String`


##### `public position` → `Integer`


##### `public publiclyAvailable` → `Boolean`


##### `public subMenu` → `MetadataService`


##### `public target` → `String`


##### `public targetPreference` → `String`


##### `public type_x` → `String`


##### `private defaultListViewId_type_info` → `String`


##### `private label_type_info` → `String`


##### `private position_type_info` → `String`


##### `private publiclyAvailable_type_info` → `String`


##### `private subMenu_type_info` → `String`


##### `private target_type_info` → `String`


##### `private targetPreference_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### checkRetrieveStatus_element
#### Fields

##### `public asyncProcessId` → `String`


##### `public includeZip` → `Boolean`


##### `private asyncProcessId_type_info` → `String`


##### `private includeZip_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Country
#### Fields

##### `public active` → `Boolean`


##### `public integrationValue` → `String`


##### `public isoCode` → `String`


##### `public label` → `String`


##### `public orgDefault` → `Boolean`


##### `public standard` → `Boolean`


##### `public states` → `MetadataService.State`


##### `public visible` → `Boolean`


##### `private active_type_info` → `String`


##### `private integrationValue_type_info` → `String`


##### `private isoCode_type_info` → `String`


##### `private label_type_info` → `String`


##### `private orgDefault_type_info` → `String`


##### `private standard_type_info` → `String`


##### `private states_type_info` → `String`


##### `private visible_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ObjectUsage
#### Fields

##### `public object_x` → `String`


##### `private object_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Package_x

**Inheritance**

Package_x

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public apiAccessLevel` → `String`


##### `public description` → `String`


##### `public namespacePrefix` → `String`


##### `public objectPermissions` → `MetadataService.ProfileObjectPermissions`


##### `public packageType` → `String`


##### `public postInstallClass` → `String`


##### `public setupWeblink` → `String`


##### `public types` → `MetadataService.PackageTypeMembers`


##### `public uninstallClass` → `String`


##### `public version` → `String`


##### `private apiAccessLevel_type_info` → `String`


##### `private description_type_info` → `String`


##### `private namespacePrefix_type_info` → `String`


##### `private objectPermissions_type_info` → `String`


##### `private packageType_type_info` → `String`


##### `private postInstallClass_type_info` → `String`


##### `private setupWeblink_type_info` → `String`


##### `private types_type_info` → `String`


##### `private uninstallClass_type_info` → `String`


##### `private version_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SharingReasonTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomDataTypeComponentTranslation
#### Fields

##### `public developerSuffix` → `String`


##### `public label` → `String`


##### `private developerSuffix_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomNotificationType
#### Fields

##### `public customNotifTypeName` → `String`


##### `public description` → `String`


##### `public desktop` → `Boolean`


##### `public email` → `Boolean`


##### `public masterLabel` → `String`


##### `public mobile` → `Boolean`


##### `private customNotifTypeName_type_info` → `String`


##### `private description_type_info` → `String`


##### `private desktop_type_info` → `String`


##### `private email_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private mobile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FeedLayoutComponent
#### Fields

##### `public componentType` → `String`


##### `public height` → `Integer`


##### `public page_x` → `String`


##### `private componentType_type_info` → `String`


##### `private height_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AssistantRecommendationType
#### Fields

##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public platformActionlist` → `MetadataService`


##### `public sobjectType` → `String`


##### `public title` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private platformActionlist_type_info` → `String`


##### `private sobjectType_type_info` → `String`


##### `private title_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowCondition

**Inheritance**

FlowCondition

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public leftValueReference` → `String`


##### `public operator` → `String`


##### `public rightValue` → `MetadataService`


##### `private leftValueReference_type_info` → `String`


##### `private operator_type_info` → `String`


##### `private rightValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CallCenterSection
#### Fields

##### `public items` → `MetadataService.CallCenterItem`


##### `public label` → `String`


##### `public name` → `String`


##### `private items_type_info` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecommendationStrategy
#### Fields

##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public recommendationStrategyName` → `String`


##### `public strategyNode` → `MetadataService.StrategyNode`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private recommendationStrategyName_type_info` → `String`


##### `private strategyNode_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### WaveDashboard

**Inheritance**

WaveDashboard

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public application` → `String`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public templateAssetSourceName` → `String`


##### `private application_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private templateAssetSourceName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomApplication

**Inheritance**

CustomApplication

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public actionOverrides` → `MetadataService.AppActionOverride`


##### `public brand` → `MetadataService`


##### `public consoleConfig` → `MetadataService`


##### `public defaultLandingTab` → `String`


##### `public description` → `String`


##### `public formFactors` → `String`


##### `public isServiceCloudConsole` → `Boolean`


##### `public label` → `String`


##### `public logo` → `String`


##### `public navType` → `String`


##### `public preferences` → `MetadataService`


##### `public profileActionOverrides` → `MetadataService.AppProfileActionOverride`


##### `public setupExperience` → `String`


##### `public subscriberTabs` → `String`


##### `public tabs` → `String`


##### `public uiType` → `String`


##### `public utilityBar` → `String`


##### `public workspaceConfig` → `MetadataService`


##### `private actionOverrides_type_info` → `String`


##### `private brand_type_info` → `String`


##### `private consoleConfig_type_info` → `String`


##### `private defaultLandingTab_type_info` → `String`


##### `private description_type_info` → `String`


##### `private formFactors_type_info` → `String`


##### `private isServiceCloudConsole_type_info` → `String`


##### `private label_type_info` → `String`


##### `private logo_type_info` → `String`


##### `private navType_type_info` → `String`


##### `private preferences_type_info` → `String`


##### `private profileActionOverrides_type_info` → `String`


##### `private setupExperience_type_info` → `String`


##### `private subscriberTabs_type_info` → `String`


##### `private tabs_type_info` → `String`


##### `private uiType_type_info` → `String`


##### `private utilityBar_type_info` → `String`


##### `private workspaceConfig_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DescribeMetadataResult
#### Fields

##### `public metadataObjects` → `MetadataService.DescribeMetadataObject`


##### `public organizationNamespace` → `String`


##### `public partialSaveAllowed` → `Boolean`


##### `public testRequired` → `Boolean`


##### `private metadataObjects_type_info` → `String`


##### `private organizationNamespace_type_info` → `String`


##### `private partialSaveAllowed_type_info` → `String`


##### `private testRequired_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LeadConvertSettings

**Inheritance**

LeadConvertSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public allowOwnerChange` → `Boolean`


##### `public objectMapping` → `MetadataService.ObjectMapping`


##### `public opportunityCreationOptions` → `String`


##### `private allowOwnerChange_type_info` → `String`


##### `private objectMapping_type_info` → `String`


##### `private opportunityCreationOptions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### OpportunityListFieldsLabelMapping
#### Fields

##### `public field` → `String`


##### `public label` → `String`


##### `private field_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportType

**Inheritance**

ReportType

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public autogenerated` → `Boolean`


##### `public baseObject` → `String`


##### `public category` → `String`


##### `public deployed` → `Boolean`


##### `public description` → `String`


##### `public join_x` → `MetadataService`


##### `public label` → `String`


##### `public sections` → `MetadataService.ReportLayoutSection`


##### `private autogenerated_type_info` → `String`


##### `private baseObject_type_info` → `String`


##### `private category_type_info` → `String`


##### `private deployed_type_info` → `String`


##### `private description_type_info` → `String`


##### `private join_x_type_info` → `String`


##### `private label_type_info` → `String`


##### `private sections_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### deleteMetadataResponse_element
#### Fields

##### `public result` → `MetadataService.DeleteResult`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CodeLocation
#### Fields

##### `public column` → `Integer`


##### `public line` → `Integer`


##### `public numExecutions` → `Integer`


##### `public time_x` → `Double`


##### `private column_type_info` → `String`


##### `private line_type_info` → `String`


##### `private numExecutions_type_info` → `String`


##### `private time_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Keyword
#### Fields

##### `public keyword` → `String`


##### `private keyword_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetApplicationVisibility
#### Fields

##### `public application` → `String`


##### `public visible` → `Boolean`


##### `private application_type_info` → `String`


##### `private visible_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppActionOverride
#### Fields

##### `public pageOrSobjectType` → `String`


##### `private pageOrSobjectType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RoleAndSubordinates
#### Fields

##### `public roleAndSubordinate` → `String`


##### `private roleAndSubordinate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### StandardFieldTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmbeddedServiceBranding

**Inheritance**

EmbeddedServiceBranding

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public contrastInvertedColor` → `String`


##### `public contrastPrimaryColor` → `String`


##### `public embeddedServiceConfig` → `String`


##### `public font` → `String`


##### `public masterLabel` → `String`


##### `public navBarColor` → `String`


##### `public primaryColor` → `String`


##### `public secondaryColor` → `String`


##### `private contrastInvertedColor_type_info` → `String`


##### `private contrastPrimaryColor_type_info` → `String`


##### `private embeddedServiceConfig_type_info` → `String`


##### `private font_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private navBarColor_type_info` → `String`


##### `private primaryColor_type_info` → `String`


##### `private secondaryColor_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfilePasswordPolicy

**Inheritance**

ProfilePasswordPolicy

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public lockoutInterval` → `Integer`


##### `public maxLoginAttempts` → `Integer`


##### `public minimumPasswordLength` → `Integer`


##### `public minimumPasswordLifetime` → `Boolean`


##### `public obscure` → `Boolean`


##### `public passwordComplexity` → `Integer`


##### `public passwordExpiration` → `Integer`


##### `public passwordHistory` → `Integer`


##### `public passwordQuestion` → `Integer`


##### `public profile` → `String`


##### `private lockoutInterval_type_info` → `String`


##### `private maxLoginAttempts_type_info` → `String`


##### `private minimumPasswordLength_type_info` → `String`


##### `private minimumPasswordLifetime_type_info` → `String`


##### `private obscure_type_info` → `String`


##### `private passwordComplexity_type_info` → `String`


##### `private passwordExpiration_type_info` → `String`


##### `private passwordHistory_type_info` → `String`


##### `private passwordQuestion_type_info` → `String`


##### `private profile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### RecommendationAudienceDetail
#### Fields

##### `public audienceCriteriaType` → `String`


##### `public audienceCriteriaValue` → `String`


##### `public setupName` → `String`


##### `private audienceCriteriaType_type_info` → `String`


##### `private audienceCriteriaValue_type_info` → `String`


##### `private setupName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RoleOrTerritory

**Inheritance**

RoleOrTerritory

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public caseAccessLevel` → `String`


##### `public contactAccessLevel` → `String`


##### `public description` → `String`


##### `public mayForecastManagerShare` → `Boolean`


##### `public name` → `String`


##### `public opportunityAccessLevel` → `String`


##### `private caseAccessLevel_type_info` → `String`


##### `private contactAccessLevel_type_info` → `String`


##### `private description_type_info` → `String`


##### `private mayForecastManagerShare_type_info` → `String`


##### `private name_type_info` → `String`


##### `private opportunityAccessLevel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowSubflowInputAssignment

**Inheritance**

FlowSubflowInputAssignment

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public name` → `String`


##### `public value` → `MetadataService`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveChatButtonSkills
#### Fields

##### `public skill` → `String`


##### `private skill_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RemoteSiteSetting

**Inheritance**

RemoteSiteSetting

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public disableProtocolSecurity` → `Boolean`


##### `public isActive` → `Boolean`


##### `public url` → `String`


##### `private description_type_info` → `String`


##### `private disableProtocolSecurity_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private url_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppOauthConfig
#### Fields

##### `public assetTokenConfig` → `MetadataService`


##### `public callbackUrl` → `String`


##### `public certificate` → `String`


##### `public consumerKey` → `String`


##### `public consumerSecret` → `String`


##### `public idTokenConfig` → `MetadataService`


##### `public isAdminApproved` → `Boolean`


##### `public isClientCredentialEnabled` → `Boolean`


##### `public isConsumerSecretOptional` → `Boolean`


##### `public isIntrospectAllTokens` → `Boolean`


##### `public isSecretRequiredForRefreshToken` → `Boolean`


##### `public oauthClientCredentialUser` → `String`


##### `public scopes` → `String`


##### `public singleLogoutUrl` → `String`


##### `private assetTokenConfig_type_info` → `String`


##### `private callbackUrl_type_info` → `String`


##### `private certificate_type_info` → `String`


##### `private consumerKey_type_info` → `String`


##### `private consumerSecret_type_info` → `String`


##### `private idTokenConfig_type_info` → `String`


##### `private isAdminApproved_type_info` → `String`


##### `private isClientCredentialEnabled_type_info` → `String`


##### `private isConsumerSecretOptional_type_info` → `String`


##### `private isIntrospectAllTokens_type_info` → `String`


##### `private isSecretRequiredForRefreshToken_type_info` → `String`


##### `private oauthClientCredentialUser_type_info` → `String`


##### `private scopes_type_info` → `String`


##### `private singleLogoutUrl_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ObjectSearchSetting
#### Fields

##### `public enhancedLookupEnabled` → `Boolean`


##### `public lookupAutoCompleteEnabled` → `Boolean`


##### `public name` → `String`


##### `public resultsPerPageCount` → `Integer`


##### `private enhancedLookupEnabled_type_info` → `String`


##### `private lookupAutoCompleteEnabled_type_info` → `String`


##### `private name_type_info` → `String`


##### `private resultsPerPageCount_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### VisualizationResource
#### Fields

##### `public description` → `String`


##### `public file` → `String`


##### `public rank` → `Integer`


##### `public type_x` → `String`


##### `private description_type_info` → `String`


##### `private file_type_info` → `String`


##### `private rank_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldServiceSettings
#### Fields

##### `public fieldServiceNotificationsOrgPref` → `Boolean`


##### `public fieldServiceOrgPref` → `Boolean`


##### `public serviceAppointmentsDueDateOffsetOrgValue` → `Integer`


##### `public workOrderLineItemSearchFields` → `String`


##### `public workOrderSearchFields` → `String`


##### `private fieldServiceNotificationsOrgPref_type_info` → `String`


##### `private fieldServiceOrgPref_type_info` → `String`


##### `private serviceAppointmentsDueDateOffsetOrgValue_type_info` → `String`


##### `private workOrderLineItemSearchFields_type_info` → `String`


##### `private workOrderSearchFields_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### NextAutomatedApprover
#### Fields

##### `public useApproverFieldOfRecordOwner` → `Boolean`


##### `public userHierarchyField` → `String`


##### `private useApproverFieldOfRecordOwner_type_info` → `String`


##### `private userHierarchyField_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ValueSetValuesDefinition
#### Fields

##### `public sorted` → `Boolean`


##### `public value` → `MetadataService.CustomValue`


##### `private sorted_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2Rule
#### Fields

##### `public active` → `Boolean`


##### `public booleanFilter` → `String`


##### `public name` → `String`


##### `public objectType` → `String`


##### `public ruleItems` → `MetadataService.Territory2RuleItem`


##### `private active_type_info` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private name_type_info` → `String`


##### `private objectType_type_info` → `String`


##### `private ruleItems_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RetrieveMessage
#### Fields

##### `public fileName` → `String`


##### `public problem` → `String`


##### `private fileName_type_info` → `String`


##### `private problem_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ForecastingCategoryMapping
#### Fields

##### `public forecastingItemCategoryApiName` → `String`


##### `public weightedSourceCategories` → `MetadataService.WeightedSourceCategory`


##### `private forecastingItemCategoryApiName_type_info` → `String`


##### `private weightedSourceCategories_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EclairMap
#### Fields

##### `public boundingBoxBottom` → `Double`


##### `public boundingBoxLeft` → `Double`


##### `public boundingBoxRight` → `Double`


##### `public boundingBoxTop` → `Double`


##### `public mapLabel` → `String`


##### `public mapName` → `String`


##### `public projection` → `String`


##### `private boundingBoxBottom_type_info` → `String`


##### `private boundingBoxLeft_type_info` → `String`


##### `private boundingBoxRight_type_info` → `String`


##### `private boundingBoxTop_type_info` → `String`


##### `private mapLabel_type_info` → `String`


##### `private mapName_type_info` → `String`


##### `private projection_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### HistoryRetentionPolicy
#### Fields

##### `public archiveAfterMonths` → `Integer`


##### `public archiveRetentionYears` → `Integer`


##### `public description` → `String`


##### `public gracePeriodDays` → `Integer`


##### `private archiveAfterMonths_type_info` → `String`


##### `private archiveRetentionYears_type_info` → `String`


##### `private description_type_info` → `String`


##### `private gracePeriodDays_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowFormula

**Inheritance**

FlowFormula

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public dataType` → `String`


##### `public expression` → `String`


##### `public scale` → `Integer`


##### `private dataType_type_info` → `String`


##### `private expression_type_info` → `String`


##### `private scale_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### Picklist
#### Fields

##### `public controllingField` → `String`


##### `public picklistValues` → `MetadataService.PicklistValue`


##### `public restrictedPicklist` → `Boolean`


##### `public sorted` → `Boolean`


##### `private controllingField_type_info` → `String`


##### `private picklistValues_type_info` → `String`


##### `private restrictedPicklist_type_info` → `String`


##### `private sorted_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### deploy_element
#### Fields

##### `public ZipFile` → `String`


##### `public DeployOptions` → `MetadataService`


##### `private ZipFile_type_info` → `String`


##### `private DeployOptions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportTypeSectionTranslation
#### Fields

##### `public columns` → `MetadataService.ReportTypeColumnTranslation`


##### `public label` → `String`


##### `public name` → `String`


##### `private columns_type_info` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PersonalJourneySettings

**Inheritance**

PersonalJourneySettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableExactTargetForSalesforceApps` → `Boolean`


##### `private enableExactTargetForSalesforceApps_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### AppProfileActionOverride
#### Fields

##### `public profile` → `String`


##### `private profile_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomPermission

**Inheritance**

CustomPermission

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public connectedApp` → `String`


##### `public description` → `String`


##### `public label` → `String`


##### `public requiredPermission` → `MetadataService.CustomPermissionDependencyRequired`


##### `private connectedApp_type_info` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private requiredPermission_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DuplicateRule
#### Fields

##### `public actionOnInsert` → `String`


##### `public actionOnUpdate` → `String`


##### `public alertText` → `String`


##### `public description` → `String`


##### `public duplicateRuleFilter` → `MetadataService`


##### `public duplicateRuleMatchRules` → `MetadataService.DuplicateRuleMatchRule`


##### `public isActive` → `Boolean`


##### `public masterLabel` → `String`


##### `public operationsOnInsert` → `String`


##### `public operationsOnUpdate` → `String`


##### `public securityOption` → `String`


##### `public sortOrder` → `Integer`


##### `private actionOnInsert_type_info` → `String`


##### `private actionOnUpdate_type_info` → `String`


##### `private alertText_type_info` → `String`


##### `private description_type_info` → `String`


##### `private duplicateRuleFilter_type_info` → `String`


##### `private duplicateRuleMatchRules_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private operationsOnInsert_type_info` → `String`


##### `private operationsOnUpdate_type_info` → `String`


##### `private securityOption_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowScreenFieldOutputParameter
#### Fields

##### `public assignToReference` → `String`


##### `public name` → `String`


##### `private assignToReference_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AgentConfigSkills
#### Fields

##### `public skill` → `String`


##### `private skill_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DeployResult
#### Fields

##### `public canceledBy` → `String`


##### `public canceledByName` → `String`


##### `public checkOnly` → `Boolean`


##### `public completedDate` → `DateTime`


##### `public createdBy` → `String`


##### `public createdByName` → `String`


##### `public createdDate` → `DateTime`


##### `public details` → `MetadataService`


##### `public done` → `Boolean`


##### `public errorMessage` → `String`


##### `public errorStatusCode` → `String`


##### `public id` → `String`


##### `public ignoreWarnings` → `Boolean`


##### `public lastModifiedDate` → `DateTime`


##### `public numberComponentErrors` → `Integer`


##### `public numberComponentsDeployed` → `Integer`


##### `public numberComponentsTotal` → `Integer`


##### `public numberTestErrors` → `Integer`


##### `public numberTestsCompleted` → `Integer`


##### `public numberTestsTotal` → `Integer`


##### `public rollbackOnError` → `Boolean`


##### `public runTestsEnabled` → `Boolean`


##### `public startDate` → `DateTime`


##### `public stateDetail` → `String`


##### `public status` → `String`


##### `public success` → `Boolean`


##### `private canceledBy_type_info` → `String`


##### `private canceledByName_type_info` → `String`


##### `private checkOnly_type_info` → `String`


##### `private completedDate_type_info` → `String`


##### `private createdBy_type_info` → `String`


##### `private createdByName_type_info` → `String`


##### `private createdDate_type_info` → `String`


##### `private details_type_info` → `String`


##### `private done_type_info` → `String`


##### `private errorMessage_type_info` → `String`


##### `private errorStatusCode_type_info` → `String`


##### `private id_type_info` → `String`


##### `private ignoreWarnings_type_info` → `String`


##### `private lastModifiedDate_type_info` → `String`


##### `private numberComponentErrors_type_info` → `String`


##### `private numberComponentsDeployed_type_info` → `String`


##### `private numberComponentsTotal_type_info` → `String`


##### `private numberTestErrors_type_info` → `String`


##### `private numberTestsCompleted_type_info` → `String`


##### `private numberTestsTotal_type_info` → `String`


##### `private rollbackOnError_type_info` → `String`


##### `private runTestsEnabled_type_info` → `String`


##### `private startDate_type_info` → `String`


##### `private stateDetail_type_info` → `String`


##### `private status_type_info` → `String`


##### `private success_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### IdeaReputationLevel
#### Fields

##### `public name` → `String`


##### `public value` → `Integer`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmbeddedServiceConfig

**Inheritance**

EmbeddedServiceConfig

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public masterLabel` → `String`


##### `public site` → `String`


##### `private masterLabel_type_info` → `String`


##### `private site_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### WorkflowTimeTrigger
#### Fields

##### `public actions` → `MetadataService.WorkflowActionReference`


##### `public offsetFromField` → `String`


##### `public timeLength` → `String`


##### `public workflowTimeTriggerUnit` → `String`


##### `private actions_type_info` → `String`


##### `private offsetFromField_type_info` → `String`


##### `private timeLength_type_info` → `String`


##### `private workflowTimeTriggerUnit_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### AutoResponseRules

**Inheritance**

AutoResponseRules

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public autoResponseRule` → `MetadataService.AutoResponseRule`


##### `private autoResponseRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### LayoutTranslation
#### Fields

##### `public layout` → `String`


##### `public layoutType` → `String`


##### `public sections` → `MetadataService.LayoutSectionTranslation`


##### `private layout_type_info` → `String`


##### `private layoutType_type_info` → `String`


##### `private sections_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardFolder

**Inheritance**

DashboardFolder

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public accessType` → `String`


##### `public folderShares` → `MetadataService.FolderShare`


##### `public name` → `String`


##### `public publicFolderAccess` → `String`


##### `public sharedTo` → `MetadataService`


##### `private accessType_type_info` → `String`


##### `private folderShares_type_info` → `String`


##### `private name_type_info` → `String`


##### `private publicFolderAccess_type_info` → `String`


##### `private sharedTo_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ForecastingSettings

**Inheritance**

ForecastingSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public displayCurrency` → `String`


##### `public enableForecasts` → `Boolean`


##### `public forecastingCategoryMappings` → `MetadataService.ForecastingCategoryMapping`


##### `public forecastingDisplayedFamilySettings` → `MetadataService.ForecastingDisplayedFamilySettings`


##### `public forecastingTypeSettings` → `MetadataService.ForecastingTypeSettings`


##### `private displayCurrency_type_info` → `String`


##### `private enableForecasts_type_info` → `String`


##### `private forecastingCategoryMappings_type_info` → `String`


##### `private forecastingDisplayedFamilySettings_type_info` → `String`


##### `private forecastingTypeSettings_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportAggregateReference
#### Fields

##### `public aggregate` → `String`


##### `private aggregate_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityTemplateDefinition
#### Fields

##### `public baseTemplate` → `String`


##### `public bundlesInfo` → `MetadataService.CommunityTemplateBundleInfo`


##### `public category` → `String`


##### `public defaultBrandingSet` → `String`


##### `public defaultThemeDefinition` → `String`


##### `public description` → `String`


##### `public enableExtendedCleanUpOnDelete` → `Boolean`


##### `public masterLabel` → `String`


##### `public navigationLinkSet` → `MetadataService.NavigationLinkSet`


##### `public pageSetting` → `MetadataService.CommunityTemplatePageSetting`


##### `private baseTemplate_type_info` → `String`


##### `private bundlesInfo_type_info` → `String`


##### `private category_type_info` → `String`


##### `private defaultBrandingSet_type_info` → `String`


##### `private defaultThemeDefinition_type_info` → `String`


##### `private description_type_info` → `String`


##### `private enableExtendedCleanUpOnDelete_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private navigationLinkSet_type_info` → `String`


##### `private pageSetting_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardFilterOption
#### Fields

##### `public operator` → `String`


##### `public values` → `String`


##### `private operator_type_info` → `String`


##### `private values_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowConstant

**Inheritance**

FlowConstant

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public dataType` → `String`


##### `public value` → `MetadataService`


##### `private dataType_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ConnectedAppSamlConfig
#### Fields

##### `public acsUrl` → `String`


##### `public certificate` → `String`


##### `public encryptionCertificate` → `String`


##### `public encryptionType` → `String`


##### `public entityUrl` → `String`


##### `public issuer` → `String`


##### `public samlIdpSLOBindingEnum` → `String`


##### `public samlNameIdFormat` → `String`


##### `public samlSigningAlgoType` → `String`


##### `public samlSloUrl` → `String`


##### `public samlSubjectCustomAttr` → `String`


##### `public samlSubjectType` → `String`


##### `private acsUrl_type_info` → `String`


##### `private certificate_type_info` → `String`


##### `private encryptionCertificate_type_info` → `String`


##### `private encryptionType_type_info` → `String`


##### `private entityUrl_type_info` → `String`


##### `private issuer_type_info` → `String`


##### `private samlIdpSLOBindingEnum_type_info` → `String`


##### `private samlNameIdFormat_type_info` → `String`


##### `private samlSigningAlgoType_type_info` → `String`


##### `private samlSloUrl_type_info` → `String`


##### `private samlSubjectCustomAttr_type_info` → `String`


##### `private samlSubjectType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### LiveChatSensitiveDataRule
#### Fields

##### `public actionType` → `String`


##### `public description` → `String`


##### `public enforceOn` → `Integer`


##### `public isEnabled` → `Boolean`


##### `public pattern` → `String`


##### `public replacement` → `String`


##### `private actionType_type_info` → `String`


##### `private description_type_info` → `String`


##### `private enforceOn_type_info` → `String`


##### `private isEnabled_type_info` → `String`


##### `private pattern_type_info` → `String`


##### `private replacement_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ApprovalStepRejectBehavior
#### Fields

##### `public type_x` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### XOrgHubSharedObject
#### Fields

##### `public fields` → `String`


##### `public name` → `String`


##### `private fields_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### createMetadata_element
#### Fields

##### `public metadata` → `MetadataService.Metadata`


##### `private metadata_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ContentAsset

**Inheritance**

ContentAsset

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public format` → `String`


##### `public language` → `String`


##### `public masterLabel` → `String`


##### `public originNetwork` → `String`


##### `public relationships` → `MetadataService`


##### `public versions` → `MetadataService`


##### `private format_type_info` → `String`


##### `private language_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private originNetwork_type_info` → `String`


##### `private relationships_type_info` → `String`


##### `private versions_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### DuplicateRuleFilterItem
#### Fields

##### `public sortOrder` → `Integer`


##### `public table` → `String`


##### `private sortOrder_type_info` → `String`


##### `private table_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomPageWebLinkTranslation
#### Fields

##### `public label` → `String`


##### `public name` → `String`


##### `private label_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### describeMetadataResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomPermissionDependencyRequired
#### Fields

##### `public customPermission` → `String`


##### `public dependency` → `Boolean`


##### `private customPermission_type_info` → `String`


##### `private dependency_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileFieldLevelSecurity
#### Fields

##### `public editable` → `Boolean`


##### `public field` → `String`


##### `public readable` → `Boolean`


##### `private editable_type_info` → `String`


##### `private field_type_info` → `String`


##### `private readable_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### checkDeployStatus_element
#### Fields

##### `public asyncProcessId` → `String`


##### `public includeDetails` → `Boolean`


##### `private asyncProcessId_type_info` → `String`


##### `private includeDetails_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### MetadataWithContent

**Inheritance**

MetadataWithContent

#### Fields

##### `public content` → `String`


---

### RecommendationDefinitionDetail
#### Fields

##### `public actionUrl` → `String`


##### `public description` → `String`


##### `public linkText` → `String`


##### `public scheduledRecommendations` → `MetadataService`


##### `public setupName` → `String`


##### `public title` → `String`


##### `private actionUrl_type_info` → `String`


##### `private description_type_info` → `String`


##### `private linkText_type_info` → `String`


##### `private scheduledRecommendations_type_info` → `String`


##### `private setupName_type_info` → `String`


##### `private title_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowActionCallInputParameter

**Inheritance**

FlowActionCallInputParameter

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public name` → `String`


##### `public value` → `MetadataService`


##### `private name_type_info` → `String`


##### `private value_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SkillUserAssignments
#### Fields

##### `public user_x` → `String`


##### `private user_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### checkDeployStatusResponse_element
#### Fields

##### `public result` → `MetadataService`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowRecordUpdate

**Inheritance**

FlowRecordUpdate

#### Fields

##### `public type` → `String`


##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


##### `private processMetadataValues_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `public label` → `String`


##### `public locationX` → `Integer`


##### `public locationY` → `Integer`


##### `private label_type_info` → `String`


##### `private locationX_type_info` → `String`


##### `private locationY_type_info` → `String`


##### `public connector` → `MetadataService`


##### `public faultConnector` → `MetadataService`


##### `public filters` → `MetadataService.FlowRecordFilter`


##### `public inputAssignments` → `MetadataService.FlowInputFieldAssignment`


##### `public inputReference` → `String`


##### `public object_x` → `String`


##### `private connector_type_info` → `String`


##### `private faultConnector_type_info` → `String`


##### `private filters_type_info` → `String`


##### `private inputAssignments_type_info` → `String`


##### `private inputReference_type_info` → `String`


##### `private object_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowInputValidationRuleTranslation
#### Fields

##### `public errorMessage` → `String`


##### `private errorMessage_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CleanRule
#### Fields

##### `public bulkEnabled` → `Boolean`


##### `public bypassTriggers` → `Boolean`


##### `public bypassWorkflow` → `Boolean`


##### `public description` → `String`


##### `public developerName` → `String`


##### `public fieldMappings` → `MetadataService.FieldMapping`


##### `public masterLabel` → `String`


##### `public matchRule` → `String`


##### `public sourceSobjectType` → `String`


##### `public status` → `String`


##### `public targetSobjectType` → `String`


##### `private bulkEnabled_type_info` → `String`


##### `private bypassTriggers_type_info` → `String`


##### `private bypassWorkflow_type_info` → `String`


##### `private description_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private fieldMappings_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private matchRule_type_info` → `String`


##### `private sourceSobjectType_type_info` → `String`


##### `private status_type_info` → `String`


##### `private targetSobjectType_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardComponent
#### Fields

##### `public autoselectColumnsFromReport` → `Boolean`


##### `public chartAxisRange` → `String`


##### `public chartAxisRangeMax` → `Double`


##### `public chartAxisRangeMin` → `Double`


##### `public chartSummary` → `MetadataService.ChartSummary`


##### `public componentChartTheme` → `String`


##### `public componentType` → `String`


##### `public dashboardFilterColumns` → `MetadataService.DashboardFilterColumn`


##### `public dashboardTableColumn` → `MetadataService.DashboardTableColumn`


##### `public displayUnits` → `String`


##### `public drillDownUrl` → `String`


##### `public drillEnabled` → `Boolean`


##### `public drillToDetailEnabled` → `Boolean`


##### `public enableHover` → `Boolean`


##### `public expandOthers` → `Boolean`


##### `public flexComponentProperties` → `MetadataService`


##### `public footer` → `String`


##### `public gaugeMax` → `Double`


##### `public gaugeMin` → `Double`


##### `public groupingColumn` → `String`


##### `public header` → `String`


##### `public indicatorBreakpoint1` → `Double`


##### `public indicatorBreakpoint2` → `Double`


##### `public indicatorHighColor` → `String`


##### `public indicatorLowColor` → `String`


##### `public indicatorMiddleColor` → `String`


##### `public legendPosition` → `String`


##### `public maxValuesDisplayed` → `Integer`


##### `public metricLabel` → `String`


##### `public page_x` → `String`


##### `public pageHeightInPixels` → `Integer`


##### `public report` → `String`


##### `public scontrol` → `String`


##### `public scontrolHeightInPixels` → `Integer`


##### `public showPercentage` → `Boolean`


##### `public showPicturesOnCharts` → `Boolean`


##### `public showPicturesOnTables` → `Boolean`


##### `public showRange` → `Boolean`


##### `public showTotal` → `Boolean`


##### `public showValues` → `Boolean`


##### `public sortBy` → `String`


##### `public title` → `String`


##### `public useReportChart` → `Boolean`


##### `private autoselectColumnsFromReport_type_info` → `String`


##### `private chartAxisRange_type_info` → `String`


##### `private chartAxisRangeMax_type_info` → `String`


##### `private chartAxisRangeMin_type_info` → `String`


##### `private chartSummary_type_info` → `String`


##### `private componentChartTheme_type_info` → `String`


##### `private componentType_type_info` → `String`


##### `private dashboardFilterColumns_type_info` → `String`


##### `private dashboardTableColumn_type_info` → `String`


##### `private displayUnits_type_info` → `String`


##### `private drillDownUrl_type_info` → `String`


##### `private drillEnabled_type_info` → `String`


##### `private drillToDetailEnabled_type_info` → `String`


##### `private enableHover_type_info` → `String`


##### `private expandOthers_type_info` → `String`


##### `private flexComponentProperties_type_info` → `String`


##### `private footer_type_info` → `String`


##### `private gaugeMax_type_info` → `String`


##### `private gaugeMin_type_info` → `String`


##### `private groupingColumn_type_info` → `String`


##### `private header_type_info` → `String`


##### `private indicatorBreakpoint1_type_info` → `String`


##### `private indicatorBreakpoint2_type_info` → `String`


##### `private indicatorHighColor_type_info` → `String`


##### `private indicatorLowColor_type_info` → `String`


##### `private indicatorMiddleColor_type_info` → `String`


##### `private legendPosition_type_info` → `String`


##### `private maxValuesDisplayed_type_info` → `String`


##### `private metricLabel_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private pageHeightInPixels_type_info` → `String`


##### `private report_type_info` → `String`


##### `private scontrol_type_info` → `String`


##### `private scontrolHeightInPixels_type_info` → `String`


##### `private showPercentage_type_info` → `String`


##### `private showPicturesOnCharts_type_info` → `String`


##### `private showPicturesOnTables_type_info` → `String`


##### `private showRange_type_info` → `String`


##### `private showTotal_type_info` → `String`


##### `private showValues_type_info` → `String`


##### `private sortBy_type_info` → `String`


##### `private title_type_info` → `String`


##### `private useReportChart_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportColorRange
#### Fields

##### `public aggregate` → `String`


##### `public columnName` → `String`


##### `public highBreakpoint` → `Double`


##### `public highColor` → `String`


##### `public lowBreakpoint` → `Double`


##### `public lowColor` → `String`


##### `public midColor` → `String`


##### `private aggregate_type_info` → `String`


##### `private columnName_type_info` → `String`


##### `private highBreakpoint_type_info` → `String`


##### `private highColor_type_info` → `String`


##### `private lowBreakpoint_type_info` → `String`


##### `private lowColor_type_info` → `String`


##### `private midColor_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### OrganizationSettingsDetail
#### Fields

##### `public settingName` → `String`


##### `public settingValue` → `Boolean`


##### `private settingName_type_info` → `String`


##### `private settingValue_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EclairGeoData

**Inheritance**

EclairGeoData

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public content` → `String`


##### `private content_type_info` → `String`


##### `public maps` → `MetadataService.EclairMap`


##### `public masterLabel` → `String`


##### `private maps_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### SummaryLayout
#### Fields

##### `public masterLabel` → `String`


##### `public sizeX` → `Integer`


##### `public sizeY` → `Integer`


##### `public sizeZ` → `Integer`


##### `public summaryLayoutItems` → `MetadataService.SummaryLayoutItem`


##### `public summaryLayoutStyle` → `String`


##### `private masterLabel_type_info` → `String`


##### `private sizeX_type_info` → `String`


##### `private sizeY_type_info` → `String`


##### `private sizeZ_type_info` → `String`


##### `private summaryLayoutItems_type_info` → `String`


##### `private summaryLayoutStyle_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### GlobalValueSet

**Inheritance**

GlobalValueSet

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public customValue` → `MetadataService.CustomValue`


##### `public description` → `String`


##### `public masterLabel` → `String`


##### `public sorted` → `Boolean`


##### `private customValue_type_info` → `String`


##### `private description_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private sorted_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### QuickActionLayout
#### Fields

##### `public layoutSectionStyle` → `String`


##### `public quickActionLayoutColumns` → `MetadataService.QuickActionLayoutColumn`


##### `private layoutSectionStyle_type_info` → `String`


##### `private quickActionLayoutColumns_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### Territory2Type

**Inheritance**

Territory2Type

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public description` → `String`


##### `public name` → `String`


##### `public priority` → `Integer`


##### `private description_type_info` → `String`


##### `private name_type_info` → `String`


##### `private priority_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### listMetadataResponse_element
#### Fields

##### `public result` → `MetadataService.FileProperties`


##### `private result_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityCustomThemeLayoutType
#### Fields

##### `public description` → `String`


##### `public label` → `String`


##### `private description_type_info` → `String`


##### `private label_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CommunityTemplatePageSetting
#### Fields

##### `public page_x` → `String`


##### `public themeLayout` → `String`


##### `private page_x_type_info` → `String`


##### `private themeLayout_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SamlSsoConfig

**Inheritance**

SamlSsoConfig

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public attributeName` → `String`


##### `public attributeNameIdFormat` → `String`


##### `public decryptionCertificate` → `String`


##### `public errorUrl` → `String`


##### `public executionUserId` → `String`


##### `public identityLocation` → `String`


##### `public identityMapping` → `String`


##### `public issuer` → `String`


##### `public loginUrl` → `String`


##### `public logoutUrl` → `String`


##### `public name` → `String`


##### `public oauthTokenEndpoint` → `String`


##### `public redirectBinding` → `Boolean`


##### `public requestSignatureMethod` → `String`


##### `public requestSigningCertId` → `String`


##### `public salesforceLoginUrl` → `String`


##### `public samlEntityId` → `String`


##### `public samlJitHandlerId` → `String`


##### `public samlVersion` → `String`


##### `public singleLogoutBinding` → `String`


##### `public singleLogoutUrl` → `String`


##### `public userProvisioning` → `Boolean`


##### `public validationCert` → `String`


##### `private attributeName_type_info` → `String`


##### `private attributeNameIdFormat_type_info` → `String`


##### `private decryptionCertificate_type_info` → `String`


##### `private errorUrl_type_info` → `String`


##### `private executionUserId_type_info` → `String`


##### `private identityLocation_type_info` → `String`


##### `private identityMapping_type_info` → `String`


##### `private issuer_type_info` → `String`


##### `private loginUrl_type_info` → `String`


##### `private logoutUrl_type_info` → `String`


##### `private name_type_info` → `String`


##### `private oauthTokenEndpoint_type_info` → `String`


##### `private redirectBinding_type_info` → `String`


##### `private requestSignatureMethod_type_info` → `String`


##### `private requestSigningCertId_type_info` → `String`


##### `private salesforceLoginUrl_type_info` → `String`


##### `private samlEntityId_type_info` → `String`


##### `private samlJitHandlerId_type_info` → `String`


##### `private samlVersion_type_info` → `String`


##### `private singleLogoutBinding_type_info` → `String`


##### `private singleLogoutUrl_type_info` → `String`


##### `private userProvisioning_type_info` → `String`


##### `private validationCert_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### describeValueType_element
#### Fields

##### `public type_x` → `String`


##### `private type_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReputationLevels
#### Fields

##### `public chatterAnswersReputationLevels` → `MetadataService.ChatterAnswersReputationLevel`


##### `public ideaReputationLevels` → `MetadataService.IdeaReputationLevel`


##### `private chatterAnswersReputationLevels_type_info` → `String`


##### `private ideaReputationLevels_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowBaseElement
#### Fields

##### `public processMetadataValues` → `MetadataService.FlowMetadataValue`


---

### WaveXmdMeasure
#### Fields

##### `public dateFormat` → `String`


##### `public description` → `String`


##### `public field` → `String`


##### `public formatCustomFormat` → `String`


##### `public formatDecimalDigits` → `Integer`


##### `public formatIsNegativeParens` → `Boolean`


##### `public formatPrefix` → `String`


##### `public formatSuffix` → `String`


##### `public formatUnit` → `String`


##### `public formatUnitMultiplier` → `Double`


##### `public fullyQualifiedName` → `String`


##### `public isDerived` → `Boolean`


##### `public label` → `String`


##### `public origin` → `String`


##### `public showDetailsDefaultFieldIndex` → `Integer`


##### `public showInExplorer` → `Boolean`


##### `public sortIndex` → `Integer`


##### `private dateFormat_type_info` → `String`


##### `private description_type_info` → `String`


##### `private field_type_info` → `String`


##### `private formatCustomFormat_type_info` → `String`


##### `private formatDecimalDigits_type_info` → `String`


##### `private formatIsNegativeParens_type_info` → `String`


##### `private formatPrefix_type_info` → `String`


##### `private formatSuffix_type_info` → `String`


##### `private formatUnit_type_info` → `String`


##### `private formatUnitMultiplier_type_info` → `String`


##### `private fullyQualifiedName_type_info` → `String`


##### `private isDerived_type_info` → `String`


##### `private label_type_info` → `String`


##### `private origin_type_info` → `String`


##### `private showDetailsDefaultFieldIndex_type_info` → `String`


##### `private showInExplorer_type_info` → `String`


##### `private sortIndex_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### SidebarComponent
#### Fields

##### `public componentType` → `String`


##### `public createAction` → `String`


##### `public enableLinking` → `Boolean`


##### `public height` → `Integer`


##### `public label` → `String`


##### `public lookup` → `String`


##### `public page_x` → `String`


##### `public relatedLists` → `MetadataService.RelatedList`


##### `public unit` → `String`


##### `public updateAction` → `String`


##### `public width` → `Integer`


##### `private componentType_type_info` → `String`


##### `private createAction_type_info` → `String`


##### `private enableLinking_type_info` → `String`


##### `private height_type_info` → `String`


##### `private label_type_info` → `String`


##### `private lookup_type_info` → `String`


##### `private page_x_type_info` → `String`


##### `private relatedLists_type_info` → `String`


##### `private unit_type_info` → `String`


##### `private updateAction_type_info` → `String`


##### `private width_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### PermissionSetGroup
#### Fields

##### `public description` → `String`


##### `public isCalculatingChanges` → `Boolean`


##### `public label` → `String`


##### `public permissionSets` → `String`


##### `private description_type_info` → `String`


##### `private isCalculatingChanges_type_info` → `String`


##### `private label_type_info` → `String`


##### `private permissionSets_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### TransactionSecurityNotification
#### Fields

##### `public inApp` → `Boolean`


##### `public sendEmail` → `Boolean`


##### `public user_x` → `String`


##### `private inApp_type_info` → `String`


##### `private sendEmail_type_info` → `String`


##### `private user_x_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportColumn
#### Fields

##### `public aggregateTypes` → `String`


##### `public field` → `String`


##### `public reverseColors` → `Boolean`


##### `public showChanges` → `Boolean`


##### `private aggregateTypes_type_info` → `String`


##### `private field_type_info` → `String`


##### `private reverseColors_type_info` → `String`


##### `private showChanges_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### BusinessHoursSettings

**Inheritance**

BusinessHoursSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public businessHours` → `MetadataService.BusinessHoursEntry`


##### `public holidays` → `MetadataService.Holiday`


##### `private businessHours_type_info` → `String`


##### `private holidays_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### TopicsForObjects

**Inheritance**

TopicsForObjects

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public enableTopics` → `Boolean`


##### `public entityApiName` → `String`


##### `private enableTopics_type_info` → `String`


##### `private entityApiName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### FlowChoiceUserInputTranslation
#### Fields

##### `public promptText` → `String`


##### `public validationRule` → `MetadataService`


##### `private promptText_type_info` → `String`


##### `private validationRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FieldSetItem
#### Fields

##### `public field` → `String`


##### `public isFieldManaged` → `Boolean`


##### `public isRequired` → `Boolean`


##### `private field_type_info` → `String`


##### `private isFieldManaged_type_info` → `String`


##### `private isRequired_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ProfileUserPermission
#### Fields

##### `public enabled` → `Boolean`


##### `public name` → `String`


##### `private enabled_type_info` → `String`


##### `private name_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### FindSimilarOppFilter
#### Fields

##### `public similarOpportunitiesDisplayColumns` → `String`


##### `public similarOpportunitiesMatchFields` → `String`


##### `private similarOpportunitiesDisplayColumns_type_info` → `String`


##### `private similarOpportunitiesMatchFields_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ReportAggregate
#### Fields

##### `public acrossGroupingContext` → `String`


##### `public calculatedFormula` → `String`


##### `public datatype` → `String`


##### `public description` → `String`


##### `public developerName` → `String`


##### `public downGroupingContext` → `String`


##### `public isActive` → `Boolean`


##### `public isCrossBlock` → `Boolean`


##### `public masterLabel` → `String`


##### `public reportType` → `String`


##### `public scale` → `Integer`


##### `private acrossGroupingContext_type_info` → `String`


##### `private calculatedFormula_type_info` → `String`


##### `private datatype_type_info` → `String`


##### `private description_type_info` → `String`


##### `private developerName_type_info` → `String`


##### `private downGroupingContext_type_info` → `String`


##### `private isActive_type_info` → `String`


##### `private isCrossBlock_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private reportType_type_info` → `String`


##### `private scale_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### ContractSettings

**Inheritance**

ContractSettings

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public autoCalculateEndDate` → `Boolean`


##### `public autoExpirationDelay` → `String`


##### `public autoExpirationRecipient` → `String`


##### `public autoExpireContracts` → `Boolean`


##### `public enableContractHistoryTracking` → `Boolean`


##### `public notifyOwnersOnContractExpiration` → `Boolean`


##### `private autoCalculateEndDate_type_info` → `String`


##### `private autoExpirationDelay_type_info` → `String`


##### `private autoExpirationRecipient_type_info` → `String`


##### `private autoExpireContracts_type_info` → `String`


##### `private enableContractHistoryTracking_type_info` → `String`


##### `private notifyOwnersOnContractExpiration_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### EscalationRules

**Inheritance**

EscalationRules

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public escalationRule` → `MetadataService.EscalationRule`


##### `private escalationRule_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### NetworkTabSet
#### Fields

##### `public customTab` → `String`


##### `public defaultTab` → `String`


##### `public standardTab` → `String`


##### `private customTab_type_info` → `String`


##### `private defaultTab_type_info` → `String`


##### `private standardTab_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### EmbeddedServiceLiveAgent

**Inheritance**

EmbeddedServiceLiveAgent

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public avatarImg` → `String`


##### `public customPrechatComponent` → `String`


##### `public embeddedServiceConfig` → `String`


##### `public embeddedServiceQuickActions` → `MetadataService.EmbeddedServiceQuickAction`


##### `public enabled` → `Boolean`


##### `public fontSize` → `String`


##### `public headerBackgroundImg` → `String`


##### `public liveAgentChatUrl` → `String`


##### `public liveAgentContentUrl` → `String`


##### `public liveChatButton` → `String`


##### `public liveChatDeployment` → `String`


##### `public masterLabel` → `String`


##### `public prechatBackgroundImg` → `String`


##### `public prechatEnabled` → `Boolean`


##### `public prechatJson` → `String`


##### `public scenario` → `String`


##### `public smallCompanyLogoImg` → `String`


##### `public waitingStateBackgroundImg` → `String`


##### `private avatarImg_type_info` → `String`


##### `private customPrechatComponent_type_info` → `String`


##### `private embeddedServiceConfig_type_info` → `String`


##### `private embeddedServiceQuickActions_type_info` → `String`


##### `private enabled_type_info` → `String`


##### `private fontSize_type_info` → `String`


##### `private headerBackgroundImg_type_info` → `String`


##### `private liveAgentChatUrl_type_info` → `String`


##### `private liveAgentContentUrl_type_info` → `String`


##### `private liveChatButton_type_info` → `String`


##### `private liveChatDeployment_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private prechatBackgroundImg_type_info` → `String`


##### `private prechatEnabled_type_info` → `String`


##### `private prechatJson_type_info` → `String`


##### `private scenario_type_info` → `String`


##### `private smallCompanyLogoImg_type_info` → `String`


##### `private waitingStateBackgroundImg_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomField

**Inheritance**

CustomField

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public businessOwnerGroup` → `String`


##### `public businessOwnerUser` → `String`


##### `public businessStatus` → `String`


##### `public caseSensitive` → `Boolean`


##### `public customDataType` → `String`


##### `public defaultValue` → `String`


##### `public deleteConstraint` → `String`


##### `public deprecated` → `Boolean`


##### `public description` → `String`


##### `public displayFormat` → `String`


##### `public displayLocationInDecimal` → `Boolean`


##### `public encrypted` → `Boolean`


##### `public escapeMarkup` → `Boolean`


##### `public externalDeveloperName` → `String`


##### `public externalId` → `Boolean`


##### `public fieldManageability` → `String`


##### `public formula` → `String`


##### `public formulaTreatBlanksAs` → `String`


##### `public inlineHelpText` → `String`


##### `public isConvertLeadDisabled` → `Boolean`


##### `public isFilteringDisabled` → `Boolean`


##### `public isNameField` → `Boolean`


##### `public isSortingDisabled` → `Boolean`


##### `public label` → `String`


##### `public length` → `Integer`


##### `public lookupFilter` → `MetadataService`


##### `public maskChar` → `String`


##### `public maskType` → `String`


##### `public metadataRelationshipControllingField` → `String`


##### `public populateExistingRows` → `Boolean`


##### `public precision` → `Integer`


##### `public referenceTargetField` → `String`


##### `public referenceTo` → `String`


##### `public relationshipLabel` → `String`


##### `public relationshipName` → `String`


##### `public relationshipOrder` → `Integer`


##### `public reparentableMasterDetail` → `Boolean`


##### `public required` → `Boolean`


##### `public restrictedAdminField` → `Boolean`


##### `public scale` → `Integer`


##### `public securityClassification` → `String`


##### `public startingNumber` → `Integer`


##### `public stripMarkup` → `Boolean`


##### `public summarizedField` → `String`


##### `public summaryFilterItems` → `MetadataService.FilterItem`


##### `public summaryForeignKey` → `String`


##### `public summaryOperation` → `String`


##### `public trackFeedHistory` → `Boolean`


##### `public trackHistory` → `Boolean`


##### `public trackTrending` → `Boolean`


##### `public type_x` → `String`


##### `public unique` → `Boolean`


##### `public valueSet` → `MetadataService`


##### `public visibleLines` → `Integer`


##### `public writeRequiresMasterRead` → `Boolean`


##### `private businessOwnerGroup_type_info` → `String`


##### `private businessOwnerUser_type_info` → `String`


##### `private businessStatus_type_info` → `String`


##### `private caseSensitive_type_info` → `String`


##### `private customDataType_type_info` → `String`


##### `private defaultValue_type_info` → `String`


##### `private deleteConstraint_type_info` → `String`


##### `private deprecated_type_info` → `String`


##### `private description_type_info` → `String`


##### `private displayFormat_type_info` → `String`


##### `private displayLocationInDecimal_type_info` → `String`


##### `private encrypted_type_info` → `String`


##### `private escapeMarkup_type_info` → `String`


##### `private externalDeveloperName_type_info` → `String`


##### `private externalId_type_info` → `String`


##### `private fieldManageability_type_info` → `String`


##### `private formula_type_info` → `String`


##### `private formulaTreatBlanksAs_type_info` → `String`


##### `private inlineHelpText_type_info` → `String`


##### `private isConvertLeadDisabled_type_info` → `String`


##### `private isFilteringDisabled_type_info` → `String`


##### `private isNameField_type_info` → `String`


##### `private isSortingDisabled_type_info` → `String`


##### `private label_type_info` → `String`


##### `private length_type_info` → `String`


##### `private lookupFilter_type_info` → `String`


##### `private maskChar_type_info` → `String`


##### `private maskType_type_info` → `String`


##### `private metadataRelationshipControllingField_type_info` → `String`


##### `private populateExistingRows_type_info` → `String`


##### `private precision_type_info` → `String`


##### `private referenceTargetField_type_info` → `String`


##### `private referenceTo_type_info` → `String`


##### `private relationshipLabel_type_info` → `String`


##### `private relationshipName_type_info` → `String`


##### `private relationshipOrder_type_info` → `String`


##### `private reparentableMasterDetail_type_info` → `String`


##### `private required_type_info` → `String`


##### `private restrictedAdminField_type_info` → `String`


##### `private scale_type_info` → `String`


##### `private securityClassification_type_info` → `String`


##### `private startingNumber_type_info` → `String`


##### `private stripMarkup_type_info` → `String`


##### `private summarizedField_type_info` → `String`


##### `private summaryFilterItems_type_info` → `String`


##### `private summaryForeignKey_type_info` → `String`


##### `private summaryOperation_type_info` → `String`


##### `private trackFeedHistory_type_info` → `String`


##### `private trackHistory_type_info` → `String`


##### `private trackTrending_type_info` → `String`


##### `private type_x_type_info` → `String`


##### `private unique_type_info` → `String`


##### `private valueSet_type_info` → `String`


##### `private visibleLines_type_info` → `String`


##### `private writeRequiresMasterRead_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### KeywordList
#### Fields

##### `public description` → `String`


##### `public keywords` → `MetadataService.Keyword`


##### `public masterLabel` → `String`


##### `private description_type_info` → `String`


##### `private keywords_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### MatchingRuleItem
#### Fields

##### `public blankValueBehavior` → `String`


##### `public fieldName` → `String`


##### `public matchingMethod` → `String`


##### `private blankValueBehavior_type_info` → `String`


##### `private fieldName_type_info` → `String`


##### `private matchingMethod_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### RuleEntry
#### Fields

##### `public assignedTo` → `String`


##### `public assignedToType` → `String`


##### `public booleanFilter` → `String`


##### `public businessHours` → `String`


##### `public businessHoursSource` → `String`


##### `public criteriaItems` → `MetadataService.FilterItem`


##### `public disableEscalationWhenModified` → `Boolean`


##### `public escalationAction` → `MetadataService.EscalationAction`


##### `public escalationStartTime` → `String`


##### `public formula` → `String`


##### `public notifyCcRecipients` → `Boolean`


##### `public overrideExistingTeams` → `Boolean`


##### `public replyToEmail` → `String`


##### `public senderEmail` → `String`


##### `public senderName` → `String`


##### `public team` → `String`


##### `public template` → `String`


##### `private assignedTo_type_info` → `String`


##### `private assignedToType_type_info` → `String`


##### `private booleanFilter_type_info` → `String`


##### `private businessHours_type_info` → `String`


##### `private businessHoursSource_type_info` → `String`


##### `private criteriaItems_type_info` → `String`


##### `private disableEscalationWhenModified_type_info` → `String`


##### `private escalationAction_type_info` → `String`


##### `private escalationStartTime_type_info` → `String`


##### `private formula_type_info` → `String`


##### `private notifyCcRecipients_type_info` → `String`


##### `private overrideExistingTeams_type_info` → `String`


##### `private replyToEmail_type_info` → `String`


##### `private senderEmail_type_info` → `String`


##### `private senderName_type_info` → `String`


##### `private team_type_info` → `String`


##### `private template_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### DashboardComponentSortInfo
#### Fields

##### `public sortColumn` → `String`


##### `public sortOrder` → `String`


##### `private sortColumn_type_info` → `String`


##### `private sortOrder_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### CustomObjectTranslation

**Inheritance**

CustomObjectTranslation

#### Fields

##### `public type` → `String`


##### `public fullName` → `String`


##### `private fullName_type_info` → `String`


##### `public caseValues` → `MetadataService.ObjectNameCaseValue`


##### `public fieldSets` → `MetadataService.FieldSetTranslation`


##### `public fields` → `MetadataService.CustomFieldTranslation`


##### `public gender` → `String`


##### `public layouts` → `MetadataService.LayoutTranslation`


##### `public nameFieldLabel` → `String`


##### `public quickActions` → `MetadataService.QuickActionTranslation`


##### `public recordTypes` → `MetadataService.RecordTypeTranslation`


##### `public sharingReasons` → `MetadataService.SharingReasonTranslation`


##### `public standardFields` → `MetadataService.StandardFieldTranslation`


##### `public startsWith` → `String`


##### `public validationRules` → `MetadataService.ValidationRuleTranslation`


##### `public webLinks` → `MetadataService.WebLinkTranslation`


##### `public workflowTasks` → `MetadataService.WorkflowTaskTranslation`


##### `private caseValues_type_info` → `String`


##### `private fieldSets_type_info` → `String`


##### `private fields_type_info` → `String`


##### `private gender_type_info` → `String`


##### `private layouts_type_info` → `String`


##### `private nameFieldLabel_type_info` → `String`


##### `private quickActions_type_info` → `String`


##### `private recordTypes_type_info` → `String`


##### `private sharingReasons_type_info` → `String`


##### `private standardFields_type_info` → `String`


##### `private startsWith_type_info` → `String`


##### `private validationRules_type_info` → `String`


##### `private webLinks_type_info` → `String`


##### `private workflowTasks_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private type_att_info` → `String`


##### `private field_order_type_info` → `String`


---

### ForecastingTypeSettings
#### Fields

##### `public active` → `Boolean`


##### `public adjustmentsSettings` → `MetadataService`


##### `public displayedCategoryApiNames` → `String`


##### `public forecastRangeSettings` → `MetadataService`


##### `public forecastedCategoryApiNames` → `String`


##### `public forecastingDateType` → `String`


##### `public hasProductFamily` → `Boolean`


##### `public isAmount` → `Boolean`


##### `public isAvailable` → `Boolean`


##### `public isQuantity` → `Boolean`


##### `public managerAdjustableCategoryApiNames` → `String`


##### `public masterLabel` → `String`


##### `public name` → `String`


##### `public opportunityListFieldsLabelMappings` → `MetadataService.OpportunityListFieldsLabelMapping`


##### `public opportunityListFieldsSelectedSettings` → `MetadataService`


##### `public opportunityListFieldsUnselectedSettings` → `MetadataService`


##### `public opportunitySplitName` → `String`


##### `public ownerAdjustableCategoryApiNames` → `String`


##### `public quotasSettings` → `MetadataService`


##### `public territory2ModelName` → `String`


##### `private active_type_info` → `String`


##### `private adjustmentsSettings_type_info` → `String`


##### `private displayedCategoryApiNames_type_info` → `String`


##### `private forecastRangeSettings_type_info` → `String`


##### `private forecastedCategoryApiNames_type_info` → `String`


##### `private forecastingDateType_type_info` → `String`


##### `private hasProductFamily_type_info` → `String`


##### `private isAmount_type_info` → `String`


##### `private isAvailable_type_info` → `String`


##### `private isQuantity_type_info` → `String`


##### `private managerAdjustableCategoryApiNames_type_info` → `String`


##### `private masterLabel_type_info` → `String`


##### `private name_type_info` → `String`


##### `private opportunityListFieldsLabelMappings_type_info` → `String`


##### `private opportunityListFieldsSelectedSettings_type_info` → `String`


##### `private opportunityListFieldsUnselectedSettings_type_info` → `String`


##### `private opportunitySplitName_type_info` → `String`


##### `private ownerAdjustableCategoryApiNames_type_info` → `String`


##### `private quotasSettings_type_info` → `String`


##### `private territory2ModelName_type_info` → `String`


##### `private apex_schema_type_info` → `String`


##### `private field_order_type_info` → `String`


---

### MetadataPort
#### Fields

##### `public endpoint_x` → `String`


##### `public inputHttpHeaders_x` → `Map&lt;String,String&gt;`


##### `public outputHttpHeaders_x` → `Map&lt;String,String&gt;`


##### `public clientCertName_x` → `String`


##### `public clientCert_x` → `String`


##### `public clientCertPasswd_x` → `String`


##### `public timeout_x` → `Integer`


##### `public SessionHeader` → `MetadataService`


##### `public DebuggingInfo` → `MetadataService`


##### `public DebuggingHeader` → `MetadataService`


##### `public CallOptions` → `MetadataService`


##### `public AllOrNoneHeader` → `MetadataService`


##### `private SessionHeader_hns` → `String`


##### `private DebuggingInfo_hns` → `String`


##### `private DebuggingHeader_hns` → `String`


##### `private CallOptions_hns` → `String`


##### `private AllOrNoneHeader_hns` → `String`


##### `private ns_map_type_info` → `String`


---
#### Methods
##### `public MetadataService.DeleteResult deleteMetadata(String type_x, String fullNames)`
##### `public MetadataService renameMetadata(String type_x, String oldFullName, String newFullName)`
##### `public MetadataService.SaveResult updateMetadata(MetadataService.Metadata metadata)`
##### `public MetadataService describeMetadata(Double asOfVersion)`
##### `public MetadataService checkDeployStatus(String asyncProcessId, Boolean includeDetails)`
##### `public MetadataService checkRetrieveStatus(String asyncProcessId, Boolean includeZip)`
##### `public MetadataService retrieve(MetadataService retrieveRequest)`
##### `public MetadataService cancelDeploy(String String_x)`
##### `public String deployRecentValidation(String validationId)`
##### `public MetadataService describeValueType(String type_x)`
##### `public MetadataService.SaveResult createMetadata(MetadataService.Metadata metadata)`
##### `public MetadataService deploy(String ZipFile, MetadataService DeployOptions)`
##### `public MetadataService readMetadata(String type_x, String fullNames)`
##### `public MetadataService.UpsertResult upsertMetadata(MetadataService.Metadata metadata)`
##### `public MetadataService.FileProperties listMetadata(MetadataService.ListMetadataQuery queries, Double asOfVersion)`
---

---
## Interfaces
### IReadResult
#### Methods
##### `public MetadataService.Metadata getRecords()`
---

### IReadResponseElement
#### Methods
##### `public IReadResult getResult()`
---

