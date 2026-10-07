-- Custom go snippets (mini.snippets format).
-- Placeholders: ${N:default}, ${0}, $TM_SELECTED_TEXT (visual selection).
return {
	{
		prefix = "version",
		body = [=[
package version

import (
	"fmt"
	"runtime"
)

var (
	Version   = "0.0.0"
	Commit    = "UNKNOWN"
	Package   = "github.com/alswl/toodledo"
	BuildDate = "UNKNOWN"
	GoVersion = runtime.Version()
)

func Message() string {
	const format = `toodledo:   %s (Revision: %s)
package:    %s
build date: %s
go version: %s
`
	return fmt.Sprintf(format, Version, Commit, Package, BuildDate, GoVersion)
}]=],
		desc = "version",
	},
}
