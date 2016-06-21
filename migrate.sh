#!/bin/bash

set -e
set -x

DIR=`pwd`
GOROOT=`go env GOROOT`

cd $GOROOT/src/cmd/go
cp -f main.go $DIR
	cp -f get.go  $DIR
		cp -f build.go $DIR
			cp -f note.go $DIR
			cp -f signal.go $DIR
				cp -f signal_unix.go $DIR
			cp -f tool.go $DIR
			cp -f test.go $DIR
				cp -f testflag.go $DIR
				cp -f run.go $DIR
			cp -f zdefaultcc.go $DIR
		cp -f pkg.go  $DIR
		cp -f vcs.go  $DIR
			cp -f -r $GOROOT/src/internal/singleflight $DIR
			cp -f http.go  $DIR
			cp -f discovery.go  $DIR
	cp -f go11.go $DIR
	cp -f env.go $DIR
cd $DIR

gofmt -w -r '[]*Command{
	cmdBuild,
	cmdClean,
	cmdDoc,
	cmdEnv,
	cmdFix,
	cmdFmt,
	cmdGenerate,
	cmdGet,
	cmdInstall,
	cmdList,
	cmdRun,
	cmdTest,
	cmdTool,
	cmdVersion,
	cmdVet,

	helpC,
	helpBuildmode,
	helpFileType,
	helpGopath,
	helpEnvironment,
	helpImportPath,
	helpPackages,
	helpTestflag,
	helpTestfunc,
} -> []*Command{cmdGet}' main.go

gofmt -w -r 'flag.Args() -> append([]string{"get"}, os.Args[1:]...)' main.go
gofmt -w -r 'flag.Parse() -> func(){}()' main.go

gofmt -w -r '"internal/singleflight" -> "h12.me/gogetx/singleflight"' vcs.go

go build
