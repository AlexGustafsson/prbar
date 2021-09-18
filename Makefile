# Disable echoing of commands
MAKEFLAGS += --silent

# Always use clang, no matter if GCC is configured
CXX=clang
CPP=clang
CC=clang

.PHONY: build lint format logs clean

build: build/prbar.app

build/prbar.app: build/prbar/release/prbar
	mkdir -p build/prbar.app/Contents/MacOS
	cp build/prbar/release/prbar build/prbar.app/Contents/MacOS
	cp SupportingFiles/prbar/Info.plist build/prbar.app/Contents

build/prbar/release/prbar: Sources/prbar/main.swift Sources/prbar/AppDelegate.swift Sources/prbar/Menu.swift
	swift build --configuration release --product "prbar" --build-path "build/prbar"

# Lint all Swift code
# Requires swiftformat: brew install swiftformat
lint:
	swiftformat --lint --verbose --config .swiftformat --cache ignore .

# Format all Swift code
# Requires swiftformat: brew install swiftformat
format:
	swiftformat --config .swiftformat --cache ignore .

# Tail logs produced by prbar
logs:
	log stream --info --debug --predicate 'subsystem BEGINSWITH "se.axgn.prbar" || (eventMessage CONTAINS "prbar" && messageType IN {16, 17})'

# Remove all dynamically created files
clean:
	rm -rf build distribution &> /dev/null || true
