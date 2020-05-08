# Overview

Azure maintains many FQDNs which serve as service endpoints for other things on the internet to talk to. The list is enormous and I've never seen a consolidated one before, so here one is. It'll be maintained on a best-effort basis.

These may come in handy for forensic analysis, phishing investigations, malware reverse engineering, red teaming / pentesting, and many other use cases.

For all these endpoints Microsoft maintains publicly-signed SSL certificates in the root which cascade down to all subdomains, so they will all appear to be trusted sites, even when the customer is hosting malicious content.

Endpoints for which the customer can define their own prefix (example: contoso.azurewebsites.net) are denoted with the following mark in the name: <*>

# Table of Contents

__Core Resource Providers__

1. [Microsoft.Compute](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftcompute) <*>
2. [Microsoft.ClassicCompute](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftclassiccompute) <*>
3. [Microsoft.Network](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftnetwork) <*>
4. [Microsoft.Storage](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftstorage) <*>

__Non-Core Resource Providers__

1. [Microsoft.AAD](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftaad)
2. [Microsoft.Cache/Redis](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftcacheredis) <*>
2. [Microsoft.Cdn](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftcdn) <*>
3. [Microsoft.CognitiveServices](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftcognitiveservices)
4. [Microsoft.ContainerInstance](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftcontainerinstance) <*>
5. [Microsoft.ContainerRegistry](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftcontainerregistry) <*>
6. [Microsoft.DataLakeStore](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftdatalakestore)  <*>
7. [Microsoft.DBforMySQL](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftdbformysql) <*>
8. [Microsoft.HDInsight](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsofthdinsight)
9. [Microsoft.KeyVault](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftkeyvault) <*>
10. [Microsoft.Kusto](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftkusto) <*>
11. [Microsoft.Media](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftmedia) <*>
12. [Microsoft.Portal](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftportal)
13. [Microsoft.Resources](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftresources)
14. [Microsoft.Search](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftsearch) <*>
15. [Microsoft.ServiceBus](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftservicebus)
16. [Microsoft.ServiceFabric](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftservicefabric)
17. [Microsoft.Sql](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftsql) <*>
18. [Microsoft.Web](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#microsoftweb) <*>

[API Endpoints](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#api-endpoints)

[Application Insights & Log Analytics Endpoints](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#application-insights--log-analytics-endpoints)

[Other - Pending Top-Level Categorization](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#other---pending-top-level-categorization)

[Source Material](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md#source-material)

## Azure Core Resource Providers

Azure's core Resource Providers are the three fundamental building blocks that everything else is built on:
* __Compute Resource Provider (CRP)__: Provides virtual machines (IaaS), service fabric clusters, and classic cloud services (PaaS)
* __Network Resource Provider (NRP)__: Provides public IP addresses, VNETs, VPN gateways, network security groups, and more
* __Storage Resource Provider (SRP)__: Provides blob, file, and other types of Storage

### Microsoft.Compute

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | ARM | *.cloudapp.azure.com |
| Government |  | *.cloudapp.usgovcloudapi.net |
| China |  | *.chinacloudapp.cn |

### Microsoft.ClassicCompute

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Classic (Cloud Service) | *.cloudapp.net |
| Government |  | *.cloudapp.usgovcloudapi.net |
| China |  | *.chinacloudapp.cn |

### Microsoft.Network

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Traffic Manager | *.trafficmanager.net |
| Government | Traffic Manager | *.usgovtrafficmanager.net |
| Germany | Traffic Manager | *.azuretrafficmanager.de |

### Microsoft.Storage

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Blob | *.blob.core.windows.net |
| Public | File | *.file.core.windows.net |
| Public | Table | *.table.core.windows.net |
| Public | Queue | *.queue.core.windows.net |
| Public | Static Website | *.web.core.windows.net |
| Government | Blob | *.blob.core.usgovcloudapi.net |
| Government | File | *.file.core.usgovcloudapi.net |
| Government | Table | *.table.core.usgovcloudapi.net |
| Government | Queue | *.queue.core.usgovcloudapi.net |
| Germany | Blob | *.blob.core.cloudapi.de |
| Germany | File | *.file.core.cloudapi.de |
| Germany | Table | *.table.core.cloudapi.de |
| Germany | Queue | *.queue.core.cloudapi.de |
| China | Blob | *.blob.chinacloudapi.cn |
| China | File | *.file.chinacloudapi.cn |
| China | Table | *.table.chinacloudapi.cn |
| China | Queue | *.queue.chinacloudapi.cn |

## Azure Non-Core Resource Providers

Azure has many other RPs that build on the Core RPs. For a full list see [Azure resource providers and types](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-supported-services).

### Microsoft.AAD

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Primary | *.login.windows.net |
| Public | Alternate | *.login.microsoftonline.com |
| Public | Alternate | secure.aadcdn.microsoftonline-p.com |
| Public | Alternate | auth.gfx.ms |
| Public | Microsoft Account (MSA) | login.live.com |
| Government | New | *.login.microsoftonline.us |
| Government | Old | *.login-us.microsoftonline.com |
| Germany |  | *.login.microsoftonline.de |
| China | Primary | *.login.chinacloudapi.cn |
| China | Alternate | *.login.partner.microsoftonline.cn |

### Microsoft.Cache/Redis

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.redis.cache.windows.net |
| Government |  | *.redis.cache.usgovcloudapi.net |
| Germany |  | *.redis.cache.cloudapi.de |
| China |  | *.redis.cache.chinacloudapi.cn |

### Microsoft.Cdn

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.azureedge.net |

### Microsoft.CognitiveServices

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | api.projectoxford.ai/face/v1.0 |
| China |  | api.cognitive.azure.cn/face/v1.0 |

### Microsoft.ContainerInstance

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.azurecontainer.io |

### Microsoft.ContainerRegistry

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.azurecr.io |
| Government |  | *.azurecr.us |

### Microsoft.DataLakeStore

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Data Lake Store | *.azuredatalakestore.net |

### Microsoft.DBforMySQL

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | MySQL | *.mysql.database.azure.com |
| China | MySQL | *.mysqldb.chinacloudapi.cn |

### Microsoft.HDInsight

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.azurehdinsight.net |
| China |  | *.azurehdinsight.cn |

### Microsoft.KeyVault

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.vault.azure.net |
| Government |  | *.vault.usgovcloudapi.net |
| Germany |  | *.vault.microsoftazure.de |
| China |  | *.vault.azure.cn |

### Microsoft.Kusto

Also known as "Azure Data Explorer"

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.kusto.windows.net |
| Government |  | *.kusto.usgovcloudapi.net |
| Germany |  | *.kusto.cloudapi.de |
| China |  | *.kusto.chinacloudapi.cn |

### Microsoft.Media

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.streaming.media.azure.net |
| Public | North America, Europe, Singapore, Hong Kong SAR, Japan | *.media.azure.net |
| Public | North America, Europe, Singapore, Hong Kong SAR, Japan | *.verifydns.media.azure.net |
| China |  | mediaservices.chinacloudapi.cn |
| China |  | verifydns.mediaservices.chinacloudapi.cn |

### Microsoft.Portal

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.portal.azure.com |
| Government |  | *.portal.azure.us |
| Germany |  | *.portal.microsoftazure.de |
| China |  | *.portal.azure.cn |

### Microsoft.Resources

| Cloud | Type | Domain |
| --- | --- | --- |
| Government |  | *.management.usgovcloudapi.net |
| Germany |  | *.management.microsoftazure.de |
| China |  | *.management.chinacloudapi.cn |

### Microsoft.Search

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.search.windows.net |

### Microsoft.ServiceBus

Also known as __Microsoft.NotificationHubs__

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.servicebus.windows.net |
| Government |  | *.servicebus.usgovcloudapi.net |
| Germany |  | *.servicebus.cloudapi.de |
| China |  | *.servicebus.chinacloudapi.cn |

### Microsoft.ServiceFabric

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.cloudapp.azure.com |
| Government |  | *.cloudapp.usgovcloudapi.net |
| China |  | *.chinaeast.chinacloudapp.cn |

### Microsoft.Sql

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Microsoft SQL | *.database.windows.net |
| Government | Microsoft SQL | *.database.usgovcloudapi.net |
| Germany | Microsoft SQL | *.database.cloudapi.de |
| China | Microsoft SQL | *.database.chinacloudapi.cn |

### Microsoft.Web

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Website | *.azurewebsites.net |
| Public | FTP(S) | *.azurewebsites.windows.net |
| Government |  | *.azurewebsites.us |


## API Endpoints

### Access Control Service

This service has been shut down as of November 7, 2018. 
* [How to: Migrate from the Azure Access Control Service](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-acs-migration)

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Shut Down | *.accesscontrol.windows.net |
| Public | Still Active | accounts.accesscontrol.windows.net |
| Government | Shut Down | *.accesscontrol.windows.net |
| Germany | Shut Down | *.microsoftonline.de |
| China | Shut Down | *.accesscontrol.chinacloudapi.cn |

### API / Classic Deployment Model

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | ARM | *.management.azure.com |
| Public | Classic | *.management.core.windows.net |
| Government |  | *.management.usgovcloudapi.net |
| Germany |  | *.management.core.cloudapi.de |
| China |  | *.management.core.chinacloudapi.cn |

### API Management

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | API Management Gateway | *.azure-api.net |
| Public | API Management ... Management | *.management.azure-api.net |
| Public | API Management Portal | *.portal.azure-api.net |
| Government | API Management Gateway | *.azure-api.us |
| Government | API Management ... Management | *.management.azure-api.us |
| Government | API Management Portal | *.portal.azure-api.us |
| China |  | *.chinacloudapi.cn |


## Application Insights & Log Analytics Endpoints

### Application Insights / Log Analytics

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Telemetry | dc.services.visualstudio.com |
| Public | Telemetry | dc.applicationinsights.microsoft.com |
| Public | Live Metrics Stream | rt.services.visualstudio.com |
| Public | Live Metrics Stream | rt.applicationinsights.microsoft.com |

### Application Insights Analytics

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Analytics Portal | analytics.applicationinsights.io |
| Public | CDN | applicationanalytics.azureedge.net |
| Public | Media CDN | applicationanalyticsmedia.azureedge.net |

### Application Insights API

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | API | api.applicationinsights.io |
| Public | API | api1.applicationinsights.io |
| Public | API | api2.applicationinsights.io |
| Public | API | api3.applicationinsights.io |
| Public | API | api4.applicationinsights.io |
| Public | API | api5.applicationinsights.io |
| Public | API Docs | dev.applicationinsights.io |
| Public | API Docs | dev.applicationinsights.microsoft.com |
| Public | API Docs | dev.aisvc.visualstudio.com |
| Public | API Docs | www.applicationinsights.io |
| Public | API Docs | www.applicationinsights.microsoft.com |
| Public | API Docs | www.aisvc.visualstudio.com |
| Public | Internal API | aigs.aisvc.visualstudio.com |
| Public | Internal API | aigs1.aisvc.visualstudio.com |
| Public | Internal API | aigs2.aisvc.visualstudio.com |
| Public | Internal API | aigs3.aisvc.visualstudio.com |
| Public | Internal API | aigs4.aisvc.visualstudio.com |
| Public | Internal API | aigs5.aisvc.visualstudio.com |
| Public | Internal API | aigs6.aisvc.visualstudio.com |

### Application Insights Azure Portal Extension

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Application Insights Extension | stamp2.app.insightsportal.visualstudio.com |
| Public | Application Insights Extension CDN | insightsportal-prod2-cdn.aisvc.visualstudio.com |
| Public | Application Insights Extension CDN | insightsportal-prod2-asiae-cdn.aisvc.visualstudio.com |
| Public | Application Insights Extension CDN | insightsportal-cdn-aimon.applicationinsights.io |

### Application Insights SDKs

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Application Insights JS SDK CDN | az416426.vo.msecnd.net |
| Public | Application Insights Java SDK | aijavasdk.blob.core.windows.net |

### Log Analytics API

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | API | api.loganalytics.io |
| Public | API | *.api.loganalytics.io |
| Public | API Docs | dev.loganalytics.io |
| Public | API Docs | docs.loganalytics.io |
| Public | API Docs | www.loganalytics.io |

### Log Analytics Portal

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Portal | portal.loganalytics.io |
| Public | CDN | applicationanalytics.azureedge.net |


## Other - Pending Top-Level Categorization

### Azure Active Directory Tenant Names

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.onmicrosoft.com |
| Government |  | *.onmicrosoft.com |
| Germany |  | *.onmicrosoft.com |
| China |  | *.partner.onmschina.cn |

### Cosmos DB

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.documents.azure.com |

### Database Import/Export Service

| Cloud | Type | Domain |
| --- | --- | --- |
| China | East | https://sh1prod-dacsvc.chinacloudapp.cn/dacwebservice.svc |
| China | North | https://bj1prod-dacsvc.chinacloudapp.cn/dacwebservice.svc |

### Database Management

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.management.database.windows.net |
| China |  | *.management.database.chinacloudapi.cn |

### Gallery

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.gallery.azure.com |
| Government |  | *.gallery.azure.us |
| Germany |  | *.gallery.cloudapi.de |

### Graph API

[National Cloud Deployments](https://docs.microsoft.com/en-us/graph/deployments)

| Cloud | Type | Domain |
| --- | --- | --- |
| Global |  | *.graph.microsoft.com |
| Public |  | *.graph.windows.net |
| Government | L4 | *.graph.microsoft.us |
| Government | L5 (DOD) | *.dod-graph.microsoft.us |
| Germany | Primary | *.graph.cloudapi.de |
| Germany | Alternate | *.graph.microsoft.de |
| China | Primary | *.graph.chinacloudapi.cn |
| China | Alternate | *.microsoftgraph.chinacloudapi.cn |

### LUIS Portal

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | luis.ai |
| Government |  | luis.azure.us |

### Nuget

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | NuGet Downloads | api.nuget.org |
| Public | NuGet Downloads | az320820.vo.msecnd.net |
| Public | NuGet Downloads | *.nuget.org |
| Public | NuGet Downloads | packages.nuget.org |

### Publish Settings File

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | portal.azure.com/#blade/Microsoft_Azure_ClassicResources/PublishingProfileBlade |
| Government |  | portal.azure.us#blade/Microsoft_Azure_ClassicResources/PublishingProfileBlade |
| Germany |  | manage.microsoftazure.de/publishsettings/index |

### Service Profiler

| Cloud | Type | Domain |
| --- | --- | --- |
| Public | Agent Prod | agent.azureserviceprofiler.net |
| Public | Agent Prod | *.agent.azureserviceprofiler.net |
| Public | Portal Prod | gateway.azureserviceprofiler.net |
| Public | Agent PPE | ppe.azureserviceprofiler.net |
| Public | Agent PPE | *.ppe.azureserviceprofiler.net |
| Public | Portal PPE | ppe.gateway.azureserviceprofiler.net |

### Visual Studio Online (VSO)

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  | *.visualstudio.com |
| Government |  |  |
| Germany |  |  |
| China |  |  |


## Source Material

All source material is located on docs.microsoft.com unless otherwise noted.

* [Azure Government Developer Guide](https://docs.microsoft.com/en-us/azure/azure-government/documentation-government-developer-guide)
* [Azure China Developer Guide](https://docs.microsoft.com/en-us/azure/china/resources-developer-guide)
* [Azure Germany Developer Guide](https://docs.microsoft.com/en-us/azure/germany/germany-developer-guide)
* [Identity in National Clouds](https://docs.microsoft.com/en-us/azure/active-directory/develop/authentication-national-cloud)
* [Authorization considerations for tenants hosted in the Germany, China or US Government environments](https://docs.microsoft.com/en-us/sharepoint/dev/solution-guidance/extending-sharepoint-online-for-germany-china-usgovernment-environments)
* [Azure Government Web + Mobile](https://docs.microsoft.com/en-us/azure/azure-government/documentation-government-services-webandmobile)
* [API Management REST](https://docs.microsoft.com/en-us/rest/api/apimanagement/apimanagementrest/api-management-rest)
* [Domains FAQ](https://docs.microsoft.com/en-us/office365/admin/setup/domains-faq?view=o365-worldwide#why-do-i-have-an-onmicrosoftcom-domain)
* [Streaming Endpoints](https://docs.microsoft.com/en-us/azure/media-services/latest/streaming-endpoint-concept)
* [IP addresses used by Application Insights and Log Analytics](https://docs.microsoft.com/en-us/azure/azure-monitor/app/ip-addresses)
* [Troubleshoot network connections and lists of allowed addresses](https://docs.microsoft.com/en-us/azure/devops/organizations/security/faq-network-connections?view=azure-devops)
* [Safelist the Azure portal URLs on your firewall or proxy server](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-safelist-urls)

* NOT docs.microsoft.com: [Full List of Azure Resource Providers](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Resource%20Provider%20List.txt)

### Table Template

| Cloud | Type | Domain |
| --- | --- | --- |
| Public |  |  |
| Government |  |  |
| Germany |  |  |
| China |  |  |
