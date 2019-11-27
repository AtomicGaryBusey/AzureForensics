# Attacker Source IP Identification With IPsec Audit Events

**NOTE:** This information is relevant to Windows and does not apply to *nix systems.

It can be difficult without network telemetry, such as IPFIX or packet captures, 
to determine the true source of an attack when the attacker is using a reverse shell, 
such as the capability built into Cobalt Strike. If you have no network telemetry 
available, and no memory or process dumps, you may still be able to obtain a true 
source IP address with only artifacts available on disk.

## Event 4653 Evidence

The key event I've found to be useful is [Windows Event 4653](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS:%20Windows%20Event%204653.md). 
Clicking the link will give you a write-up I made containing full details on the event and its contents.

The relevant field in Event 4653 is "Network Address" under "Remote Endpoint", detailed in the XML payload as:
```xml
<Data Name="RemoteAddress">%IpAddress</Data> 
```

Here's an example of what it'll look like in the Windows Event Viewer provided by Microsoft:

![A screenshot showing the relevant portion of a Windows 4653 Event.](https://raw.githubusercontent.com/AtomicGaryBusey/AzureForensics/master/Event4653IPsecScreenshot.png)

## How This Works

If the target computer prefers IPSec and the attacker computer does not have IPsec configured, 
a negotiation failure occurs, triggering Event 4653 to be logged. It is noteworthy that the 
Remote Endpoint IP address listed in these events is actually the real IP address of the person 
connecting to the shell; all other RDP events will show the masking IP address. The 
negotiation is actually happening with the source (attacker) IP.

4653 will continually populate as the target machine keeps trying to negotiate with the 
attacking machine, which means:
* It serves as an effective record of session length (though RDP session reconnect/disconnect events will as well).
* It will show you the attacker's true IP address if they change IPs and/or computers.

**NOTE:** This will not work if you do not have IPsec enabled, or if you do not have IPsec Auditing enabled.

## Comorbid Events

1. [Security Event 4624](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4624): A Type 10 logon will show RDP use. The remote IP address in some reverse shell situations will not show the true remote address, but it will often give you a true attacker hostname.
2. [Security Event 4688](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4688): Shows execution of attacker applications.
_Requires an Audit configuration to be enabled locally or via Active Directory Group Policy._
3. [Security Event 4688 with Command-Line Logging](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/manage/component-updates/command-line-process-auditing): Shows the commands the attacker ran through the command shell (cmd.exe).
_Requires an Audit configuration to be enabled locally or via Active Directory Group Policy._
4. [Security Event 4698](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4698): Scheduled Task creation can show installation of a persistence mechanism to keep a shell alive.
5. [Security Event 4779](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4779): Shell'd RDP session disconnect events will show the true attacker hostname, but not the true attacker IP.
6. [System Event 7045](https://www.manageengine.com/products/active-directory-audit/kb/system-events/event-id-7045.html): Installation of Services that keep a shell alive even if the process is terminated.
7. [Security Event 4697](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4697): Similar to System Event 7045, just in the Security Event provider instead of System. More details available from Microsoft [here](https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4697).
8. PowerShell-related Events: The [Windows PowerShell Logging Cheat Sheet](https://www.malwarearchaeology.com/s/Windows-PowerShell-Logging-Cheat-Sheet-ver-Sept-2018-v22.pdf) is a good resource detailing the possible places PowerShell artifacts can be found. PowerShell can be used to create a reverse shell. An example is here: [reverse.powershell](https://github.com/trustedsec/social-engineer-toolkit/blob/master/src/powershell/reverse.powershell) 

## Possibly Valuable Events

1. [Security Event 4652](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4652): This is another IPsec Main Mode negotiation failed event. This event contains details on remote and local certificates, which Event 4652 does not contain. I have not yet seen this as usable evidence in a real investigation yet.
