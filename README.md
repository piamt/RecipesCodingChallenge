# RecipeCodingChallenge

## Requirements
The task consists on creating a simple app for searching recipes.

- The user should be allowed to enter a search phrase, then tapp on a "search" button to start the search
- Search results should be presented in a list with the name of the recipe and an image
- No need to implement pagination

[Link to the API used for the exercise](https://developer.edamam.com)

## Acceptance criteria
- The app is correctly presenting the searched recipes
- Write at least 1 unit test
- Write at least 1 UI test

## Tech stack
- SwiftUI
- MVVM
- Async/await
- Target device: iPhone

## Testing
- Added some Unit Tests to the view model and repository with XCTest framework.  
- Added a UI test to launch the project and make a search with a mocked repository.

## Decissions
I created a structure to divide the project in different layers: Presentation, Domain and Data.  

1. In the presentation layer, find the views and view models. Also some extensions, subviews and view modifiers.
2. In the Domain layer, find the use cases, repositories and models mainly. 
3. In the Data layer, find the data sources and API Services (Endpoints declaration, URLSession implementation, etc.)

## Next steps
- Add missing HTTP methods to the API Services
- Use Cloudkit to save sensitive data
- Adding more tests to improve the test coverage
- Implement pagination
