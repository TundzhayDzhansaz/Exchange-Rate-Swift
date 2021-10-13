## Tasks

- Allow entering a base currency on the home screen from a list of currencies by searching
- Show live exchange rates using the [exchange rates API](https://exchangerate.host/) (the order of the currencies does not matter) based on the selected base currency
- Implement a detail-view for each exchange rate displaying historical data of the last 52 weeks
- Allow marking a currency as favorite in the details view and show the favorites on the very top of the list
- Persist the entered base currency and favorites
- If you have time left: Surprise us! Add a feature that you think would work well here (for instance, allow selecting a different timespan in the details view)
- Make sure to include all source code in this repository.

For iOS, include a assignment.zip file containing your compressed .app bundle in the root of the repository. Your .app bundle must represent a simulator build of your app. After running in iOS Simulator via Xcode, look in ~/Library/Developer/Xcode/DerivedData/<project-name>/Build/Products/Debug-iphonesimulator/. Alternatively, you may run xcodebuild -sdk iphonesimulator (if you use .xcodeproj) or xcodebuild -sdk iphonesimulator -workspace Sample.xcworkspace/ -scheme <your-scheme> -configuration Debug (if you use .xcworkspace) in your project directory, then zip the .app bundle in build/Debug-iphonesimulator/.

## Evaluation Criteria

- iOS + SwiftUI best practices
- Architecture and Scalability: is it laid out in a scalable way and uses common patterns in mobile development?
- Correctness: does the functionality act in sensible, thought-out ways?
- Maintainability: is it written in a clean, maintainable way?
- Testing: is the system adequately tested?
- We're looking for you to produce working code, with enough room to demonstrate how to structure components in a small program

It is not important to aim for 100% completeness. We prefer well-built, tested, and scalable features over half-baked solutions.


## DeveloperComment
Project need to parse of JSON. You can find there easly getData( ) function. With use that function we need to parse data for name and rates.

