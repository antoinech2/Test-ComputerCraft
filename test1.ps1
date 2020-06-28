
$interval = 10

while ($true)
{
	$endtime = (get-date).AddSeconds($interval)
	while ((get-date) -le $endtime)
	{
		#$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
		#Write-Output "X:" $x;
		
		#Write-Output "enditime:$endtime";
		# lire les entrées clavier :
		if ([System.Console]::KeyAvailable)
		{
			$key = [System.Console]::ReadKey($true)
			Write-Output "key:" $key.Key;
			# intercepter CTRL+C :
			if (($key.Modifiers -band [System.ConsoleModifiers]"control") -and ($key.Key -eq "C"))
			{
				# interrompre le script : 
				exit
			}  # fin du if (($key.Modifiers ...

			# si autre touche, abréger l'attente :
			else
			{
				break
			}  # fin du else
		}  # fin du if ([System.Console]::KeyAvailable)
	}  # fin du while ((get-date) -le $endtime)
}
