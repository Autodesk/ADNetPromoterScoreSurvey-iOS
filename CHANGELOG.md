# ADNetPromoterScoreSurvey Release Notes

##### Version 2.1.1
* Add option to set a base color of an NPSAppearnce [#12](https://github.com/Autodesk/ADNetPromoterScoreSurvey-iOS/pull/12) 

##### Version 2.1.0
* Swift 5.0 Support
* Fix Issue [#2](https://github.com/Autodesk/ADNetPromoterScoreSurvey-iOS/issues/2) - Some properties are unaccessible in Objective-C.
* `currentSelectedScore` property under `ADNetPromoterScoreSurvey` is not `nullable` anymore to support objective-c. In case no user selection the value will be `-1`
* Fix Issue [#9](https://github.com/Autodesk/ADNetPromoterScoreSurvey-iOS/issues/9) - Feedback Question View Is not align to the safe area.


##### Version 2.0.0
* specify swift_version parameter in podspec file
* minimum required cocoapods version is now 1.4.0
* Swift 4.0 Support

##### Version 1.0.0
* Initial release.
