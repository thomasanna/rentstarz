SocialEngine PHP v4
==========================
This is the main Git repository of SocialEngine PHP v4.

## Main Release Process


1. Checkout the previous tag in a separate directory. e.g. engine4-460
2. Perform a recursive diff between the engine4 and the tag directory. On Windows, WinMerge works great. Meld works for Linux.
3. For each of the packages (application/libraries/* application/modules/* application/themes/* application/widgets/* externals/* application/settings/ install/config etc):
  * If files were modified, increment the version.
  * For modules, increment the version in both settings/my.sql and manifest.php. Typically I increment the version to the current main release version, as opposed to incrementing them following SemVer individually.
  * If requirements for the package changed, modify them in the manifest
  * For all package types except modules, add the changelog to the manifest.php
4. For modules, run php development/build_changelog_skeleton.php to generate a list of changed files. They'll be added to settings/changelog.php with added/removed/different. Replace the messages with a more descriptive message.
5. For modules, a special sql file needs to be made to apply any database changes in the format {previousVersion}-{newVersion} See any of the existing modules settings folders for reference.
6. Commit the changed files to subversion
7. Run php development/build_distribution_git.php It should prompt you for some information. Note that it was developed using GnuWin32 and there was an issue with the tar command on OS X and the tar library we use.
8. Packages should be output into {outputDir}/release
9. Test an upgrade and a full install
10.	Delete any packages for which the version did not change
11.	Upload the files to the se4-downloads bucket on our s3 account
12.	Edit each product in the awesome panel to have the correct version

## Theme Release Process

1. If any themes were changed, they must be released separately.
2. The theme packages will be output into {outputDir}/(some other folder)
3. Tar them into one file (make sure they're in the root directory of the tar, OS X's program will not work correctly, command line might work, 7-zip works fine)
4. Upload them to the correct KB article on support.socialengine.com: [http://support.socialengine.com/questions/215/Updating-Themes](http://support.socialengine.com/questions/215/Updating-Themes)

## Trial Release Process

1. Install the ionCube Encoder (need the command line tools)
2. Run php development/build_trial_encrypted.php
3. Test it
4. Upload to the downloads bucket on our s3 account
5. Edit the trial filename in the awesome panel under System Settings
