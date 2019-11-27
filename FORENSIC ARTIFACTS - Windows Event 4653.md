# Windows Event 4653: An IPsec Main Mode negotiation failed

Security Event 4653 occurs when an IPsec Main Mode negotion fails between a source machine and a target machine. This event is forensically rich in some investigations due to its potential to contain attacker IP addresses that are otherwise not captured in any other Windows events.

Enabling IPsec audit events requires an audit configuration change, either made locally or through Active Directory Group Policy. More information is available from Microsoft here: [Audit IPsec Main Mode](https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/audit-ipsec-main-mode).

This is an example of an event that was created originally to provide diagnostic information for technical network issues that can be dual-purposed for security detections, incident response, and forensic analysis.

## Scenarios Where Event 4653 May Be Relevant
[FORENSIC ARTIFACTS: Attacker Source IP Identification With IPsec Audit Events](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS:%20Attacker%20Source%20IP%20Identification%20With%20IPsec%20Audit%20Events.md)

## Simplified Event Payload from Ultimate Windows Security
Source: [Ultimate Windows Security: Windows Security Log Event ID 4653](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4653)
```
Local Endpoint:
   Local Principal Name: %1
   Network Address: %3
   Keying Module Port: %4
Remote Endpoint:
   Principal Name:  %2
   Network Address: %5
   Keying Module Port: %6
Additional Information:
   Keying Module Name: %7
   Authentication Method: %10
   Role:   %12
   Impersonation State: %13
   Main Mode Filter ID: %14
Failure Information:
   Failure Point:  %8
   Failure Reason:  %9
   State:   %11
   Initiator Cookie:  %15
   Responder Cookie: %16
```

## XML Payload

```xml
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
	<System>
		<Provider Name="Microsoft-Windows-Security-Auditing" Guid="{54849625-5478-4994-a5ba-3e3b0328c30d}" /> 
		<EventID>4653</EventID> 
		<Version>0</Version> 
		<Level>0</Level> 
		<Task>12547</Task> 
		<Opcode>0</Opcode> 
		<Keywords>0x8010000000000000</Keywords> 
		<TimeCreated SystemTime="YYYY-MM-DDTHH:MM:SS.SSSSSSSSSZ" /> 
		<EventRecordID>#</EventRecordID> 
		<Correlation ActivityID="{GUID}" /> 
		<Execution ProcessID="###" ThreadID="####" /> 
		<Channel>Security</Channel> 
		<Computer>hostname.fqdn.tld</Computer> 
		<Security /> 
	</System>
	<EventData>
		<Data Name="LocalMMPrincipalName">%1</Data> 
		<Data Name="RemoteMMPrincipalName">%2</Data> 
		<Data Name="LocalAddress">%3</Data> 
		<Data Name="LocalKeyModPort">%4</Data> 
		<Data Name="RemoteAddress">%5</Data> 
		<Data Name="RemoteKeyModPort">%6</Data> 
		<Data Name="KeyModName">%7</Data> 
		<Data Name="FailurePoint">%8</Data> 
		<Data Name="FailureReason">%9</Data> 
		<Data Name="MMAuthMethod">%10</Data> 
		<Data Name="State">%11</Data> 
		<Data Name="Role">%12</Data> 
		<Data Name="MMImpersonationState">%13</Data> 
		<Data Name="MMFilterID">%14</Data> 
		<Data Name="InitiatorCookie">%15</Data> 
		<Data Name="ResponderCookie">%16</Data> 
	</EventData>
</Event>
```
