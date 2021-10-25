# AzureForensics

This repo contains scripts I've written to aid in digital forensics and incident response processes in Microsoft's Azure cloud.

My scripts usually aren't intended to be copy/pasted and run as-is. They have configuration points you will need to define before you can use them in your environment.

### Useful Scripts
[Run-AzureVmMemoryCollection.ps1](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Run-AzureVmMemoryCollection.ps1) - this is a Windows PowerShell script which allows you to download a tools kit from an Azure Storage container, execute a full memory dump, and exfil the memory dump to an Azure Storage container. This allows you as a forensic analyst to actually obtain memory from a Windows Azure VM for analysis.

### HOW TO Documents
I also find it useful to write brief HOW TO documents. These primarily remind me how to use things, but I figure they'll also help other folks. I could put these on a blog or something somewhere but that's annoying when they could just all be right here with the scripts. Por que no los dos?

[HOW TO: Deploy Azure Custom Script Extensions](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/HOW%20TO%20-%20Deploy%20Azure%20Custom%20Script%20Extensions.md)

[HOW TO: Deploy Azure Run Command Extensions](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/HOW%20TO%20-%20Deploy%20Azure%20Run%20Command%20Extensions.md)

### Azure-Specific Forensic Artifacts
[FORENSIC ARTIFACTS: Azure Custom Script Extensions - Azure Portal Artifacts](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Azure%20Custom%20Script%20Extension%20Use.md#azure-portal-artifacts)

[FORENSIC ARTIFACTS: Azure Custom Script Extensions - Windows VM Artifacts]
(https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Azure%20Custom%20Script%20Extension%20Use.md#windows-vm-artifacts)

[FORENSIC ARTIFACTS: Azure Custom Script Extensions - Linux VM Artifacts]
(https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Azure%20Custom%20Script%20Extension%20Use.md#linux-vm-artifacts)

[FORENSIC ARTIFACTS: Azure Run Command Extensions - Azure Portal Artifacts](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Azure%20Run%20Command%20Extension%20Use.md#azure-portal-artifacts)

[FORENSIC ARTIFACTS: Azure Run Command Extensions - Windows VM Artifacts](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Azure%20Run%20Command%20Extension%20Use.md#windows-vm-artifacts)

[FORENSIC ARTIFACTS: Azure Run Command Extensions - Linux VM Artifacts](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Azure%20Run%20Command%20Extension%20Use.md#linux-vm-artifacts)

### Windows-Specific Forensic Artifacts
[FORENSIC ARTIFACTS: Attacker Source IP Identification With IPsec Audit Events](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Attacker%20Source%20IP%20Identification%20With%20IPsec%20Audit%20Events.md)

### Azure Information Summaries for Investigations and Hunting
[Azure Service Endpoints](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md) - these may help you in your reviews of firewall logs, DNS logs, local browser artifacts, and more to determine the origin of a file, what an application may have been communicating with, or to diff against to identify potential phishing or abuse of lookalike domains.

[Azure Resource Provider List](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Resource%20Provider%20List.txt) - these are good to reference against the [Azure Service Endpoints](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/Azure%20Endpoints.md) file so we can be on the same page about which endpoint corresponds to which Resource Provider in Azure. This is critical because you'll see the Resource Provider full names in most portal.azure.com URLs on your network.

### Windows Event ID Info
These are not just a regurgitation of the usual documentation found online. There's actual context here.

[FORENSIC ARTIFACTS: Windows Event 4653](https://github.com/AtomicGaryBusey/AzureForensics/blob/master/FORENSIC%20ARTIFACTS%20-%20Windows%20Event%204653.md)

### Use of Diverse DFIR Tools
The DFIR field has a lot of good folks, and a lot of good tools available, but they do tend to be widely scattered and in various states of usefulness. As a result I frequently utilize a plethora of tools for my work, and I am not always aware of all tools that could fulfill a particular need.

Some of my scripts may involve the use of closed-source tools that require payment to access. When this is the case I will make it clear in the script. As with any script there is a lot of flexibility, so in some cases a FOSS tool I haven't used or been aware of could work well for you and you can swap it into the script.

I do want to encourage you to support the developers of your favorite DFIR tools, whether they require payment, request optional payment, or produce them asking nothing in return. Support could mean:
1. Paying them fiat currency
2. Paying them in heavy metals
3. Offering goods or labor
4. Contributing to their work (code changes, feedback, etc.)
5. Evangelizing their work within your organizations
6. Buying them a beer/coffee/tea
7. Publicly giving them a shout-out
8. Sacks of jewels stolen from the Goblin King himself

There are many ways to express gratitude! Just don't ignore the hard work put into this stuff. We all stand on the shoulders of giants and must recognize that fact. :)
