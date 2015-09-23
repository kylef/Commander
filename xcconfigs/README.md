# xcconfigs for Universal Frameworks

> Build iOS, OS X and watchOS frameworks on base of one target.

If you maintain a framework on multiple platforms, you usually have to duplicate your framework target. Normally you have to maintain all build settings in two or more places, and then you have to duplicate the target membership lists for all source code files and build phases.

This project intends to aggregate common or universal Xcode configuration settings, specifically for frameworks. Keeping them in hierarchical Xcode configuration files for easy modification and reuse. All build settings for platform-specific values are scoped by conditional variable assignments. This means you can have one framework target and select at build time, which platform it should be build against and the right default build settings are selected automatically.

## Usage

### Manual Integration

1. `$ git submodule add https://github.com/mrackwitz/xcconfigs.git xcconfigs`
* Drop the files into the root group of your framework target.
* Make sure to check `Create groups` instead of `Create folder references`
* Select the project in the file navigator
* Select the project in the left pane of the project editor
* Select the Info tab
* Expand the Configurations pane, if needed
* Expand `Debug`, `Release` and further configurations, if present
* Select `UniversalFramework_Framework` for your framework target
* Select `UniversalFramework_Test` for your test target of your framework target

### Carthage

Carthage supports universal frameworks on master.
