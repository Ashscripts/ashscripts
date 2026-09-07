$Space = Get-FreeDiskSpace -Drive 'C:'

If ($Space -le '5000')
{
	#if less than 5GB execute
}