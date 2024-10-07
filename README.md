# FetchProject
# Steps to Run the App
To run the app copy the code from the repository and press the start button this will launch the simulator and
launch the app.
To run the test cases for the app select Product > Test.

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I chose to focus on the User experience. I did this making sure that the errors for fetching were handled correctly
and by making sure that the app is refreshable in any state. I also added the ability for users to "favorite" their
favorite recipes to find them easier. I chose to focus on this area because I enjoy creating an intuitive experience for the user. Especially since a good experience means greater user adoption

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 5 hours working on the project. I spent time working on the main app feature first then I spent 
time working on the test cases. This took the most time because I had to figure out how to simulate the network calls 
and responses

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I used a ScrollView instead of a List to display all the recipes and make sure the screen is refreshable in any 
state the data is in. Scrollview has more flexibility when it comes to layout options. However, Scrollview doesn't 
have the built in swipe to delete feature like List does which is a drawback of this approach. 

# Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of the project is not sorting the list of recipes for favorites. I would like to have a recipe when 
"favorited" appear at the top of the list with any other favorites so that a users favorite recipes are even easier and quicker to locate

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?
I used the Kingfisher library to cache images on disk.

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I chose to simulate the network service to isolate the unit tests and ensure they work properly regardless of the actual api server working or not working. I used the actual test endpoints to make sure my app was showing the proper screens in different scenarios.
