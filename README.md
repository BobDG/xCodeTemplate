# xCodeTemplate
A startup xCode template project that you can re-use for every project containing several brillant tools/settings


# Setup

## General
1. Open template.xcworkspace
2. Tap top-left Template - change name to your project name
3. Tap podfile, change target name from Template to your target name
4. Exit xCode and in Finder change the name of xcworkspace from template.xcworkspace to the same name as your .xcodeproj
5. Open terminal, cd to correct folder and run 'pod update'
6. Open xCode again
7. Tap project target, change bundleID
8. Tap on top-left scheme, manage schemes and change necessary screen names

## CoreData
1. CoreData - change xdatamodeld name to the name you want
2. CoreData - in BDGCoreData.m - change the name in 'init' to the database file name
3. Tap on target MoGenerator - Build phases - Run script -> change the name to the new database file name

## HockeyApp
1. In info-plist, change the 'HockeyApp' to the correct HockeyAppID