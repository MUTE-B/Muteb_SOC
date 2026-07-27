rule MUTEB_Suspicious_File_Detection
{
    meta:
        author = "MUTEB ALBALAWI"
        description = "Detect suspicious file patterns"
        version = "1.0"

    strings:
        $shell1 = "/bin/bash"
        $shell2 = "/bin/sh"
        $net1 = "curl"
        $net2 = "wget"

    condition:
        any of them
}
