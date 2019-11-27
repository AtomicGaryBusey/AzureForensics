# FORENSIC ARTIFACTS: Azure Custom Script Extension Use

## Azure Portal Artifacts
Audit logs from the Azure platform itself can be found in the VM's "Activity Logs" in the Azure Portal. The events you're looking for are named "Create or Update Virtual Machine Extension". The JSON details contain details on when the job was executed, who did it, what the payload was, and other useful bits.

The "Create or Update Virtual Machine Extension" events can be alerted on via Health Alerts config or by using Azure Security Center.


## Windows VM Artifacts
When a Custom Script Extension (CSE) run is submitted via the Azure front door (Portal / API / PowerShell) to run on a Windows machine several things happen:

1. The script is uploaded to an Azure Storage account associated with Azure Compute.
2. The Azure Guest Agent on the VM installs the CSE application and supporting files to: C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\
3. The script uploaded to Storage is downloaded to the VM by the Guest Agent.
4. CustomScriptHandler.exe executes the instructions passed to it (i.e. the PowerShell script and any supplied arguments.)

These are the artifacts that contain relevant data for an investigation:

### File System
* The script in step 4 can be found in: C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\version_number\Downloads\\#\
* This same folder is where all files and folders created as part of the script execution will be found.
* C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\version_number\Status\ contains files named #.status where # matches the extension folder number in Downloads. This is effectively a runtime log.
* C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\version_number\RuntimeSettings\ contains files named #.settings where # matches the extension folder number in Downloads. This is a config file that contains among other things the SAS URI for the uploaded script.
* C:\WindowsAzure\Logs\Plugins\Microsoft.Compute.CustomScriptExtension\version_number\ contains runtime logs for the CSE app itself.
* If the CSE is deleted from the VM via the Azure front door then the Guest Agent will delete the entire Microsoft.Compute.CustomScriptExtension folder from C:\Packages\Plugins\ and all its contents. Since TRIM is in use on Windows VMs in Azure, there is risk that no file data itself will be left behind on disk.

### Event Logs
* If you have 4688 command line and PowerShell script audit logging enabled then you should be able to pull the script and other details about the run from it.
* An example PowerShell event is Event 403: _HostApplication=powershell -ExecutionPolicy Unrestricted -File Run-AzureVmMemoryCollection.ps1_
* The Azure Guest Agent writes events to the __Microsoft -> WindowsAzure -> Status -> Plugins__ Event log, found here on disk: %SystemRoot%\System32\Winevt\Logs\Microsoft-WindowsAzure-Status%4Plugins.evtx - Event ID 7 will show you installation, maintenance, and removal of the CustomScriptExtension plugin. This should not appear in the Event logs of a VM which has never had CSEs deployed.

**CAUTION** If the script contains instructions to delete the files then only the script itself will still be found on disk. However, the script will still contain the deletion commands so you can at least know what was deleted.

**CAUTION** CustomScriptHandler.exe runs as SYSTEM and so the PowerShell script and any processes created by it will also be run as SYSTEM.





