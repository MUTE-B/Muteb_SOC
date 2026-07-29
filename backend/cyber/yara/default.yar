
rule MUTEB_Suspicious_File

{

strings:

$a="powershell"

$b="cmd.exe"


condition:

$a or $b

}

