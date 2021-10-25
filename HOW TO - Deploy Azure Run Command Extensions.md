# HOW TO: Deploy Azure Run Command Extensions

Deploying a PowerShell script as a Run Command Extension to an IaaS VM in Azure is a pretty simple operation.

1. Log into the Azure Portal.
2. Navigate to your target Virtual Machine.
3. Click "Run Command".
4. Choose your option from one of the pre-defined commands or a custom one.
5. Assuming you choose "RunPowerShellScript" or "RunShellScript" it'll upload to CRP storage for you.
6. Click OK.
7. Wait for completion while Azure pulls the script into the VM. You can check the runtime status to see if it's still going.

The run will still say "in progress" until your application of choice has completed its work. The whole script and all sub-processes must exit before the run is considered complete.

Once complete, you'll see output returned to the terminal window in your web browser if you're using the Azure Portal, or to your CLI/PowerShell session if using those methods.

If you're having trouble seeing exactly what I mean by "Run Command Extension" you can go directly here to get a better idea: https://ms.portal.azure.com/#@YOUR.TENANT.NAME/resource/subscriptions/YOUR.SUB.GUID./resourceGroups/YOUR.RG.NAME/providers/Microsoft.Compute/virtualMachines/YOUR.VM.NAME/runcommands

Additional resources for deep diving into this topic are available here:
* [Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/run-command)
* [Linux](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/run-command)
