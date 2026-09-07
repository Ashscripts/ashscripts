#attemting to disable update check
                $SourceFile = "$($adtSession.DirFiles)\Preferences.sublime-settings"
                $OverwriteExisting = $true
                $UserProfileRoot = "C:\Users"
                $ExcludedProfiles = @(
                    "Default",
                    "Default User",
                    "Public",
                    "All Users",
                    "defaultuser0"    
                )

                $profiles = Get-ChildItem -Path $UserProfileRoot -Directory -ErrorAction SilentlyContinue

                foreach ($profile in $profiles) {
                if ($ExcludedProfiles -contains $profile.Name) {        
                        continue
                    }
                    $userProfilePath = $profile.FullName

                    $targetDir = Join-Path -Path $userProfilePath -ChildPath "AppData\Roaming\Sublime Text\Packages\User" -ErrorAction SilentlyContinue
                    $targetFile = Join-Path -Path $targetDir -ChildPath "Preferences.sublime-settings" -ErrorAction SilentlyContinue

                    if (-not (Test-Path -Path $targetDir -PathType Container)) {
                            New-Item -Path $targetDir -ItemType Directory -Force -ErrorAction SilentlyContinues
                        }
                        
                        if ((-not (Test-Path -Path $targetFile -PathType Leaf)) -or $OverwriteExisting) {            
                            Copy-Item -Path $SourceFile -Destination $targetFile -Force -ErrorAction SilentlyContinue
                        }
                     }