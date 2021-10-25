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


## Linux VM Artifacts
When a Custom Script Extension (CSE) execution is submitted via the Azure front door (Portal / API / PowerShell) to run on a Linux machine several things happen:

1. The script is uploaded to an Azure Storage account associated with Azure Compute.
2. The Azure Guest Agent on the VM installs the CustomScript application and supporting files to:  /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/
3. The script uploaded to Storage is downloaded to the VM by the Guest Agent.
4. The following executables can be used to execute the instructions passed to it (i.e. the shell script script and any supplied arguments.)
* /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/bin/custom-script-extension
* /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/bin/custom-script-extension-arm64
* /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/bin/custom-script-shim is not an executable but is a shell script you can examine to understand exactly how the CSE application is invoked and how it makes the choice to use the 32-bit or 64-bit binaries.

These are the artifacts that contain relevant data for an investigation:

### File System
* The script in step 3 can possibly be found in: /var/lib/waagent/custom-script/download/#/ and will be named "script#.sh" where # is the number assigned by Azure, which denotes the order it was generated in. The first script run will be "0" and have no number, simply written as "script.sh". Unfortunately, there have been mixed results and the script file itself is not always left behind in this directory.
* The file /var/lib/waagent/custom-script/download/#/stdout contains the output of the CSE execution which was presented via the console to the user which originated it. This is the basic output as presented by the system.
* The files in /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/status/ contains files named #.status which contain the output of the CSE execution which was presented via the console to the user which originated it. This is the full output enriched and passed back to Azure by the agent.
* The file /var/lib/waagent/custom-script/download/#/stderr contains the any errors encounteres during the Run Command execution. This may be useful to gain insight into actor fumbling or goals and to differentiate between automated action and hands-on-keyboard.
* The /var/lib/waagent/custom-script/ and /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/ directories are where all files and dirs created as part of the script execution will be found.
* /var/log/azure/Microsoft.Azure.Extensions.CustomScript/CommandExecution.log is the CSE a runtime log.
* /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/config/ contains files named #.settings where # matches the extension folder number in Downloads. This is a config file which appears to have base64 encoding of payload source and a certificate thumbprint in it.
* /var/log/azure/custom-script/ contains install and runtime logs for the CSE app itself.
* If the CSE is deleted from the VM via the Azure front door then the Guest Agent will delete the entire /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/bin/ directory and all its contents. Since TRIM is in use on VMs in Azure, there is risk that no file data itself will be left behind on disk.

### Event Logs
* You'll see log entries for the execution of the Run Command Extension throughout /var/log/syslog, including:
* Oct 25 20:13:27 vmhostname python3[1103]: 2021-10-25T20:13:27.907284Z INFO ExtHandler [Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER] Executing command: /var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER/bin/custom-script-shim enable with environment variables: {"AZURE_GUEST_AGENT_UNINSTALL_CMD_EXIT_CODE": "NOT_RUN", "AZURE_GUEST_AGENT_EXTENSION_PATH": "/var/lib/waagent/Microsoft.Azure.Extensions.CustomScript-VERSION.NUMBER", "AZURE_GUEST_AGENT_EXTENSION_VERSION": "VERSION.NUMBER", "AZURE_GUEST_AGENT_WIRE_PROTOCOL_ADDRESS": "#.#.#.#", "ConfigSequenceNumber": "0", "AZURE_GUEST_AGENT_EXTENSION_SUPPORTED_FEATURES": "[{\"Key\": \"ExtensionTelemetryPipeline\", \"Value\": \"1.0\"}]"}
* The Azure Guest Agent writes events to the waagent.log file, found here on disk: /var/log/waagent.log

**CAUTION** If the script contains instructions to delete the files then only the script itself will still be found on disk. However, the script will still contain the deletion commands so you can at least know what was deleted.

**CAUTION** custom-script-extension and custom-script-shim run as root and so the shell script and any processes created by it will also be run as root.


