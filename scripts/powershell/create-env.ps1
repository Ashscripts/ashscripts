$VarNameRS  = "RS_TRUSTSERVERCERTIFICATE"
        $VarValueRS = "TRUE"

        [System.Environment]::SetEnvironmentVariable(
            $VarNameRS,
            $VarValueRS,
            [System.EnvironmentVariableTarget]::Machine
        )
