## Tasks

- Allow entering a base currency on the home screen from a list of currencies by searching
- Show live exchange rates using the [exchange rates API](https://exchangerate.host/) (the order of the currencies does not matter) based on the selected base currency
- Implement a detail-view for each exchange rate displaying historical data of the last 52 weeks
- Allow marking a currency as favorite in the details view and show the favorites on the very top of the list
- Persist the entered base currency and favorites
- If you have time left: Surprise us! Add a feature that you think would work well here (for instance, allow selecting a different timespan in the details view)
- Make sure to include all source code in this repository.

For iOS, include a assignment.zip file containing your compressed .app bundle in the root of the repository. Your .app bundle must represent a simulator build of your app. After running in iOS Simulator via Xcode, look in ~/Library/Developer/Xcode/DerivedData/<project-name>/Build/Products/Debug-iphonesimulator/. Alternatively, you may run xcodebuild -sdk iphonesimulator (if you use .xcodeproj) or xcodebuild -sdk iphonesimulator -workspace Sample.xcworkspace/ -scheme <your-scheme> -configuration Debug (if you use .xcworkspace) in your project directory, then zip the .app bundle in build/Debug-iphonesimulator/.


## DeveloperComment
This project written with UIKit.

![Screenshot](https://github.com/TundzhayDzhansaz/Exchange-Rate-Swift/blob/main/Screens/Screenshot1.png)