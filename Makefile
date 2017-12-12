SWIFTC=swiftc
PARAM = COMMANDER_SWIFTPM_DEVELOPMENT=YES

ifeq ($(shell uname -s), Darwin)
XCODE=$(shell xcode-select -p)
SDK=$(XCODE)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk
TARGET=x86_64-apple-macosx10.10
SWIFTC=swiftc -target $(TARGET) -sdk $(SDK) -Xlinker -all_load
endif

build:
	@$(PARAM) swift build

test:
	@$(PARAM) swift test

Examples/%: build
	@echo "Building example $*"
	@$(SWIFTC) -o "Examples/$*" \
		"Examples/$*.swift" \
		-I.build/debug \
		-Xlinker .build/debug/Commander.a

examples: Examples/hello Examples/pod
