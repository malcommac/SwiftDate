sourcery --sources Tests --templates .sourcery/LinuxMain.stencil --output .sourcery --force-parse generated
mv .sourcery/LinuxMain.generated.swift Tests/LinuxMain.swift
